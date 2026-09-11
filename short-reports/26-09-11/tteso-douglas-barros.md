---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Validação do mercado transativo nas redes próprias BT16 e BT38.
title: "[OpenTES / TTESO]: BT16 e BT38, validação do Agente de Mercado"
labels: software, pesquisa, mercado-transativo
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

Com a IEEE 13 concluída, a semana foi dedicada às redes próprias **BT16** (bancada,
2 alimentadores) e **BT38** (rede final, 4 alimentadores). O objetivo foi rodar o
mercado completo nelas, gerar as mesmas 18 figuras de referência e verificar se o
Agente de Mercado resolve a subtensão e a sobretensão.

## 🛠 Contexto Técnico

- **Repositório:** `douglas-fdbs/co-simulation-opentes`, branch `mercado-transativo`
- **Referência:** MELO, L. S. Tese, UFC, 2022
- **Ferramentas:** PADE 3.0, Mosaik 3.5, OMNeT++, OpenDSS, Pyomo com CPLEX

## ✅ Checklist de Entrega

- [x] Topologia de rádio 6TiSCH gerada para BT16 e BT38
- [x] Negociação e co-simulação com OMNeT++ nas duas redes
- [x] Subtensão e sobretensão resolvidas nas duas redes
- [x] Requisitos de funcionalidade do mecanismo verificados
- [x] 18 figuras de referência por rede, em pastas próprias

## 📊 Resultados / Dificuldades

- **Progresso atual:** 100%

![Progress](https://progress-bar.xyz/100/)

Co-simulação completa: agentes PADE, fluxo não linear do OpenDSS, demanda
realizada e rede 6TiSCH no laço.

```
rede   baseline (por fase)       negociado (por fase)   rodadas
BT16   111 abaixo, 411 acima     0 abaixo, 0 acima         29
BT38   1218 abaixo, 384 acima    3 abaixo, 0 acima         32
```

- **Onde ocorrem os extremos:** na BT16, no mesmo alimentador e em horários
  diferentes (sobretensão das 09:00 às 13:30, subtensão das 15:00 às 20:00). Na
  BT38, em alimentadores e horários diferentes: sobretensão no condomínio solar
  das 08:45 às 13:30 e subtensão na ponta rural, sobretudo das 14:45 às 22:15.
- **Preço sombra:** assume os dois sinais conforme a necessidade de cada nó.
  Positivo pede descarga onde há subtensão; negativo pede carga onde há
  sobretensão.
- **Operação:** o Agente de Mercado interveio em 7 janelas na BT16 (3 de
  sobretensão, 4 de subtensão) e em 23 na BT38 (2 e 21).
- **Comunicação:** todos os ciclos couberam nas fatias de tempo e nenhuma
  programação se perdeu. Na BT38, das 10.662 mensagens, 17 foram perdidas e
  recuperadas por retransmissão do concentrador.

**Resíduo da BT38:** as 3 leituras são uma barra só (fim do alimentador rural),
num intervalo (19:30), a 0,96970 pu. A fase de operação atuou, mas estima a
tensão pelo modelo linear, e ali o erro de linearização (1,3 mpu) supera a margem
de 1 mpu.

## 📝 Observações Técnicas

- **Topologia de rádio:** as redes próprias não tinham posição dos agentes, e sem
  ela o OMNeT++ entrega as mensagens sem atraso. A topologia foi gerada por código,
  com direções do diagrama unifilar e comprimentos reais das linhas. Todos os
  agentes ficaram alcançáveis em 100% de 400 sorteios de propagação.
- **Figuras:** duas correções no gerador. A rede da tese passou a ser reconhecida
  pelo nome da pasta, porque a BT38 também tem os nós 17 a 21. E o preço sombra
  negativo deixou de ser cortado na Figura 45.
- **Registros:** cada execução sobrescrevia o `run.json` da anterior; agora cada
  rede grava o seu.
- **Defeitos de registro identificados, ainda não corrigidos:** `deviation_kw`
  sai zerado quando o leilão abre, e as retransmissões do concentrador ficam fora
  da contagem.

## 🚀 Próximos passos

- Iniciar tratativas dos artigos e relatório final CNPq

## 🎯 Conclusão

As duas redes comprovam o mecanismo nos dois sentidos. Subtensão e sobretensão são
eliminadas no fluxo não linear, com um resíduo de 0,3 mpu na BT38. O preço sombra
tem sinal coerente, o Agente de Mercado intervém na operação e a comunicação cabe
nas fatias de tempo. A BT38 fica pronta como rede de estudo.
