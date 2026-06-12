---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Fechar o acoplamento causal da co-simulação OpenTES sobre o IEEE 13 Barras —
  OpenDSS ⟷ OMNeT++ ⟷ PADE — com os 5 inversores fotovoltaicos co-simulados e
  sob controle Volt/Var distribuído, e avaliar a eficiência da co-simulação
  comparando a operação SEM e COM controle.
title: "[OpenTES / Integração]: Acoplamento causal Volt/Var no IEEE 13 (5 PVs) co-simulado via PADE+OMNeT+++OpenDSS"
labels: pesquisa, software
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

A semana foi dedicada a sair da **coexistência** (os simuladores rodando
sincronizados mas isolados em conteúdo) para o **acoplamento causal**: a tensão
da rede elétrica passa a ser medida, transmitida pela rede de comunicação
simulada (com atraso/jitter/perda) até os agentes, que decidem e devolvem
setpoints que mudam a própria rede — fechando o laço.

O cenário integrado (`mosaik-opentes/scenarios/first.py`, evolução do `first.py`
do TSCC que já unia PADE+OMNeT+++Mosaik) reproduz o estado do trabalho do TSRE
(Paulo Victor: 5 PVs injetando no IEEE 13), porém agora **co-simulado e
controlado**: cada um dos 5 inversores tem um par de agentes PADE (medidor +
controlador Volt/Var) e a tensão de cada barra trafega pelo OMNeT++.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (x) Python | (x) C++ | (x) Docker | (x) OpenDSS | (x) OMNeT++ | (x) PADE | (x) Mosaik
- **Repositório principal:** `https://github.com/grei-ufc/co-simulation-opentes`
- **Branch de trabalho:** `four-dockers-split`
- **Benchmark:** IEEE 13 Barras, 5 PVs com dados climáticos reais (BR-PVGen, do TSRE)
- **Requisito associado:** Co-simulação multidomínio causal e rastreável.

## ✅ Checklist de Entrega

- [x] Topologia de 4 containers (comm / pade / mosaik / grid) consolidada
- [x] Collector retirado do TSRE e levado ao Mosaik (telemetria + dados elétricos)
- [x] Controle do TSRE migrado para o PADE (agora Volt/Var no inversor)
- [x] Acoplamento causal fechado: OpenDSS → OMNeT++ → PADE → OpenDSS
- [x] 5 PVs co-simulados e controlados (par medidor/controlador por barra)
- [x] Experimento de eficiência: co-simulação SEM × COM controle
- [x] Rede de comunicação com latência, jitter e perda de pacotes (modelo TSCC)
- [x] Saídas organizadas em `output/` por cenário + dashboard de 8 quadros
- [x] Validação do bloco elétrico isolado contra o resultado do TSRE
- [ ] Calibração do controle Volt/Var e da perda de pacotes (com TSRE/TSCC)
- [ ] Transações econômicas (etapa posterior, em servidor)

## 📈 Resultados / Dificuldades

- **Progresso atual:** 55%

