---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Estudo de viabilidade para calcular o preço sombra por fase no caso IEEE 13
  barras do mercado transativo do `grei-ufc/co-simulation-opentes`. A semana
  foi de análise e protótipo; nada foi alterado no repositório.
---

## 📌 Descrição da Atividade

A etapa de mercado segue a decomposição dual da tese do professor Lucas, que
usa a MVLV75, uma rede em que todas as barras são trifásicas e equilibradas. Lá
um preço sombra por nó basta. O IEEE 13 tem barras mono, bi e trifásicas
desequilibradas, e hoje o agente DSO trata cada barra pela média das fases.

A atividade da semana foi avaliar se a análise pode passar a ser feita por
fase, o que troca o gráfico único de preço sombra por três, um para cada fase.
O trabalho ficou em estudo e protótipo, fora do repositório. Nenhum arquivo do
`co-simulation-opentes` foi modificado, e a implementação depende de decisões
que ainda precisam ser tomadas com o orientador.

## 🛠 Contexto Técnico

- **Repositório:** `grei-ufc/co-simulation-opentes` (somente leitura nesta
  semana)
- **Referência:** capítulo 6 da tese de Lucas S. Melo (2022); Hu et al. (2017),
  artigo em que a formulação da tese se baseia
- **Ferramentas:** OpenDSS (py-dss-interface), Pyomo, CPLEX, Docker

## ✅ Checklist de Entrega

- [x] Levantamento de como o IEEE 13 foi adotado na camada de mercado
- [x] Formulação por fase derivada da tese e conferida na literatura
- [x] Protótipo fora do repositório comparando três formulações
- [x] Conferência dos resultados no fluxo de potência não linear, fase a fase
- [ ] Decisões de modelagem com o orientador
- [ ] Implementação no repositório
- [ ] Documentação da mudança

## 📊 Resultados / Dificuldades

A mudança é viável. O artigo de Hu et al. diz que, em rede desequilibrada, o
método se aplica e a adaptação consiste em introduzir o preço sombra em cada
fase. Na formulação da tese, isso equivale a trocar o índice de barra das
Equações 6.18 a 6.30 pelo par barra e fase.

O protótipo comparou três formulações sobre o mesmo caso: a atual, com a média
das fases; uma intermediária, com restrição de tensão por fase e dispositivo
equilibrado; e a por fase completa. No IEEE 13 como está hoje, a formulação
atual zera as violações na média, mas no fluxo não linear restam 152 pontos
acima de 1,03 pu quando se olha fase a fase, com a fase B chegando a 1,053 pu.
A formulação por fase reduz esse número a 8 e convergiu em 84 rodadas, contra 99
da atual.

A dificuldade maior apareceu no próprio caso de teste. A conversão do IEEE 13
para o mercado usa uma carga equilibrada por nó, o que apaga parte do
desequilíbrio da rede. Com as cargas e os sistemas fotovoltaicos nas fases
físicas, o caso base passa a ter 677 pontos acima de 1,03 pu e 602 abaixo de
0,97 pu no mesmo dia. Nessa versão, só a formulação por fase encontra acordo, e
mesmo assim com o armazenamento ampliado em 1,88 vez.

## 📝 Observações Técnicas

- **Acoplamento entre fases:** injetar 1 kW na fase A da barra 671 eleva a
  fase A em 51 µpu e reduz a fase B em 71 µpu. Uma injeção equilibrada move a
  fase B em 4,4 µpu/kW, enquanto o modelo da média enxerga 9,2.
- **Compatibilidade com a tese:** com os pesos da função objetivo e o passo do
  subgradiente multiplicados pelo número de fases do dispositivo, a formulação
  por fase reproduz a atual em rede equilibrada. Na BT16 as duas convergiram nas
  mesmas 39 rodadas, o que preserva a reprodução da MVLV75.
- **Preços de sinais opostos:** em 159 de 504 instantes, fases do mesmo nó
  tiveram preço sombra de sinais contrários, uma incentivada a absorver e outra
  a injetar. Um preço por nó não representa essa situação.
- **Regulador de tensão:** com as derivações livres, o resultado depende do
  ponto de partida delas e nenhuma formulação elimina as violações. Travar a
  derivação pela previsão, já recomendado no estudo do IEEE 13, passa a ser
  requisito.
- **Erro de linearização:** chega a 9 mpu no caso atual e a 13 mpu no caso com
  as fases físicas, acima da margem de 1 mpu usada hoje.
- **Mensagens:** o CFP de cada rodada cresce de 10,9 para 24,2 kB no IEEE 13.
  Na MVLV75 o aumento seria de três vezes, sem ganho, por isso as redes
  equilibradas devem continuar com o preço por nó.
- **Ligação do PV1:** o sistema de 5 MW é ligado em estrela nas fases B e C,
  mas entra no caso de mercado como triângulo B-C. Essa diferença ainda não
  estava registrada.

## 🚀 Próximos passos

- Definir com o orientador o modelo do dispositivo de armazenamento (despacho
  independente por fase) e se o estado de carga é compartilhado entre as fases.
- Decidir entre manter o caso IEEE 13 atual ou reconstruí-lo com as fases
  físicas, o que exige redimensionar o armazenamento.
- Depois das decisões, implementar no repositório e documentar.

## 🎯 Conclusão

O estudo indica que o preço sombra por fase é aplicável ao IEEE 13 e que a
formulação atual, baseada na média das fases, deixa de enxergar violações que
existem em fases individuais. Por enquanto o resultado é um protótipo com
medições, guardado fora do repositório. A implementação começa quando as
decisões de modelagem estiverem fechadas.
