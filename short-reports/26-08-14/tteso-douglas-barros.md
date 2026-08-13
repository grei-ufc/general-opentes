---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Implementação da camada de mercado transativo (SiMTES) sobre a plataforma de
  co-simulação: 33 agentes PADE negociando a programação de armazenamento numa
  rede de 75 barras, com rede de comunicação 6TiSCH no laço, validada contra a
  tese de referência.
title: "[OpenTES / TTESO]: Mercado transativo na MVLV75 — negociação multiagente, rede 6TiSCH e validação contra a tese"
labels: software, pesquisa, mercado-transativo
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

Quatro semanas dedicadas a **portar a camada de mercado transativo** com base na tese de
doutorado do prof. Lucas Silveira Melo para a plataforma de co-simulação
modernizada. A pergunta que guiou o trabalho: *a negociação entre agentes, com as
mensagens passando por uma rede de comunicação real, mantém a tensão dentro do
limite sem mandar ninguém fazer nada?*

O salto em relação ao que existia: saímos de um **teste de controle Volt/Var em
13 barras**, em que cada inversor reagia localmente à própria tensão, para um
**mercado com 33 agentes numa rede de 75 barras**, em que o prosumidor propõe, o
DSO contesta quando a rede não aguenta, e o preço é o que concilia os dois.

## 🛠 Contexto Técnico

- **Repositório:** `douglas-fdbs/co-simulation-opentes` — branch `mercado-transativo`
- **Referência:** MELO, L. S. Tese de doutorado, UFC, 2022, capítulo 6 e apêndices
  A–C; e MELO et al., *Electric Power Systems Research* 223, 2023
- **Ferramentas:** PADE 3.0, Mosaik 3.5, OMNeT++, OpenDSS via `py-dss-interface`,
  Pyomo com CPLEX, Docker Compose

## ✅ Checklist de Entrega

- [x] Conversão da rede da tese (75 barras) para circuito OpenDSS, validada barra a barra
- [x] Matriz de sensibilidade de tensão por perturbação, no lugar do Jacobiano de um segundo simulador
- [x] Os três modelos de otimização: prosumidor, concentrador e DSO
- [x] Decomposição dual e descoberta do preço sombra, centralizada e distribuída sobre FIPA
- [x] Fase de operação dentro dos agentes, com fluxo de potência real
- [x] Rede LPWA **6TiSCH** da tese reconstruída no OMNeT++, com a topologia publicada
- [x] Sensibilidade ao reativo (∂V/∂Q), que qualifica a hipótese ΔQ = 0 da formulação
- [x] Liquidação das transações e preço locacional, que a tese propõe e não executa
- [x] Revisão de cobertura do capítulo 6, subseção por subseção
- [x] Documentação: formulação, comparação com a tese, guia de entrada e diário
- [x] Apresentação de 31 slides em HTML, PPTX e PDF, com a identidade visual do GREI

## 📊 Resultados / Dificuldades

- **Progresso atual:** 100%