![Progress](https://progress-bar.xyz/55/)

### ✅ Resultados da Semana

| Item | Status | Observação |
|------|--------|------------|
| Acoplamento causal | ✅ | OpenDSS ⟷ OMNeT++ ⟷ PADE fechando o laço, 1 dia a 5 min |
| 5 PVs co-simulados | ✅ | cada inversor com medidor+controlador, tensão via OMNeT++ |
| Volt/Var distribuído | ✅ | P = solar; Q = f(tensão), S = √(P²+Q²) ≤ kVA |
| Suporte de tensão | ✅ | Bus 652 mínima 0,920 → 0,938 pu; desvio −10% (até −19%), sem sobretensão |
| Comunicação realista | ✅ | perda 18,6%, latência 32–451 ms, jitter médio 53 ms |
| Validação vs TSRE | ✅ | bloco elétrico isolado bate **exato** (P_dc 3024,6 / P_ac 2854,2 kW) |
| Estabilidade do controle | ⚠️ | ganho agressivo + atraso/perda **desestabiliza** (achado do benchmark) |

### 🔧 Atividades Desenvolvidas na Semana

1. **Fechamento do laço causal** no `first.py`: a tensão de cada barra é medida, enviada pela rede OMNeT++ (com atraso/jitter/perda) ao agente, que decide e atua no inversor — e a atuação muda a tensão do passo seguinte.
2. **Migração do controle para Volt/Var no inversor** (sem bateria): o agente recebe a tensão e calcula potência **ativa** (solar disponível) e **reativa** (regulação), respeitando a potência aparente do inversor.
3. **Generalização dos agentes** para N pares medidor/controlador (um por PV), cada controlador filtrando a medição da sua própria barra.
4. **Co-simulação dos 5 PVs** (reaproveitando a cadeia irradiância → painel do TSRE), reproduzindo o estado do Paulo Victor, agora controlado.
5. **Modelo de comunicação realista**: latência, jitter e **perda de pacotes** (parâmetro do TSCC = 15%), com semente fixa para reprodutibilidade.
6. **Experimento de eficiência** (SEM × COM controle) automatizado em duas passadas pelo `run_opentes.sh`, com limpeza/robustez de containers.
7. **Dashboard de 8 quadros** unindo os dois domínios (irradiância, temperatura, geração agregada, tensões das 13 barras, integridade de pacotes, latência, jitter, efeito Volt/Var) + tabela explicando cada `.csv`.

### ⚠️ Dificuldades / Achados

- **Estabilidade do controle distribuído.** Com 5 inversores fazendo Volt/Var agressivo (ganho padrão IEEE 1547) somado ao atraso/perda da rede, o reativo **sobre-injeta** e desestabiliza (tensão chegou a 1,12 pu). Reduzindo o ganho o sistema regula de forma estável. **Este é um resultado central do benchmark:** a qualidade da comunicação limita a agressividade segura do controle.
- **Perda de pacotes é parâmetro, não resultado.** O `drop_probability` modela a confiabilidade do canal real e deve ser **calibrado com a aplicação** — não é uma saída da co-simulação.
- **Reprodutibilidade.** A ordem assíncrona das mensagens faz os valores exatos variarem um pouco entre execuções; a semente fixa reduz, mas não elimina. O efeito qualitativo se mantém.

## 📅 Prazo Estimado

- Calibração do controle/comunicação e cenário reproduzível em servidor: **junho/2026**.

## 📋 Planejamento para conclusão da entrega

- Passo 1. Calibrar o ganho Volt/Var e a curva de perda de pacotes junto ao TSRE/TSCC.
- Passo 2. Estudar sistematicamente o impacto da comunicação (varrer perda/latência) sobre a estabilidade e a qualidade da regulação.
- Passo 3. Padronizar as colunas dos CSV (padrão do Beto) e o formato de saída.
- Passo 4. Preparar o cenário reproduzível para execução no servidor do laboratório.
- Passo 5. Evoluir para as transações econômicas (TES) sobre a mesma base.

## 🔍 Observações Técnicas

A separação por domínio se mantém em quatro containers (comm/OMNeT++,
pade/agentes, grid/OpenDSS, mosaik/orquestrador+collectors). O ponto novo é que
agora há **causa e efeito** entre eles: a decisão dos agentes, transportada por
uma rede de comunicação imperfeita, altera o estado elétrico — que é o que o
projeto OpenTES existe para estudar.

## 🎯 Conclusão

Saímos de "quatro simuladores rodando juntos" para "uma co-simulação que estuda
o impacto real da comunicação sobre a operação da rede". O IEEE 13 com 5 PVs sob
Volt/Var distribuído roda de ponta a ponta, com a tensão trafegando por uma rede
de comunicação realista, e já produz um resultado interessante: o controle dá
suporte de tensão, mas sua agressividade segura é limitada pela qualidade da
comunicação. A próxima fase é calibrar e estudar sistematicamente esse
acoplamento, rumo às transações econômicas.
