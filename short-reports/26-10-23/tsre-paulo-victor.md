---
name: "🚀 Relatório de Progresso / Nova tarefa"
about: Utilize este template para documentar avanços em algoritmos, correções ou novas implementações.
title: "[PESQUISA]: Saneamento da Rede ESB01S4, Métricas ANEEL / UFC (Cela et al., 2024) e Pôster EU 2026"
labels: pesquisa, software, eventos, apresentacao
assignees: "Paulo Victor Pereira Lima"
---

## 📌 Descrição da Atividade

Este relatório sintetiza dois marcos do **GREI / DEE / UFC**:
1. **Frente TCC (Alimentador Real ESB01S4):** Saneamento cadastral da BDGD (Enel-CE), correção de modelagem de inversores no OpenDSS (100% de convergência semanal), desacoplamento assíncrono via `ThreadPoolExecutor` com silenciamento POSIX (`os.dup2`), e implementação no notebook principal (`notebooks/analise_tcc_principal.ipynb`) da apuração do **PRODIST Módulo 8 (REN 1.000/2021)** com a desagregação de distúrbios de **Cela et al. (2024 - UFC)**, mantendo foco exclusivo na regulamentação brasileira.
2. **Frente Encontros Universitários 2026 (EU 2026 - PRPPG/UFC):** Automação em Python (`pv_creator`) no alimentador *IEEE European LV Test Case* (906 nós), identificação da Barra Crítica 890, exportação de figuras a **600 DPI** e diagramação final do pôster científico apresentado no **XLV Encontro de Iniciação Científica**, sob orientação do Prof. Dr. Lucas Silveira Melo.

## 🛠 Contexto Técnico

- **Ferramentas:** Python (OpenDSS via Direct DLL / Mosaik v3 / PyBind11 / Pandas / Geopandas / Matplotlib)
- **Repositórios GitHub:** `grei-ufc/ev-charge-analysis-2026` e `grei-ufc/tsre-der-opentes`
- **Branches:** `feature/scenarios-metrics-analysis`, `fix/opendss-voltage-divergence` e `main`

## ✅ Checklist de Entrega

- [x] **Auditoria BDGD:** Remoção de 1.344 cargas desativadas (`SIT_ATIV == 'DS'`), expurgando 955 kW de demanda fantasma.
- [x] **Estabilização OpenDSS:** Correção de 23 PVs monofásicos (eliminação de nós sem admitância $Y_{ii}=0$), 274 PVs trifásicos em $\text{conn}=\text{Delta}$ e modo *pass-through* ($\text{FP}=1{,}0$ puro).
- [x] **Convergência e I/O:** 100% de convergência em 1.008 passos (7 dias / 168 h), isolamento de thread do Mosaik e silenciamento de buffers POSIX via `suprimir_stdout_c`.
- [x] **Métricas Regulatórias ANEEL:** Implementação no notebook da desagregação de Cela et al. (2024), $FD_{95\text{\%}}$, fator de potência e função comparativa `comparar_cenario_ev_aneel`.
- [x] **Pôster EU 2026 Concluído:** Simulação 24h (288 passos), figuras e cartões a 600 DPI, texto telegráfico (`poster.md`) e banner diagramado no template oficial da PRPPG/UFC.

## 📈 Resultados Consolidados

- **Progresso atual (TCC & EU 2026):** 100% [██████████]

---

### 1. Saneamento Cadastral na BDGD e Estabilidade do Solver
- **Alívio de 955 kW Fantasmas:** A auditoria da tabela `UCBT_tab` (`Enel_CE_39_2024-12-31_V11.gdb`) revelou 1.344 cargas desativadas ignoradas pelo conversor original. A sua remoção aliviou o transformador crítico `TRF_TOK5079A` (150 kVA) de **352,8% para 66,8% de carregamento**, sanando o colapso numérico da rede.
- **Modelagem Física de Inversores:** 23 geradores monofásicos parametrizados como trifásicos foram corrigidos (`phases=1 conn=Wye kV=0.22`), eliminando singularidades ($Y_{ii}=0$) e sobretensões espúrias $>16\text{ pu}$. Os geradores trifásicos foram mantidos em $\text{conn}=\text{Delta}$ para bloquear circulação de sequência zero ($I_0$), e travados em $\text{FP}=1{,}0$ puro (ABNT NBR 16149).

---

### 2. Desagregação PRODIST Módulo 8 (Cela et al., 2024 - UFC)
Para expor a causa física dos distúrbios, aplicou-se a formulação proposta por pesquisadores da UFC:

$$\text{DRP} = \text{DRP}_{\text{sub}} + \text{DRP}_{\text{sob}} = \left( \frac{n_{\text{prec,sub}}}{N} \right) \times 100\% + \left( \frac{n_{\text{prec,sob}}}{N} \right) \times 100\%$$