![Progress](https://progress-bar.xyz/100/)

**23 commits, 249 arquivos, ~26.600 linhas.** Os destaques:

**O resultado central da tese se reproduz.** No fluxo de potência não linear
completo do OpenDSS, os pontos abaixo de 0,97 pu vão de **337 para zero**, e a
tensão mínima do dia sobe de **0,93946 para 0,97033 pu**, no intervalo das
**17:45**. A tese relata a tensão indo de 0,94 para 0,97 pu no mesmo horário. O
horário coincidir não é acaso: sai da mesma curva de demanda com o mesmo
dimensionamento por nó.

**Duas divergências numéricas foram reconciliadas por experimento.** O preço
sombra máximo dava 5,61 contra os 2,18 da tese, e as rodadas 34 contra 8. Como λ
é o multiplicador de Lagrange da restrição de acoplamento, ele é propriedade do
*problema* e não do algoritmo: se os dois convergiram e diferem, os problemas é
que são diferentes. Uma ablação, desligando uma a uma as diferenças de modelagem,
mostrou que o fator dominante é o **modelo estocástico** (de 1 para 9 cenários, λ
cai de 4,255 para 2,359, ou 8% da referência) e que as rodadas são o **critério
de parada**, três ordens de grandeza mais frouxo na tese. Duas hipóteses minhas
caíram no caminho: o transformador não tem efeito nenhum, e a margem de tensão
*atrapalha* a convergência em vez de ajudar.

**A rede de comunicação revelou o que só a co-simulação revela.** Com a topologia
publicada no Apêndice C, a mensagem real da negociação (35.663 bytes, ou 281
quadros) tem **99,93% de perda** num enlace que a regra da tese admite, e um dos
cinco concentradores fica incomunicável. O número de projeto que sai disso: a
chamada precisaria encolher para cerca de **500 bytes**, um fator de 70.

## 📝 Observações Técnicas

**Erros meus que a revisão encontrou, e que valem registro.**

- A adjacência da rede de comunicação era **regenerada** a partir das
  coordenadas, o que exige supor o orçamento de enlace do rádio. A suposição
  natural produziu 1.466 enlaces contra os **578 publicados**, uma rede com
  metade dos saltos e muito menos perda. Passei a ler a matriz do arquivo. Meus
  resultados de comunicação anteriores estavam otimistas.
- Eu havia documentado que a análise de comunicação da tese subestima o tráfego.
  Está errado: aquela análise é da **fase de operação**, em que a mensagem
  carrega um intervalo só, e o CFP de operação daqui tem 1.004 bytes, dentro dos
  1000 a 1500 declarados. O descompasso é na programação do dia seguinte.
- O **ciclo 2 não existia como tráfego**: o agente de mercado lia a programação
  direto da memória do concentrador, por dentro do processo. O atalho pulava a
  rede inteira.
- A negociação vinha sendo **cortada antes de convergir**, porque o teto de
  rodadas era herança de quando a margem de tensão era menor. Saía com
  `converged=False` e nada avisava.

**Três problemas de concorrência**, todos da mesma família: o `py-dss-interface`
não é seguro para uso concorrente e derrubava o processo com `std::bad_alloc`
quando chamado do pool de threads; o socket ZMQ do tipo REQ travava o reactor
pelo mesmo motivo; e o relógio do OMNeT++ estourava o teto de 106 dias em
picossegundos, porque o atraso de cada mensagem se acumula.

**Uma ferramenta que mudou o método:** passei a auditar as figuras com navegador
headless em vez de raciocinar sobre o CSS. Foi assim que descobri que a minha
primeira correção de um defeito de layout tinha **piorado** o sintoma.

## 🚀 Próximos passos

- **Reduzir o tamanho das mensagens.** Deixou de ser refinamento: sem isso a
  negociação não trafega na rede da referência.
- **Realizar o teste de mercado com uma rede menor.** Isso é essencial, pois por mais
  que tenhamos conseguido um resultado positivo, algumas coisas ainda não estão tão bem 
  implementadas, principalmente com relação a comunicação, que ainda não está bem
  refinada. Além disso, vamos remover a camada estocástica e deixar o comportamento 
  do banco de baterias unicamente determinístico, via MILP com uso do CPLEX.
## 🎯 Conclusão

O mercado transativo saiu do papel e entrou na rede. Trinta e três agentes
negociam a programação de armazenamento de um dia inteiro, o preço emerge da
disputa em vez de ser arbitrado, e a subtensão que existiria em 337 pontos
desaparece — com as mensagens passando por uma rede sem fio que atrasa, perde
pacote e às vezes não entrega.

O que mais me parece valer: **as diferenças com a tese estão todas quantificadas
e justificadas**, e não escondidas. Onde o resultado diverge, há um experimento
que explica por quê; e onde eu estava errado, o erro está documentado junto com o
que ele ensinou.
