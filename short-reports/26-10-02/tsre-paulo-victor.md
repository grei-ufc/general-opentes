---
name: "🚀 Relatório de Progresso / Nova tarefa"
about: Utilize este template para documentar avanços em algoritmos, correções ou novas implementações.
title: "[PESQUISA]: Conclusão da Integração do Motor Físico Caldera ICM (EVs) na Co-Simulação"
labels: pesquisa, software
assignees: "Paulo Victor"
---

## 📌 Descrição da Atividade

Este relatório consolida a finalização da nova arquitetura de modelagem dos Veículos Elétricos (EVs). O trabalho evoluiu do equacionamento matemático preliminar de telemetria até a construção de uma ponte estável (Wrapper em Python via Mosaik) com o motor físico C++ do laboratório de Idaho (**Caldera ICM**). 

Nesta semana, os orquestradores de dados (`pipeline_ev.py`) foram totalmente concluídos. Agora implementamos um mapeamento estocástico preciso ancorado nos dados da **ABVE (Associação Brasileira do Veículo Elétrico)**, pareando carros e *Wallboxes* reais da frota brasileira para simular o *tapering* no Caldera. Além disso, enfrentou-se desafios críticos: horas exaustivas para isolamento de um bug silencioso no solver do OpenDSS, interoperabilidade por engenharia reversa via *pybind11*, injeção capacitiva/indutiva (normas IEC) e uma pesada refatoração dos simuladores estáticos da pasta `old/`.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X) Outra: C++ (PyBind11) / OpenDSS / Mosaik
- **Repositório no GitHub**: `grei-ufc/ev-charge-analysis-2026`
- **Branch de Trabalho:** `feature/caldera-icm-integration` e `main`
- **Requisitos Associados:** 
  1. Parametrização da injeção com modelos reais de carros elétricos mais vendidos no Brasil (ABVE).
  2. Integração C++/Python do motor eletroquímico para emular o limitador temporal de *tapering* nos transformadores.
  3. Injeção bidirecional (P e Q) acoplada a sorteio de Fator de Potência para testes de desequilíbrio PRODIST BT.
  4. Resolução de bugs primários herdados da arquitetura OpenTES/Mosaik nativa.

## ✅ Checklist de Entrega

- [x] Extração estocástica baseada no market-share e exportação do banco mestre `ev_sessions_caldera.csv`.
- [x] Mapeamento topológico de *Wallboxes* (cargas críticas monofásicas de 32A).
- [x] Construção do Wrapper Python (`caldera_wrapper.py`) conectando Mosaik às estruturas do INL Caldera.
- [x] Engenharia reversa via inspeção de memória nos binários `.so` (geração do dicionário `caldera_api_docs_full.txt`).
- [x] Implementação física de injeção reativa via restrições do Active PFC (IEC 61000-3-2/12).
- [x] Mapeamento e correção estrutural definitiva do *bug* de divergência matricial (Passo 0) no `setup_done()` do Mosaik.

## 📈 Resultados / Dificuldades

- **Progresso atual (Etapa VEs):** 100% [██████████]

Detalhes técnicos, modelagens estatísticas e fundamentação física aplicadas no orquestrador:

### 1. Arquitetura da Solução (Co-simulação Mosaik + Caldera)
Para acomodar a complexidade C++ do Caldera, a arquitetura agora flui através de uma matriz de tempo isolada, despachada ativamente ao longo dos milissegundos para a API do Mosaik.

<img width="3590" height="8192" alt="Untitled diagram-2026-10-02-142508" src="https://github.com/user-attachments/assets/7d4f73a7-d1f0-4225-b2ce-7c0eb5a5ffec" />


### 2. Inventário de Frota, Wallboxes e Alocação Estocástica (Monte Carlo)
A modelagem abandonou o conceito de carros "genéricos". O Caldera exige que cada residente possua um banco de baterias especificado em catálogos e um inversor AC (*Wallbox*) próprio.

**A. Inventário ABVE (Top 10 Brasil):**
Adotou-se o relatório oficial da ABVE (vendas acumuladas Jan/2022 a Ago/2026), inserindo BEVs e PHEVs reais:

| Ranking | Modelo | Fabricante | Capacidade da Bateria | Tipo | Qtd. Vendida |
| :---: | :--- | :--- | :--- | :--- | :--- |
| 1 | BYD DOLPHIN MINI GS5EV | BYD | 38,88 kWh | BEV | 80.820 |
| 2 | BYD DOLPHIN GS 180EV | BYD | 44,90 kWh | BEV | 58.259 |
| 3 | BYD SONG PLUS GS DM | BYD | 18,30 kWh | PHEV | 57.821 |
| 4 | BYD SONG PRO GS DM | BYD | 18,30 kWh | PHEV | 40.565 |
| 5 | BYD KING GS DM | BYD | 18,30 kWh | PHEV | 22.091 |
| 6 | GEELY EX2 MAX | GEELY | 39,40 kWh | BEV | 17.966 |
| 7 | GWM HAVAL H6 PHEV 19 | GWM | 19,00 kWh | PHEV | 16.980 |
| 8 | BYD SONG PRO GL DM | BYD | 12,96 kWh | PHEV | 15.848 |
| 9 | BYD DOLPHIN MINI GS EV | BYD | 38,88 kWh | BEV | 15.827 |
| 10 | GWM HAVAL H6 GT | GWM | 35,00 kWh | PHEV | 14.576 |

