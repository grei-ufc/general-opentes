---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Ainda realizando alguns ajustes de mercado, antes de começar os testes sem o método estocástico.
title: "[OpenTES / TTESO]: MVLV75 — ajuste de figuras e mercado"
labels: software, pesquisa, mercado-transativo
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

A semana começou com duas redes de teste próprias (uma de bancada e a final do
trabalho) e virou, a pedido, para uma pergunta só: **por que os nossos resultados
de comunicação e de mercado não se parecem com os das Figuras 56 a 59 da tese?**

A resposta acabou sendo quatro defeitos nossos e uma diferença de dado que não
tem conserto pelo que está publicado.

## 🛠 Contexto Técnico

- **Repositório:** `douglas-fdbs/co-simulation-opentes` — branch `mercado-transativo`
- **Referência:** MELO, L. S. Tese, UFC, 2022 — Figuras 55 a 59, Tabelas 20 e 21,
  e o código `market-simulation/` (`start_pade_agents.py`, `prosumer_agent.py`,
  `solver_agent.py`, `stochastic_model/ReferenceModel.py`)
- **Ferramentas:** PADE 3.0, Mosaik 3.5, OMNeT++, OpenDSS, Pyomo com CPLEX

## ✅ Checklist de Entrega

- [x] Redes próprias BT16 (bancada) e BT38 (final), com alimentadores ramificados
      e diagrama unifilar gerado por código
- [x] Adaptações Figuras 56 e 57: energia por mercado e preço spot contra bilateral
- [x] Adaptações Figuras 58 e 59: cada mensagem e as distribuições de tamanho e de tempo
- [x] Primeira execução completa do `./run.sh market` sobre a rede 6TiSCH
- [x] Adaptações Tabelas 20 e 21 transcritas e confrontadas nó a nó com a nossa demanda
- [x] Quatro defeitos de fidelidade corrigidos (ver Observações)
- [ ] Reduzir o CFP de 35,7 kB — caminho medido, não implementado
- [ ] Roteamento pela raiz como opção comparável ao direto

## 📊 Resultados / Dificuldades

- **Progresso atual:** 80%

