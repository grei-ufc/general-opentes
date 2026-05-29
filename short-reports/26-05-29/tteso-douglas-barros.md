---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Refatorar a integração inicial do OpenTES para uma topologia de 4 containers
  (comunicação, agentes, cenário Mosaik e rede elétrica), migrar o controlador
  do TSRE para um agente PADE, absorver e validar o cenário IEEE 13 Bus + Smart
  PV do TSRE (Paulo Victor) e executar a co-simulação integrada dos quatro
  componentes.
title: "[OpenTES / Integração]: Topologia de 4 containers, controlador em PADE e validação do IEEE 13 Bus"
labels: pesquisa, software
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

A semana de **25/05 a 29/05/2026** deu continuidade à integração do repositório
agregador `co-simulation-opentes`, partindo da base consolidada na semana
anterior (PADE + Mosaik + OMNeT++ + OpenDSS) e avançando em três frentes:

1. **Refatoração arquitetural:** a topologia passou de **3 Dockerfiles
   multi-uso** para **4 containers funcionais**, um por domínio da
   co-simulação — comunicação, agentes, cenário Mosaik e rede elétrica.
2. **Migração do controlador para PADE:** o `BatteryControllerSim` (simulador
   Mosaik do TSRE) foi reescrito como **agente PADE** com ponte Mosaik,
   alinhando com o design transativo do OpenTES.
3. **Absorção e validação do IEEE 13 Bus + Smart PV:** o cenário desenvolvido
   pelo Paulo Victor (TSRE, branch `paulo-victor`) foi trazido para a
   plataforma, adaptado para os 4 containers e teve seus resultados validados
   fisicamente.

Ao final da semana, **os quatro componentes rodam de forma integrada** sobre o
IEEE 13 Bus, com registro de comunicação e dados elétricos, restando como
próximo foco o **acoplamento causal** entre a decisão dos agentes e a rede
elétrica (e a investigação do inversor OpenDER, que ainda não injeta potência).

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (x) Python | (x) C++ | (x) Docker | (x) OpenDSS | (x) OMNeT++ | (x) PADE | (x) Mosaik
- **Repositório principal:** `https://github.com/grei-ufc/co-simulation-opentes`
- **Branch de trabalho:** `four-dockers-split`
- **Benchmark adotado:** IEEE 13 Bus (com 5 PVs e dados climáticos reais BR-PVGen, de Paulo Victor/TSRE)
- **Requisito associado:** Co-simulação multidomínio integrada e validada sobre o IEEE 13 Bus.

## ✅ Checklist de Entrega

- [x] Refatoração da topologia para 4 containers (`comm`, `pade`, `mosaik`, `grid`)
- [x] Fragmentação do TSCC (OMNeT++ → `comm`; agentes → `pade`; cenário/collectors → `mosaik`)
- [x] Renomeação `tsre-der-opentes` → `grid-opentes` (nome por função, não por time)
- [x] Migração do `BatteryControllerSim` para agente PADE (`controller_agent.py`)
- [x] Absorção do cenário IEEE 13 Bus + Smart PV (branch `paulo-victor`)
- [x] Correção dos bugs que impediam o IEEE 13 de rodar no Linux
- [x] Collector elétrico operando como container remoto
- [x] Cenário integrado dos 4 componentes (`ieee13_integrated.py`)
- [x] Script `run_opentes.sh` para execução robusta (resolve erro de rede do Compose)
- [x] Validação física dos resultados (geração PV e tensões de barra)
- [x] Dashboard de apresentação dos resultados (`plot_ieee13.py`)
- [x] Documentação das alterações (`ALTERACOES_INTEGRACAO.txt` seções 9–14)
- [ ] Acoplamento causal agente → rede elétrica (próxima etapa)
- [ ] Investigação do inversor OpenDER (P_ac = 0) com o time TSRE

## 📈 Resultados / Dificuldades

- **Progresso atual:** 40%