$$\text{DRC} = \text{DRC}_{\text{sub}} + \text{DRC}_{\text{sob}} = \left( \frac{n_{\text{crit,sub}}}{N} \right) \times 100\% + \left( \frac{n_{\text{crit,sob}}}{N} \right) \times 100\%$$

Onde $N = 1008$ passos temporais semanais. Faixas normativas da Baixa Tensão ($220\text{ V} / 380\text{ V}$):
- **Subtensão Precária ($\text{DRP}_{\text{sub}}$):** $0{,}87 \le V < 0{,}92\text{ pu}$
- **Sobretensão Precária ($\text{DRP}_{\text{sob}}$):** $1{,}05 < V \le 1{,}06\text{ pu}$
- **Subtensão Crítica ($\text{DRC}_{\text{sub}}$):** $V < 0{,}87\text{ pu}$
- **Sobretensão Crítica ($\text{DRC}_{\text{sob}}$):** $V > 1{,}06\text{ pu}$

**Apuração Global do Caso Base (0 VEs):**

| Fase | DRP Total (%) | $\text{DRP}_{\text{sub}}$ (%) | $\text{DRP}_{\text{sob}}$ (%) | DRC Total (%) | $\text{DRC}_{\text{sub}}$ (%) | $\text{DRC}_{\text{sob}}$ (%) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Fase A** | $10{,}50\%$ | **$0{,}00\%$** | $10{,}50\%$ | $28{,}44\%$ | **$0{,}00\%$** | $28{,}44\%$ |
| **Fase B** | $12{,}32\%$ | **$0{,}00\%$** | $12{,}32\%$ | $26{,}96\%$ | **$0{,}00\%$** | $26{,}96\%$ |
| **Fase C** | $10{,}07\%$ | **$0{,}00\%$** | $10{,}07\%$ | $25{,}87\%$ | **$0{,}00\%$** | $25{,}87\%$ |

> **Achado do TCC:** $100\%$ das violações de QEE decorrem de **sobretensão solar diurna** ($3.168\text{ kW}$ de pico dos 303 geradores FV em $\text{FP}=1{,}0$). A inexistência de subtensões comprova que a recarga de Veículos Elétricos drenará esse excedente diurno, mitigando as sobretensões da rede.

---

### 3. Desbalanceamento Nodal e Dinâmica da Linha Tronco
- **Fator de Desbalanceamento (FD% / VUF%):** Restrito às 1.978 barras genuinamente trifásicas ($V_1, V_2, V_3 > 0{,}5\text{ pu}$), expurgando ramais monofásicos que distorciam a formulação:

$$\text{FD} = \frac{\max\left(|V_A - V_m|,\, |V_B - V_m|,\, |V_C - V_m|\right)}{V_m} \times 100, \quad V_m = \frac{V_A + V_B + V_C}{3}$$

  - FD Médio Global: **0,783%** | $\text{FD}_{95}$ Médio: **1,000%** | Conformidade ($\text{FD}_{95} \le 2{,}0$%): **85,34%**.
- **Fator de Potência no Tronco:** Demanda máxima de $1.393{,}63\text{ kW}$ ($1{,}39\text{ MW}$). A injeção solar diurna reduz a potência ativa líquida enquanto a demanda reativa dos transformadores persiste, derrubando o FP abaixo de 0,92 em 77,68% das horas diurnas (*duck curve*).
---

### 4. Ativos e Pôster Científico dos Encontros Universitários (EU 2026)
- **Automatização Computacional:** Rotina `pv_creator` aloca 91 sistemas fotovoltaicos (470,7 kVA) na rede *IEEE European LV Test Case* (906 nós) em **menos de 3 segundos**.
- **Identificação da Barra Crítica:** Sob 10% de penetração FV, a **Barra 890 (Fase 2)** atinge pico extremo de **$1{,}1333\text{ pu}$** às 12h45, com $100\%$ das barras violando o limite de $1{,}05\text{ pu}$ do PRODIST. A sobretensão contínua ocorre a partir de 2% de penetração.
- **Produção Visual em 600 DPI:** Mapas espaciais e curvas temporais geradas em ultra-alta resolução e paleta acessível (Okabe-Ito), integradas ao layout de duas colunas do template oficial da PRPPG/UFC.

## 📅 Prazo Estimado

- Data de entrega pretendida: **23/10/2026** (Atendida).

## 📋 Planejamento para Próximos Passos

- [ ] **Passo 1:** Impressão gráfica do banner físico e ensaio da apresentação oral para o XLV Encontro de Iniciação Científica (EU 2026).
- [ ] **Passo 2:** Simulação dos cenários de penetração de VEs no alimentador ESB01S4.
- [ ] **Passo 3:** Executar o módulo `comparar_cenario_ev_aneel` para quantificar o alívio das sobretensões solares viabilizado pela mobilidade elétrica.