![Progress](https://progress-bar.xyz/80/)

**A rede 6TiSCH da tese rodou de ponta a ponta pela primeira vez.** A negociação
convergiu em **35 rodadas com 40 retransmissões** sobre a topologia publicada, e
o resultado elétrico saiu **idêntico ao do canal ideal**: 337 pontos violados
para zero, tensão mínima de 0,93946 para 0,97033 pu. Com os tamanhos que a tese
declara, a rede LPWA dela não é gargalo, e agora isso é medição e não suposição.

**O mercado bilateral saiu de 0,6% para 21,6% da energia.** Ele estava quase
inativo porque só os 25 prosumidores com bateria entravam no mercado; os outros
43 eram carga pura. Depois do conserto, os nós 15, 52 e 32 passaram a reproduzir
o padrão da Figura 56.

**A divergência que resta é de dado.** Confrontando as Tabelas 20 e 21 nó a nó, o
erro médio da demanda líquida máxima é **−0,04 kW**, ou seja o agregado é o mesmo,
mas o erro absoluto médio é 0,49 kW e o horário do pico coincide em apenas **9 de
68 nós**. Uma sondagem fecha o diagnóstico: dos 43 nós sem bateria, **29 têm
alguma curva do nosso reservatório casando** com a impressão digital da tese, mas
só **8 casam com o próprio nó**. É o mesmo conjunto de curvas atribuído a nós
diferentes. Nenhuma comparação **por nó** com a tese é teste válido da nossa
implementação; as agregadas continuam valendo, e batem.

<img width="1760" height="960" alt="image" src="https://github.com/user-attachments/assets/ca57720f-c2ab-4540-9aec-141cad687ae6" />

<img width="1680" height="1056" alt="image" src="https://github.com/user-attachments/assets/8d6f3769-c421-4dbf-9b38-1992b5aff7a9" />

<img width="1440" height="672" alt="image" src="https://github.com/user-attachments/assets/8eb86539-b278-4c44-b144-cec6720f1547" />

<img width="1760" height="1024" alt="image" src="https://github.com/user-attachments/assets/4feb51d9-0fd4-44c5-a923-589eca8de00b" />

## 📝 Observações Técnicas

**Quatro defeitos nossos, encontrados por rodar o que nunca havia rodado.**

- **Metade do nosso tráfego não era tráfego.** O `Agent.react` do PADE reenvia
  cópia de tudo o que recebe ao agente `sniffer`, que é depuração do framework e
  não existe na arquitetura nem na rede 6TiSCH. Eram **7.198 de 14.968
  mensagens**, todas na faixa alta e com atraso zero. Com elas dentro, a Figura 59
  saía com a distribuição invertida e a mediana do tempo em 0,1 s.
- **O mapeamento de tamanho lia um arquivo só.** O original usa **três** classes
  espalhadas por quatro arquivos de agente, não duas; a do meio (100 a 500 bytes)
  é a proposta do prosumidor no leilão de tempo real. Corrigido, a distribuição de
  tamanho passou a ter a forma da Figura 59a.
- **Os 43 prosumidores sem bateria não negociavam.** Verifiquei em três pontos do
  código original antes de mexer: ele cria um agente por nó de baixa tensão, todos
  pedem a otimização, e o `p_bilateral` fica fora do `if has_storage` no
  `ReferenceModel.py`. Era redução nossa, e a correção restaura o parâmetro dela.
- **Perder uma proposta derrubava o processo.** Sem resposta após as dez
  retransmissões, o concentrador declarava o ciclo pronto com buraco em `p_init`,
  e a falha aparecia dois ciclos depois como `KeyError`, num ponto sem relação com
  a causa.

**Duas afirmações minhas que caíram.** Eu li a rampa da Figura 58b como assinatura
de enfileiramento no ns-3: não é, o eixo x contém o próprio atraso e atrasos
independentes produzem a mesma diagonal, o que reproduzi num traço sintético. E
disse que havia batido o tempo de recepção: bateu só o teto, 82,6 s contra 90 s;
a mediana continua em 3,9 s contra os cerca de 20 s dela.

**Uma hipótese testada e rejeitada.** O nó 24 tem bateria e compra bilateral na
tese; o 32, igual a ele, não compra. Achei que o modelo estocástico explicasse,
já que o `p_bilateral` é variável de primeiro estágio. Medido com 9 cenários: o
nó 24 sobe de 0,10 para 0,93 kWh, o que continua desprezível, e o nó 32 **quebra**
o casamento. O determinístico reproduz melhor.

## 🚀 Próximos passos

- **Reduzir o CFP.** Medido: enviar a cada concentrador só o λ dos nós dele e
  parar de reenviar o `p_init` a cada rodada leva a mensagem de 35.663 bytes e 281
  quadros para cerca de 3,6 kB e 29 quadros, e a entrega no enlace ruim de 0,07%
  para 47% por tentativa.
- **Decidir o roteamento.** Medido: todo par concentrador-prosumidor é **1 salto**
  direto e **4 pela raiz**, e a nossa mediana de CFP é 2,14 s, exatamente um
  salto. O piso de 10 s da tese é impossível com um salto. Implementar a passagem
  pela raiz como opção, não como troca, para que as duas fiquem mensuráveis.

## 🎯 Conclusão

A semana não produziu resultado novo de mercado: produziu a explicação de por que
os antigos não se pareciam com os da tese. Quatro dos cinco motivos eram defeitos
que encontrei, e estão corrigidos. O quinto é a atribuição de curva por nó, que não se
recupera do que está publicado.

O que vale registrar como método: os quatro defeitos só apareceram ao **rodar o
que nunca havia rodado** e ao **desenhar a figura no formato dela** em vez de uma
figura equivalente. O `ciclos.png` que produzíamos respondia uma pergunta boa,
mas não a pergunta da Figura 58, e por isso a divergência ficou dois meses
invisível.