![Progress](https://progress-bar.xyz/40/)

### ✅ Resultados da Semana

| Módulo/Atividade | Status | Observação |
|------------------|--------|------------|
| **Topologia 4 containers** | ✅ | `comm`, `pade`, `mosaik`, `grid` — um Dockerfile por domínio |
| **Controlador em PADE** | ✅ | `BatteryControllerAgent` sobe e controla bateria via Mosaik (SoC 50%→100%) |
| **IEEE 13 + Smart PV** | ✅ | 288 passos, 5 PVs, CSV com 66 colunas de dados elétricos |
| **Cenário integrado** | ✅ | Comunicação (OMNeT++/PADE) + rede elétrica no mesmo relógio Mosaik |
| **Validação de tensões** | ✅ | Barra 650 = 1.0 pu; trifásicas 0.91–1.05 pu; monofásicas corretas |
| **Geração PV** | ✅ | P_dc segue a curva solar (pico ~5 MW de 15 MW instalados) |
| **Acoplamento inversor → rede** | ⚠️ | P_ac do OpenDER = 0 (inversor não entra em serviço) — pauta TSRE |
| **Dashboard / rastro** | ✅ | `ieee13_dashboard.png` (elétrico) e `grafico_trafego.png` (comunicação) |

### 🔧 Atividades Desenvolvidas na Semana

1. **Fragmentação do TSCC** em três destinos: `comm-opentes` (OMNeT++ + ZMQ), `pade-opentes/agents` (agentes) e `mosaik-opentes` (cenário + collectors).
2. **Consolidação dos collectors** em `mosaik-opentes/collectors/`: `comm_collector.py` (telemetria de rede) e `elec_collector.py` (dados elétricos).
3. **Renomeação** de `tsre-der-opentes` para `grid-opentes`, refletindo o conteúdo (rede elétrica) em vez do nome do time.
4. **Migração do controlador** `BatteryControllerSim` → `pade-opentes/agents/controller_agent.py` (classe `BatteryControllerAgent` + ponte `MosaikCon`), preservando a lógica de charge/discharge.
5. **Quatro Dockerfiles dedicados** e `docker-compose.yaml` com perfis (`ieee13`, `controller-demo`, `integrated`).
6. **Absorção do IEEE 13 + Smart PV** do Paulo Victor (branch `paulo-victor`): dados (`ieee13_pv.dss`, curvas de irradiância/temperatura) e cenário, adaptados para a topologia de 4 containers (apenas o endereçamento mudou: `localhost` → DNS Docker).
7. **Correção de dois bugs** que impediam o IEEE 13 de rodar no Linux:
   - geração das loadshapes `my_shapeN_irrad/temperature` que o `ieee13_pv.dss` referenciava mas não existiam (novo `gen_pv_loadshapes.py`);
   - `Redirect Loadshape.dss` → `LoadShape.dss` (case-sensitive no Linux; o redirect falho abortava a criação dos PVSystems).
8. **Collector elétrico como container remoto** (`elec-collector`), corrigindo o CSV que vinha vazio.
9. **Cenário integrado** `ieee13_integrated.py`: comunicação e rede elétrica no mesmo mundo Mosaik, com `OMNET_STEP`/`PADE_STEP` para alinhar as escalas de tempo.
10. **Script `run_opentes.sh`**: limpeza completa de Docker (todos os perfis + rede + órfãos) antes/depois de cada execução — resolve o erro `network not found / Resource is still in use`.
11. **Validação física** dos CSVs: geração PV coerente com o sol; tensões coerentes com o IEEE 13 desbalanceado.
12. **Re-habilitação do monitoramento de tensões** de barra (V_pu), antes desativado por um erro do scheduler que se mostrou efeito do estado quebrado (PVs sem loadshape).
13. **Dashboard de apresentação** (`plot_ieee13.py`): irradiância, geração, tensões (com limites ANEEL) e temperatura.
14. **Rastreamento da comunicação**: confirmado o percurso de mensagens FIPA-ACL PADE → OMNeT++ → PADE via `results.csv` e logs do Mosaik.
15. **Documentação** das alterações em `ALTERACOES_INTEGRACAO.txt` (seções 9–14) e atualização de `README.md`.

### ⚠️ Dificuldades Enfrentadas

- **CSV elétrico vazio:** diagnosticado como ausência de PVSystems no OpenDSS (loadshapes faltando + case do `Redirect` no Linux), não problema de roteamento do Mosaik como inicialmente suspeitado.
- **Erro `cannot progress backwards`** ao monitorar tensões: era efeito colateral do estado quebrado (PVs ausentes); resolvido junto com os PVs.
- **Simuladores `--remote` (1 conexão por vida):** cada execução exige containers frescos; tratado pelo `run_opentes.sh`.
- **Erro de rede do Docker Compose** (`network not found`): causado por containers de perfil não removidos pelo `down` simples; tratado pelo script de limpeza completa.
- **Inversor OpenDER com P_ac = 0:** o smart inverter co-simulado não entra em serviço; a injeção que aparece na rede vem da loadshape interna do PVSystem. Requer alinhamento com o time TSRE.
- **Verbosidade do TSCC:** os logs da camada de comunicação continuam muito densos.

## 📅 Prazo Estimado

- Acoplamento causal agente → rede e investigação do inversor: **primeiras semanas de junho/2026**.

## 📋 Planejamento para conclusão da entrega

### ✅ Concluído nesta semana

- [x] Topologia de 4 containers funcionais
- [x] Controlador de bateria migrado para agente PADE
- [x] IEEE 13 Bus + Smart PV rodando e validado fisicamente
- [x] Cenário integrado dos 4 componentes
- [x] Script de execução robusto e dashboard de resultados

### 🔄 Próximos passos

- Passo 1. Investigar com o TSRE (Caio) por que o inversor OpenDER não injeta potência (P_ac = 0 / enter-service do IEEE 1547).
- Passo 2. Fechar o acoplamento inversor → OpenDSS para que a injeção venha da co-simulação, não da loadshape interna.
- Passo 3. Implementar o acoplamento causal: decisão de agente (DSO/mercado) influenciando o despacho na rede.
- Passo 4. Alinhar o formato padronizado de colunas dos CSV (padrão "do Beto").
- Passo 5. Reduzir a verbosidade dos logs do TSCC mantendo a rastreabilidade.
- Passo 6. Evoluir o payload artificial dos agentes para mensagens com semântica elétrica/econômica.
- Passo 7. Preparar cenário reproduzível para execução no servidor do laboratório.

## 🔍 Observações Técnicas

A separação por domínio se consolidou em quatro containers:

- `comm` (OMNeT++) — camada de comunicação;
- `pade` (PADE) — camada de agentes/decisão;
- `mosaik` — orquestrador temporal + collectors;
- `grid` (OpenDSS via `py-dss-interface`) — simulador elétrico;
- `docker compose` (+ `run_opentes.sh`) — execução integrada.

A validação mostrou que a **cadeia solar e elétrica é coerente** (geração segue
o sol; tensões dentro da faixa esperada para o IEEE 13 desbalanceado), e que a
**camada de comunicação é rastreável** (mensagens FIPA-ACL registradas com
latência, jitter e perdas). O ponto em aberto mais relevante é o **inversor
OpenDER**, cujo acoplamento com a rede ainda não fecha.

## 🎯 Conclusão

A semana transformou a base integrada em uma plataforma de co-simulação
multidomínio executável de ponta a ponta sobre o IEEE 13 Bus, com quatro
containers funcionais, o controlador de bateria já como agente PADE e resultados
elétricos validados. A próxima fase é qualitativamente diferente: sair da
**coexistência** dos domínios no mesmo relógio para o **acoplamento causal**
entre agentes e rede — começando por destravar o inversor OpenDER junto ao TSRE
e, em seguida, fazer a decisão dos agentes influenciar efetivamente o estado
elétrico do IEEE 13 Bus.