**B. Especificação dos Carregadores:** 
Em conjunto com o veículo, definiu-se a *Wallbox*. Foi utilizado o equipamento de cortesia real das montadoras asiáticas no Brasil, consistindo em carregadores monofásicos limitados a **7 kW (32 A em 220V Fase-Neutro)**. Esta escolha cria implicações topológicas diretas: cada carro se tornará um dreno massivo de 32 amperes pendurado em uma única fase do transformador da rua, maximizando cenários severos de correntes pelo neutro da rede elétrica.

**C. Lógica de Atribuição (Monte Carlo Restrito):** 
Os veículos noruegueses (dados brutos) foram convertidos para brasileiros usando roleta probabilística baseada no *market-share*. Porém, aplicou-se uma Trava Física de Consistência: o veículo sorteado obrigatoriamente deve atender à premissa $\mathbf{C_{bateria} \ge E_{max}}$ (A capacidade do carro em kWh tem de ser superior ao evento de recarga mais agressivo que o morador já fez na semana). Caso contrário, a roleta é acionada novamente.

### 3. Engenharia Reversa da API do Caldera (PyBind11)
A integração técnica sofreu com a ausência de documentação. O módulo C++ via `pybind11` ofuscava assinaturas para a IDE. Através de engenharia reversa — rotinas exploratórias de memória (`dir()`, `getattr`) —, capturou-se a matriz descritiva do binário nativo, salvando-a em `caldera_api_docs_full.txt`. Esse "mapa do tesouro" provou a existência de amarrações não publicadas da classe mestra `CP_interface_v2`.

### 4. A Camada C++ e a Química NMC (Proxy para LFP)
A exploração revelou que o laboratório de Idaho (INL) obriga as células a serem do tipo LTO, LMO ou **NMC**. Como 90% da frota BYD/GWM usa baterias de Lítio-Ferro-Fosfato (**LFP** / *Blade Battery*), utilizamos intencionalmente a tecnologia **NMC** como Proxy Eletroquímico. A arquitetura de *BMS* regula ambas as químicas da mesma maneira na tomada AC (tensão constante CC seguida de grampeamento de segurança CV), garantindo fidelidade no decaimento do perfil, não afetando os indicadores do OpenDSS.

### 5. Injeção de Reativos Dinâmica e Override do OpenDSS
Na simulação, as pontes AC/DC sofrem imposição da técnica *Active PFC* pelas normas IEC 61000-3-2 e 12. Devido à presença de filtros EMI de entrada, há ligeiras defasagens não resistivas na corrente.
O módulo introduz isso no motor da EPRI de maneira estocástica. Atribui-se o FP ($\mathcal{U}(0{,}98;\, 1{,}00)$), calcula-se o tangenciamento angular, e durante cada *step*, a propriedade `Load` do OpenDSS sofre uma cláusula direta na memória (*Override*):
`sim.dss_wrapper.set_power(name="Load.casa_1", p=P_real, q=Q_indutivo_emulado, element="Load")`
Essa ponte finaliza o status da rede de Eusébio (ESB01S4) como um verdadeiro Gêmeo Digital bidirecional e adaptável.

### 6. Resolução Crítica: Divergência de Matriz no OpenDSS (O Problema dos 14 Milhões de Volts)
Durante a integração, esbarramos em um bug destrutivo e silencioso herdado da arquitetura base (documentado extensivamente em `relatorio_divergencia_opendss.md`), que corrompia a co-simulação logo na primeira iteração (Passo 0). As tensões explodiam para níveis estratosféricos no Mosaik, mesmo com o arquivo nativo `.dss` convergindo perfeitamente fora dele.
* **A Investigação:** Após horas de isolamento cirúrgico de variáveis, injeção sistemática de rastreios nos *callbacks* (`setup_done`, `step`) e *dumps* em tempo real das matrizes, mapeou-se a anomalia.
* **A Causa Raiz:** O Mosaik invoca um `run_dss()` preliminar (às 00:00 da madrugada) no método `setup_done()`. O método de *bypass* antigo neutralizava a eficiência dos painéis solares, mas falhava em desvincular a curva solar diária nativa (`daily`). Devido à irradiação próxima a zero da meia-noite, os +300 inversores fotovoltaicos caiam instantaneamente em `%cutout` e desconectavam-se juntos. Isso quebrava a matriz Jacobiana (Newton-Raphson), cravando o solve do estado inicial (vazio) em inacreditáveis **14.000.000 de Volts**.
* **A Solução:** Alteramos cirurgicamente o núcleo de *bypass* nativo, impondo `daily="" TDaily="" irradiance=0.0`. Essa modificação blindou o comportamento temporal original, transferindo 100% da responsabilidade solar ao Mosaik e assegurando convergência plana e perfeita (1.03 PU) no Passo 0.

## 📅 Prazo Estimado

- Data de entrega pretendida: 30/09/2026 (Atendida)

## 📋 Planejamento para conclusão da entrega

- **Passo 1:** Consolidar e revisar *Merge Request* da branch `feature/caldera-icm-integration`.
- **Passo 2:** Iniciar a criação de *notebooks* Jupyter analíticos para cruzar perdas e estresses no transformador com altas densidades da frota.
- **Passo 3:** Correlacionar visualmente os *heatmaps* da subestação ESB01S4 a cada degrau de penetração.
