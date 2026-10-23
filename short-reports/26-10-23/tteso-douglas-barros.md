---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Mercado transativo por fase sobre o IEEE 13 barras, com inversor de quatro
  fios e rede 6TiSCH no laço; revisão da negociação e da rede de comunicação;
  TCC, relatório final e console de execução atualizados.
title: "[OpenTES / TTESO]: Mercado por fase no IEEE 13, negociação mais curta, despacho funcionando e diagnóstico da 6TiSCH"
labels: software, pesquisa, mercado-transativo
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

Três semanas, de 01/10 a 22/10, dedicadas a levar o mercado transativo da
análise por barra para a análise por fase e a revisar, com o traço de mensagens
na mão, se a negociação e a rede de comunicação faziam o que se esperava delas.

O IEEE 13 é desequilibrado, e a média das fases escondia violações: a negociação
por barra deixava 151 leituras de fase acima de 1,03 pu no fluxo de potência
completo. A pergunta das semanas foi se a formulação por fase resolve isso com a
rede 6TiSCH entre os agentes, e quanto custa.

## 🛠 Contexto Técnico

- **Repositório:** `douglas-fdbs/co-simulation-opentes`, branch `mercado-por-fase`
- **Referência:** MELO, L. S. Tese de doutorado, UFC, 2022 (base da formulação)
- **Ferramentas:** PADE 3.0, Mosaik 3.5, OMNeT++ 6, OpenDSS via `py-dss-interface`,
  Pyomo com CPLEX, Docker Compose, MkDocs

## ✅ Checklist de Entrega

- [x] Documentação reunida em site MkDocs, com os números conferidos (01/10)
- [x] Análise por fase: tensão e preço sombra por fase, armazenamento por porta, inversores de quatro e de três fios (14/10)
- [x] Regulador de tensão com as derivações da previsão, enviadas pelo operador a cada passo (14/10)
- [x] Limpeza e organização do repositório: só o caso IEEE 13, a tese citada como base, READMEs por pasta (14 e 15/10)
- [x] TCC atualizado para a análise por fase, 65 páginas (19/10)
- [x] Textos e sugestões de imagem do pôster dos Encontros Universitários
- [x] Correção da corrida de partida dos agentes e critério de parada relativo (21/10)
- [x] Despacho por assinatura FIPA funcionando de ponta a ponta (21/10)
- [x] Console interativo no terminal, com o comando `opentes` (21 e 22/10)
- [x] Diagnóstico da rede 6TiSCH por experimento e correção do reenvio na fase de operação (22/10)
- [x] TCC e relatório final atualizados com os números novos (22/10)

## 📊 Resultados / Dificuldades

- **Progresso atual:** 100%

![Progress](https://progress-bar.xyz/100/)

**10 commits, 432 arquivos alterados, +5.727 −62.775 linhas** (a maior parte é a
limpeza do repositório).

**A análise por fase resolve o que a média escondia.** No fluxo de potência não
linear, a negociação por barra deixa 151 leituras de fase acima de 1,03 pu, com
máxima de 1,0532 pu, fora da faixa A da ANSI C84.1. A por fase, com inversor de
quatro fios, deixa 9, nenhuma acima de 1,031 pu, e o dia inteiro fica na faixa A.
O custo é 9% mais energia deslocada (7.527 contra 6.903 kWh). O inversor de três
fios chega perto, com 19% mais energia que o de quatro.

**A negociação ficou mais curta sem mudar o resultado.** O critério de parada da
tese, a variação absoluta do preço sombra, exigia a mesma precisão em kW de
portas grandes e pequenas. Com o desacordo medido em fração da
potência de cada porta (0,1%), as rodadas caíram de 66 para 42 por fase, de 81
para 48 por barra e de 108 para 63 com três fios, e nenhuma contagem de tensão
mudou. A co-simulação por fase com entrega ideal caiu de 200 s para cerca de 1 min.

**Dois defeitos de partida do PADE só apareceram no traço.** O PADE reinicia os
comportamentos do agente dois segundos depois de criá-lo, e os iniciadores
reenviavam a si mesmos a última mensagem recebida, o que gerava rodadas de até
120 s sem perda nenhuma. E a assinatura FIPA dos concentradores era sobrescrita
na partida, então o despacho nunca chegava aos prosumidores, embora tudo
terminasse sem erro. Os dois foram corrigidos; o despacho agora percorre a cadeia
inteira, com onze assinaturas e as confirmações de volta.

**O comunicador 6TiSCH está coerente; o estouro de tempo vinha do caso.** Com a 6TiSCH
no laço, o resultado elétrico é idêntico ao da entrega ideal e nenhuma das 2.978
mensagens se perde, mas o ciclo 3 gasta de 474 a 541 s por rodada, contra 300 s
de orçamento. A conta do escalonamento explica o atraso: com 2 cells por
slotframe de 4,04 s, cada enlace escoa uns 63 bytes por segundo, e uma mensagem
de 24 kB leva 384 s, exatamente a mediana medida. O canal "com perda" da
plataforma, que parecia mais eficiente, supõe 50 kbps contínuos, cem vezes mais,
e não é comparável. Dois experimentos acharam a causa do estouro: o DSO, o
agente de mercado e o concentrador da IEEE 13 ficam na mesma coordenada da
subestação e conversavam por rádio. Ligados por cabo, o ciclo 3 vai a zero e a
co-simulação cai de 18 min para 105 s; com os tamanhos de mensagem da
implementação de referência (1 a 1,5 kB, contra 24 kB reais), ele fica entre 18
e 26 s. Nos dois casos, a tensão é a mesma.

**O teste de perda achou uma falha na operação.** Com 1% e 5% de perda a
negociação fecha nas mesmas 42 rodadas, mas a primeira troca da verificação de
cada janela (mercado para DSO) não era retransmitida: com 5% de perda, 8 das 95
janelas ficavam sem correção e as leituras acima de 1,03 pu iam de 9 para 22.
Corrigido o reenvio, o resultado volta a ser idêntico ao da entrega ideal.

## 📝 Observações Técnicas

- Com a rede 6TiSCH no laço, o resultado elétrico do cenário principal é idêntico
  ao da entrega ideal, valor a valor.
- Uma leitura minha da figura de negociação estava imprecisa: a diferença entre
  concentrador e operador cai abaixo de 1 kW na rodada 7, mas oscila e só se
  firma abaixo disso na rodada 19. O texto e o script da figura foram corrigidos.

## 🚀 Próximos passos

- Decidir com o orientador como os agentes da subestação conversam entre si
  (rádio ou cabo) e enxugar o despacho para cada prosumidor receber só as suas
  portas.
- Recalcular a sensibilidade em torno do ponto negociado, para reduzir o erro de
  linearização de 9,5 mpu que deixa 28 leituras abaixo de 0,97 pu.

## 🎯 Conclusão

O mercado agora vigia cada fase, o despacho chega a quem precisa e a negociação
termina em 42 rodadas sem que nada mude na tensão. A revisão pelo traço de
mensagens achou três defeitos que não davam sinal de erro e mostrou que o
estouro de tempo da 6TiSCH vinha da montagem do caso, com o rádio funcionando como
previsto.
