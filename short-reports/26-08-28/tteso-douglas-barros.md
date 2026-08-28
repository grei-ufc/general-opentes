---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Reprodução completa das figuras da tese e correção dos defeitos que elas
  expuseram na atuação do Agente de Mercado.
title: "[OpenTES / TTESO]: MVLV75, Figuras 42 a 59 e atuação do Agente de Mercado"
labels: software, pesquisa, mercado-transativo
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

A semana passada terminou com quatro defeitos corrigidos e a suspeita de que
havia mais escondido. A decisão desta semana foi parar de comparar números
agregados e **reproduzir as 18 figuras da tese uma a uma**, da 42 à 59, no
formato dela e com o nome da própria legenda como nome de arquivo.

O exercício expôs mais três defeitos, todos em código que nunca havia sido
executado, e todos na fase de operação.

## 🛠 Contexto Técnico

- **Repositório:** `douglas-fdbs/co-simulation-opentes`, branch `mercado-transativo`
- **Commit:** `b0cbb34`, 49 arquivos, +7.895 e −2.558 linhas
- **Referência:** MELO, L. S. Tese, UFC, 2022, Figuras 42 a 59
- **Ferramentas:** PADE 3.0, Mosaik 3.5, OMNeT++, OpenDSS, Pyomo com CPLEX

## ✅ Checklist de Entrega

- [x] Figuras 42 a 59 reproduzidas: mesmos nós, mesma projeção 3D, legenda da tese como nome
- [x] Redução do CFP implementada, prevista como próximo passo na semana passada
- [x] Duas novas fontes de tráfego não pertencentes à arquitetura removidas do modelo de rede
- [x] Três defeitos da fase de operação corrigidos (ver Observações)
- [x] Parâmetros de tensão derivados de varredura, não mais estimados
- [x] Limpeza do repositório, arquivos de teste removidos, BT16 e BT38 mantidas
- [x] Roteamento pela raiz avaliado e medido
- [ ] Roteamento pela raiz implementado como opção
- [ ] Atribuição de curva por nó: abandonada por decisão de escopo

## 📊 Resultados / Dificuldades

- **Progresso atual:** 90%

![Progress](https://progress-bar.xyz/90/)

**Resultado consolidado sobre a MVLV75, com a rede 6TiSCH e os tamanhos declarados
pela tese:**

```
negociacao   28 rodadas, convergiu
baseline     V 0,93946 pu, 337 pontos abaixo de 0,97
negociado    V 0,97029 pu, 0 pontos
operacao     95 janelas, 21 exigiram intervencao do AM
comunicacao  161,3 mens./janela (tese 155), 94% abaixo de 500 B (tese ~94%)
             ciclo 1: 136,2   ciclo 2: 10,5   ciclo 3: 14,6 (tese 12 a 16)
```

**O Agente de Mercado passou de inativo a 21 intervenções.** Ele nunca abria o
leilão de contingência, e a causa não era parametrização. Medido: a correção
necessária no pior caso é de 0,51 mpu, com desvio máximo de 0,871 kW, contra uma
capacidade instalada de 184 kW no armazenamento de rede. **O armazenamento está
superdimensionado em duas ordens de grandeza**, então nenhum ajuste de parâmetro
faria o leilão disparar por escassez. A rota fiel passou a ser abrir o leilão
incondicionalmente, o que levou o ciclo 3 de 2 para 14,6 mensagens por janela,
dentro da faixa da tese.

**Dois parâmetros deixaram de ser estimativa.** A margem da restrição de tensão
caiu de 2e-3 para 1e-3 por varredura: acima disso a folga apagava a fase de
operação, abaixo o erro de linearização vazava para o resultado. E separei o
**limiar de ação** do DSO, em 0,971, do **limite regulatório** de 0,97, contra o
qual todo resultado continua sendo contado. Com os dois, as janelas com
intervenção foram de zero para 21 e a tensão mínima final melhorou.

## 📝 Observações Técnicas

**Três defeitos novos, todos na fase de operação.**

- **O leilão travava a co-simulação.** O temporizador era cancelado na primeira
  das seis respostas esperadas. Uma resposta perdida deixava o agente esperando
  para sempre. Apareceu como "83,3% de respostas" e o traço congelado em t=67.
  Corrigido com cancelamento apenas quando todas chegam, mais retransmissão.
- **O armazenamento de rede era energia infinita.** O estado de carga nunca era
  propagado entre janelas: a bateria voltava a 50% a cada 15 minutos. Com 8 kW e
  95 janelas, o modelo entregava 190 kWh de um dispositivo de 20 kWh. O `soc0`
  existia na assinatura do solver e nunca havia sido passado.
- **O `run.sh` corrompia o `omnetpp.ini` a cada execução.** O `sed` do
  `_set_simlim` substituía apenas o rótulo e mantinha o valor antigo, duplicando
  a linha a cada restauração. Ela estava com **163.857 caracteres**, e a versão
  commitada já vinha corrompida com 8 repetições.

**Mais duas fontes de tráfego que não são da arquitetura.** Na semana passada foi
o `sniffer`. Agora: o agente `solver`, que é recurso de implementação porque o
Pyomo não pode rodar na thread do reactor e **não tem posição no Apêndice B**,
representava 36% do tráfego da programação com mensagens de até 102 kB. E o
`reject-proposal`, que fecha cada rodada, carregava **51.898 bytes por
destinatário por rodada** de preço sombra que nenhum handler lê. Era a maior
mensagem da negociação, maior que o próprio CFP.

**A redução do CFP foi implementada.** As três medidas previstas: cada
concentrador recebe apenas o λ dos nós dele, o `p_init` e o `q_init` vão só na
primeira rodada e ficam em cache, e os floats foram truncados em 6 casas.

**Um erro meu, corrigido.** Ao investigar o tamanho das mensagens, deixei as
Figuras 58 e 59 oficiais geradas em modo `real` em vez de `thesis`. A queda na
contagem foi percebida por você antes de eu perceber. Regeradas no modo correto.

**Um caminho testado e revertido.** Cheguei a recomendar o modo `day` para a
realização, e a Figura 55 perdia o vale de meio-dia do PV. A causa: a programação
de armazenamento otimizada para o dia base, com 25,8 kW de sobra ao meio-dia,
aplicada a um dia de 7,1 kW, faz a bateria carregar demais. Isso não é erro de
previsão, é aplicar a programação de um dia à realização de outro.

## 🚀 Próximos passos

- **Migrar para as redes próprias BT16 e BT38.** A MVLV75 cumpriu o papel de
  padrão de calibração e não é o objeto do trabalho.

## 🎯 Conclusão

A MVLV75 fechou com **337 pontos violados para zero** e tensão mínima de 0,93946
para 0,97029 pu, com o Agente de Mercado atuando em 21 das 95 janelas e o volume
de comunicação a 161 mensagens por janela contra as 155 da tese.

O que vale registrar como método, e que repete a lição da semana passada em outra
escala: **um número agregado pode bater por compensação de erros, uma figura
não**. Os três defeitos desta semana estavam todos na fase de operação, que
passava nos totais e falhava no formato. Nenhum deles apareceria numa rede nova,
porque não haveria contra o que conferir.
