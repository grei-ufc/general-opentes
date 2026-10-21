---
title: "Relatório Final de Projeto — TSCC"
subtitle: "Time de Simulação de Comunicação e Co-simulação"
author:
  - "Equipe TSCC (Laiza Edwigens Rocha Silva e Rafael dos Santos Moura)"
  - "OpenTES"
date: "2026-10-20"
lang: "pt-BR"
toc: true
toc-title: "Sumário"
numbersections: true
documentclass: article
papersize: a4
fontsize: 10pt
linestretch: 1.5
mainfont: "EB Garamond"
sansfont: "DejaVu Sans"
monofont: "DejaVu Sans Mono"
colorlinks: true
linkcolor: blue
urlcolor: blue
citecolor: blue
geometry:
  - top=2.7cm
  - bottom=2.7cm
  - left=3.0cm
  - right=2.5cm
  - headsep=0.8cm
  - footskip=1.2cm
header-includes:
  - |
    \usepackage{booktabs}
  - |
    \usepackage{longtable}
  - |
    \usepackage{float}
  - |
    \usepackage{graphicx}
  - |
    \usepackage{caption}
  - |
    \usepackage{amsmath}
  - |
    \usepackage{amssymb}
  - |
    \usepackage{fancyhdr}
  - |
    \pagestyle{fancy}
    \fancyhf{}
    \lhead{OpenTES — TSCC}
    \rhead{\nouppercase{\leftmark}}
    \cfoot{\thepage}
pdf-engine: xelatex
---

> **Nota de escopo:** versão de 20/10/2026, elaborada a partir dos 26 *short-reports* semanais do TSCC (20/02 a 02/10/2026), da análise do repositório [`tscc-com-opentes`](https://github.com/grei-ufc/tscc-com-opentes) na branch `development` (commit `1309b9a`, 25/09/2026) e da **validação experimental e correção das inconsistências** realizada na branch `fix/validacao-e-consistencia`. Documento limitado a **12 páginas**.

# Sumário Executivo

O time TSCC (Laiza Rocha e Rafael Moura) desenvolveu, entre fevereiro e outubro de 2026, uma plataforma de co-simulação que acopla **agentes PADE** (camada cognitiva, mensagens FIPA-ACL), o simulador de rede **OMNeT++** (camada física de comunicação) e o orquestrador **Mosaik**, executados em três containers Docker e sincronizados em *lock-step* via **ZeroMQ**. O objetivo é substituir a hipótese de comunicação ideal entre agentes por uma rede com latência, jitter, perda, filas finitas e posição geográfica.

O ponto de partida (fev./2026) era um bloqueio de infraestrutura: o container do OMNeT++ não iniciava. Hoje a plataforma suporta três topologias (estrela, malha completa e anel) escaláveis até centenas de agentes, cinco tecnologias de enlace (Cabeada, 5G, Wireless, 4G e 2G) atribuíveis por enlace ou por agente, telemetria de alta resolução e dashboards automáticos, tudo configurável por uma interface web (Streamlit) ou pelo terminal. O repositório tem 87 commits na branch `development` e cerca de 3 mil linhas nos módulos principais.

A auditoria inicial da branch `development` revelou inconsistências de modelagem e engenharia (contagem divergente de agentes no anel e na malha, inativação silenciosa do atraso espacial em `cDatarateChannel`, ausência de consulta ao `hasBitError()` para o PER do canal, condição de corrida por temporizador `call_later` no PADE e ausência de testes e sementes fixas). Nesta revisão, **essas inconsistências estruturais foram corrigidas e validadas** na branch `fix/validacao-e-consistencia` por meio de uma suíte automatizada (`pytest`) com compilação/física C++17 (`AgentNode.cc` e `MosaikBridge.cc`) e co-simulações fim a fim determinísticas (`RANDOM_SEED=42`) nas três topologias (Seções 5.2 e 5.4). Os próximos passos concentram-se na consolidação na branch `main`, campanhas estatísticas multi-semente e acoplamento aos demais times do OpenTES.

# Introdução

## Contextualização

Sistemas ciberfísicos no domínio energético dependem da troca coordenada de informações entre controladores, agentes, sensores e simuladores especializados. Nesses sistemas a comunicação influencia diretamente a validade dos resultados: atrasos, perdas, jitter e saturação de canais podem alterar a dinâmica observada em estratégias distribuídas, como leilões de energia e coordenação de recursos energéticos distribuídos.

No projeto OpenTES (Arcabouço Computacional e Tecnológico aplicado a Redes Elétricas Inteligentes), o TSCC é responsável pela frente de **simulação de comunicação e co-simulação**, uma das quatro frentes do projeto, ao lado de modelagem econômica, rede elétrica e qualidade de energia. O código-fonte está em `grei-ufc/tscc-com-opentes`.

## Motivação

Em simulações de sistemas multiagentes (SMA) é comum assumir mensagens instantâneas e sem perdas. Isso impede avaliar a robustez de uma estratégia sob infraestrutura real. A motivação do time foi tornar a rede uma **variável experimental**: o pesquisador escolhe topologia, tecnologia de enlace e escala, e observa o efeito sobre o tráfego dos agentes. Há também uma motivação de engenharia: conectar ferramentas heterogêneas (Python/Twisted, C++/OMNeT++, Mosaik) de forma reprodutível e operável por terceiros, o que levou à conteinerização e às interfaces de configuração.

## Justificativa

A camada de comunicação é o elo entre os demais times do OpenTES. Decisões tomadas nela (formato de mensagem, granularidade temporal, política de filas) condicionam como outros módulos serão acoplados. A revisão bibliográfica da equipe indicou ainda uma lacuna: o trabalho de referência na área, o COSIMA, não detalha a justificativa da estrutura de co-simulação, não compara desempenho entre topologias e não explica a conteinerização. Documentar e avaliar essas escolhas é, portanto, também uma contribuição científica.

## Objetivos

### Objetivo geral

Construir e documentar uma plataforma de co-simulação PADE + OMNeT++ + Mosaik que represente, com fidelidade configurável, os efeitos de redes de comunicação heterogêneas sobre sistemas multiagentes em redes elétricas inteligentes.

### Objetivos específicos

1. Integrar PADE, Mosaik e OMNeT++ em containers separados, com sincronismo determinístico.
2. Modelar latência, jitter, perda de pacotes, congestionamento e efeito de distância, com perfis de tecnologia (cabeada, 5G, Wireless, 4G, 2G).
3. Suportar múltiplas topologias (estrela, malha, anel) com escalabilidade dinâmica.
4. Prover telemetria e dashboards que permitam comparar tecnologias e topologias.
5. Facilitar o uso e a reprodução (interface web/CLI e documentação).
6. Revisar a literatura (COSIMA, PADE e Mango) e produzir um artigo científico.

# Estado da Arte e Revisão Bibliográfica

A revisão concentrou-se na família de trabalhos do **COSIMA**, que acopla o Mosaik ao OMNeT++ para simular a infraestrutura de comunicação de sistemas de energia. O ponto de partida técnico da equipe foi reproduzir o exemplo do COSIMA em containers (fev./mar. 2026). A versão atual não depende do COSIMA: o acoplamento Mosaik–OMNeT++ foi reescrito sobre ZeroMQ, com criação dinâmica de nós a partir de um arquivo NED gerado em tempo de execução.

O artigo *cosima-mango: Investigating Multi-Agent System robustness through integrated communication simulation* foi revisado em detalhe, com foco na comparação entre os frameworks de SMA **PADE** e **Mango**. A Tabela 1 resume a comparação feita pela equipe. Como parte dela foi conferida com apoio de um modelo de IA, deve ser validada contra a documentação primária antes da publicação.

| Critério | PADE | Mango |
|---|---|---|
| Foco | Redes elétricas inteligentes | Propósito geral |
| FIPA/AMS | Nativo | Implementação a cargo do usuário |
| Base assíncrona | Twisted | `asyncio` |
| Integração com Mosaik | Driver pronto (API 3.0+) | Orquestrador de tempo e *wrappers* a cargo do usuário |
| Logging | CSV nativo | A cargo do usuário |

Table: Comparação estrutural PADE × Mango (revisão do TSCC, jul./2026).

Em relação à literatura revisada, o diferencial do trabalho do TSCC é: (i) uso de uma versão atualizada do PADE; (ii) conteinerização documentada da co-simulação; (iii) comparação planejada entre topologias e tecnologias de enlace; e (iv) comunicação FIPA-ACL pura entre agentes, com a rede simulada invisível para a aplicação.

# Materiais e Métodos

O desenvolvimento foi incremental, com ciclos semanais de implementação, teste e relato em *short-reports*, em branches de trabalho (`caminho2`, `development-1`, `feature/cosima-base`, `integration`, `main`, `development`, e `fix/validacao-e-consistencia`).

## Ambiente e ferramentas

| Componente | Papel | Versão / observação |
|---|---|---|
| PADE | Agentes FIPA-ACL (Twisted) | `pade-agents==0.1.3`; Twisted 24.7.0 |
| Mosaik | Orquestração e tempo simulado | 3.6.0; `mosaik-api-v3` 3.0.14 |
| OMNeT++ | Simulação de rede (C++) | Imagem `omnetpp/omnetpp:u22.04-6.0` (C++17) |
| ZeroMQ | Transporte Mosaik–OMNeT++ (REQ/REP, porta 5555) | `pyzmq` 27.1.0 (Mosaik) e 26.0.3 (PADE); `cppzmq` |
| `nlohmann/json` | Serialização no lado C++ | Pacote do Ubuntu 22.04 |
| Docker Compose | Orquestração de 3 containers na rede `sim_net` | Python 3.12 nos containers Python |
| Streamlit, Plotly, Matplotlib | Interface web, dashboards e suíte `pytest` | Pré-instalados nos Dockerfiles e validados em Python 3.12 |

Table: Ferramentas e versões utilizadas no repositório.

## Arquitetura

A Figura 1 apresenta a arquitetura. Os agentes PADE enviam mensagens com `send()`. Um **interceptador** sobrescreve esse método: mensagens da ontologia de simulação (`telemetria_rede` em estrela e malha, `malha_restrita` no anel) são serializadas em JSON (performativa, remetente, destinatários, conteúdo, ontologia, `conversation_id`) e acumuladas no atributo `val_out`, separadas por `|||`. Mensagens de controle do PADE (AMS) seguem pelo caminho nativo. O Mosaik transfere `val_out` ao nó correspondente do OMNeT++ (`val_in`) e devolve as mensagens entregues ao agente no passo seguinte, com `time_shifted=True`, que quebra o ciclo de causalidade.

\begin{figure}[H]
\centering
\small
\begin{verbatim}
+----------+  val_out  +-----------+   STEP   +-----------+
| pade     |---------->| mosaik    |--------->| omnet_sim |
| agentes  |           | scenario  |   ZMQ    | Mosaik-   |
| FIPA-ACL |<----------| collector |  REQ/REP | Bridge +  |
| Twisted  |  val_in   | plots     |<---------| AgentNode |
+----------+           +-----+-----+          +-----------+
                             |
                   results.csv + dashboards
\end{verbatim}
\caption{Arquitetura da co-simulação: três containers na rede Docker \texttt{sim\_net}, configurados por variáveis de ambiente (\texttt{TOPOLOGY}, \texttt{NUM\_PERIFERICOS}, \texttt{TIPOS\_REDE}, \texttt{RANDOM\_SEED}) definidas pela interface web ou pelo CLI.}
\end{figure}

O `MosaikBridge.cc` mantém um socket ZeroMQ `REP` bloqueante. A cada passo, o `omnet_wrapper.py` (cliente `REQ`) envia as entradas, o OMNeT++ avança um tick (`scheduleAt(simTime()+timeResolution)`) e responde com as saídas, o passo atual (`mosaik_step`) e a telemetria. Como cada lado espera a resposta do outro, o sincronismo é garantido por construção. O `scenario.py` lê `TOPOLOGY`, `NUM_PERIFERICOS`, `TIPOS_REDE` e `RANDOM_SEED`, sorteia as posições em uma área de 1000 × 1000 m (anel: círculo de raio 350 m), persiste `posicoes.json`, `links.json` e `config.json`, gera atomicamente o `DynamicNetwork.ned` e cria as entidades no Mosaik.

## Topologias e perfis de enlace

| Topologia | Agentes | Enlaces | Comportamento dos agentes |
|---|---|---|---|
| Estrela | 1 central + N periféricos | N | Central faz *broadcast*; periféricos respondem ao central |
| Malha completa | N *peers* (`NUM_PERIFERICOS`) | $N(N-1)/2$ | Todos enviam a todos a cada passo |
| Anel | N *peers* (`NUM_PERIFERICOS`) | N (ciclo fechado) | Cada agente envia aos dois vizinhos |

Table: Topologias suportadas (semântica unificada na branch `fix/validacao-e-consistencia`).

| Perfil | Banda | Atraso | PER (canal) |
|---|---|---|---|
| Cabeada | 1 Gbps | 1 ms fixo | 0 |
| 5G | 500 Mbps | truncnormal(5 ms; 1 ms) | 0,001% |
| Wireless | 300 Mbps | truncnormal(2 ms; 0,5 ms) | 0,1% |
| 4G | 50 Mbps | truncnormal(35 ms; 8 ms) | 0,5% |
| 2G | 250 kbps | exponential(200 ms) | 15% |

Table: Perfis de enlace definidos em `Profiles.ned`. Os tipos são atribuídos ciclicamente aos enlaces ou, na interface, por agente.

## Modelo de rede implementado no nó

O módulo `AgentNode.cc` implementa: (i) fila de transmissão por porta (`cPacketQueue`), limitada a 5 pacotes (`getLength() >= 5`), com descarte do excedente (*buffer overflow*); (ii) descarte no receptor tanto por erro de bit nativo do canal (`pkt->hasBitError()`, regido pelo PER de `Profiles.ned`) quanto por atenuação espacial dependente de distância e tamanho; (iii) atraso adicional por distância ($50\,\mu\text{s/m}$) e ruído de jitter sobre o atraso-base em canais `cDatarateChannel` e `cDelayChannel`; e (iv) telemetria por pacote (tamanho, latência, jitter), exportada em strings multiplexadas com `|||`. Em notação simplificada, com $d$ em metros e $S$ em bytes:

$$
P_{\text{drop,dist}} = \min\!\left(0{,}99;\ \frac{d}{100}\,0{,}015\,\max\!\left(1;\frac{S}{15000}\right)\right),
\qquad
L = d_{\text{canal}} + \frac{8S}{R} + 5\times10^{-5}\,d + \eta
$$

em que $R$ é a taxa do canal, $d_{\text{canal}}$ o atraso do perfil NED e $\eta$ um ruído de até 25% do atraso-base (aplicado quando este excede 1,5 ms). As métricas reportadas são latência fim a fim, jitter (diferença absoluta entre latências consecutivas por origem), razão de entrega $\text{PDR}=\text{recebidos}/\text{enviados}$ e tamanho de payload.

# Resultados e Discussão

## Evolução do desenvolvimento

| Período | Marco principal |
|---|---|
| Fev.–mar. | Containers separados Mosaik e OMNeT++; correção de conflito de portas; co-simulação via ZeroMQ (`results.csv` com `data_out` 0 a 9); medição de latência e teste de escalabilidade |
| Abr. | Contador de passos e `time_resolution`; ciclo de realimentação `time_shifted`; modo híbrido (eventos não persistentes) no PADE; Mosaik 3.6.0; ciclo "ping-pong" bidirecional com latência $10\,\text{ms}+\text{bits}/\text{banda}$ |
| Mai. | Banda configurável, perda e jitter estocásticos; topologia estrela (`pade_star.py`); telemetria multiplexada; protótipo de CLI; estudo de parâmetros 5G e Wi-Fi |
| Mai.–jun. | Migração para FIPA nativo (`send()`/`react()`), com filas anti-sobrescrita; NED elástico; canais `DatarateChannel` heterogêneos; início do artigo |
| Jul. | Revisão bibliográfica; nós independentes com filas e rajadas (*bursts*); roteamento pelo campo `receivers`; 50+ agentes via variável de ambiente; perfis 4G/5G/IoT |
| Ago. | Posicionamento geográfico e atraso/descarte por distância; dashboards refatorados; topologias malha e anel; menu e interface Streamlit |
| Set.–out. | Anel escalável; ícones SVG, tecnologia por agente, aba de resultados; documentação Diátaxis iniciada; **auditoria, correção de inconsistências e suíte de validação automatizada (`pytest`)** |

Table: Cronologia sintética (detalhes nos *short-reports* semanais).

Dois problemas relevantes foram resolvidos ao longo do desenvolvimento inicial: a **perda de mensagens por concorrência temporal** (resolvida com a fila delimitada por `|||` nos dois lados) e o **gargalo do canal ocupado** em rajadas (resolvido com filas reais no C++ e descoberta automática da identidade do nó via `getName()`).

## Dados de execução: linha de base (`development`) vs. execução validada (`fix/validacao-e-consistencia`)

As Figuras 2 e 3 reproduzem os dashboards originalmente versionados na branch `development` (`1309b9a`), antes das correções de física de canal e sincronismo. A Figura 4 e a Tabela 6 apresentam o resultado da execução validada (`RANDOM_SEED=42`, 20 passos) após as correções.

![Dashboard original da topologia estrela na branch `development` (1 central + 20 periféricos; 654 mensagens, antes da correção do `cDatarateChannel` e do `hasBitError()`).](figures/tscc/dashboard_estrela_n20.png){ width=96% }

![Dashboard original da topologia malha completa na branch `development` (5 nós, 10 enlaces; 380 pacotes).](figures/tscc/dashboard_malha_n5.png){ width=86% }

![Dashboard validado da topologia estrela após correção das inconsistências (`fix/validacao-e-consistencia`, `RANDOM_SEED=42`, 20 passos; 747 mensagens, conservação exata $684+63=747$).](figures/tscc/dashboard_estrela_n20_validado.png){ width=96% }

| Rede | Lat. média (antes) | Lat. média (validada) | Jitter médio (validado) | PDR (antes) | PDR (validado) | Amostras (validadas) |
|---|---:|---:|---:|---:|---:|---:|
| Cabeada | 1,0 ms | 20,1 ms | 0,0 µs | 99,2% | 100,0% | 156 |
| Wireless | 1,8 ms | 23,9 ms | 659,9 µs | 99,2% | 96,5% | 136 |
| 5G | 5,1 ms | 26,8 ms | 1209,2 µs | 98,4% | 98,0% | 148 |
| 4G | 36,6 ms | 48,2 ms | 8952,7 µs | 98,4% | 94,6% | 139 |
| 2G | 183,9 ms | 223,5 ms | 161078,2 µs | 96,6% | 84,7% | 105 |
| **Global** | **43,67 ms** | **59,24 ms** (P95: 242,04 ms) | **26939,10 µs** | **96,3%** | **91,6%** | **684** (de 747 env.) |

Table: Comparação antes × depois na topologia estrela ($N=20$, 20 passos, `RANDOM_SEED=42`).

## Discussão

**Impacto físico das correções.** A comparação na Tabela 6 comprova experimentalmente os três diagnósticos da auditoria de código:
1. *Ativação do atraso espacial e do jitter em `cDatarateChannel`:* na linha de base (`development`), a rede Cabeada exibia exatamente `1,0 ms` de latência porque `dynamic_cast<cDelayChannel*>` retornava `nullptr` para `ned.DatarateChannel`. Após o suporte a `cDatarateChannel` em `AgentNode.cc`, a rede Cabeada passou a exibir **20,1 ms** (1,0 ms base + atraso de propagação proporcional à distância $50\,\mu\text{s/m}$) e **0,0 µs** de jitter (pois o atraso-base de 1,0 ms não excede o limiar de 1,5 ms), enquanto Wireless, 5G, 4G e 2G passaram a refletir tanto o atraso espacial quanto a variabilidade estocástica de jitter.
2. *Ativação do PER nativo (`hasBitError()`):* na linha de base, o enlace 2G apresentava PDR de `96,6%`, incompatível com o `per = 0.15` (15%) declarado em `Profiles.ned`. Com a verificação de `pkt->hasBitError()` em `AgentNode::handleMessage`, o PDR do 2G caiu para **84,7%**, alinhado aos 15% de erro de canal somados à atenuação por distância, enquanto a rede Cabeada (`per = 0.0`) atingiu **100,0%** de entrega nas amostras associadas.
3. *Eliminação da condição de corrida no PADE:* a substituição de `self.call_later(0.1, ...)` por envio síncrono no buffer `self.val_out` durante `step(t)` eliminou a perda de respostas entre passos rápidos do Mosaik, elevando o total de mensagens processadas em 20 passos de **654** para **747** ($684\text{ recebidas} + 63\text{ descartadas} = 747\text{ enviadas}$).

**Granularidade temporal.** Cada passo do Mosaik corresponde a 1 s simulado, enquanto as latências típicas são de milissegundos. Como o agente recebe a mensagem no passo seguinte (`time_shifted`), diferenças de latência de 1 ms a 250 ms **não alteram a ordem de decisão intra-passo dos agentes**, apenas as métricas; o efeito sobre o controle distribuído ocorre hoje sobretudo por descarte de pacotes.

## Limitações, débitos técnicos e validação corretiva executada

Foi implementada em `tests/test_validation_suite.py` (apoiada pelo emulador discreto `tests/omnet_zmq_emulator.py`) uma suíte automatizada com 4 testes (`pytest`), todos aprovados (`4 passed`): (i) `test_cpp_agentnode_and_mosaikbridge_physics`, que compila `AgentNode.cc` com C++17 e verifica atraso espacial em `cDatarateChannel`, descarte por `hasBitError()` e corte de fila em 5 pacotes; e (ii–iv) `test_e2e_anel_topology` ($N=5$), `test_e2e_malha_topology` ($N=5$) e `test_e2e_estrela_topology` ($N=20$), que executam a co-simulação completa (PADE + Mosaik + OMNeT++ ZMQ + Collector + Plotters). A Tabela 7 sintetiza os débitos identificados na auditoria e o status atual na branch `fix/validacao-e-consistencia`.

| # | Observação original (`development`) | Correção aplicada e status (`fix/validacao-e-consistencia`) |
|---|---|---|
| 1 | **Contagem de agentes inconsistente** (`NUM_PERIFERICOS` criava $N+1$ nós no anel/malha no Mosaik, mas $N$ em `pade_anel.py`) | **Corrigido e validado.** Semântica unificada: `estrela` = $1+N$; `malha` = $N$ peers e $N(N-1)/2$ enlaces; `anel` = $N$ peers (`agente_1..N`) e $N$ enlaces |
| 2 | **Atraso por distância e jitter inativos** (`dynamic_cast<cDelayChannel*>` falhava para `cDatarateChannel`) | **Corrigido e validado.** Helpers `getChannelDelay`/`setChannelDelay` compatíveis com `cDatarateChannel` e `cDelayChannel` em `AgentNode.cc` |
| 3 | **PER do canal sem efeito de descarte** (`hasBitError()` ignorado e fila aceitando 6 pacotes com `> 5`) | **Corrigido e validado.** Descarte por `pkt->hasBitError()` adicionado em `handleMessage` e limiar de fila ajustado para `>= 5` |
| 4 | **Sem testes automatizados e sem semente fixa** (`std::random_device`, `random.uniform`) | **Corrigido e validado.** Suporte a `RANDOM_SEED` e `SIM_STEPS` em Python e C++, e suíte `tests/test_validation_suite.py` (`4 passed`) |
| 5 | **Fragmentação por MTU (planejada em 04/09) não implementada**; fator de 15000 B inativo para pacotes de 702 B | **Pendente (trabalho futuro).** Requer divisão de payloads grandes em múltiplos `AgentPacket` |
| 6 | **Reprodutibilidade de build e corrida no boot** (`pip install` em runtime, `DynamicNetwork.ned` concorrente, `plot_results_anel.py` sobrescrito) | **Corrigido e validado.** Geração atômica de `DynamicNetwork.ned`, restauração de `plot_results_anel.py`, limpeza dos Dockerfiles e `docker-compose.yml` |
| 7 | **Higiene do repositório** (sem `.gitignore`, binários `sim_exec`/`out/`, `__pycache__`, `events.csv` de 29 MB) | **Corrigido e validado.** `.gitignore` criado, binários e caches removidos do índice Git e `events.csv` truncado para cabeçalho |
| 8 | **Documentação defasada e `links.json` ausente** (`menu_streamlit.py` vs. `menu-streamlit.py`, CLI em branco) | **Parcialmente corrigido.** `scenario.py` agora persiste `links.json` e `README.md` documenta `menu.py`, `menu-streamlit.py` e `pytest`; documentação Diátaxis segue pendente |
| 9 | **Branches divergentes** (`main` defasada em relação a `development`) | **Pronto para merge.** Branch `fix/validacao-e-consistencia` pronta para integração em `development` e `main` |

Table: Status das limitações e débitos técnicos após a validação corretiva.

Não há ainda integração direta com os módulos dos demais times (TSRE, TSDQ e TTESO), o que constitui o próximo marco de integração do projeto OpenTES.

# Conclusão

Os objetivos específicos foram atendidos e fortalecidos pela validação corretiva. A **integração** (objetivo 1), as **topologias dinâmicas e telemetria** (objetivos 3 e 4) e a **modelagem física de rede** (objetivo 2) encontram-se **implementadas, corrigidas e verificadas por testes automatizados (`pytest`)** nas três topologias. A **usabilidade** (objetivo 5) conta com interface web, CLI e `README.md` atualizado, restando a publicação da documentação Diátaxis. A **revisão bibliográfica e o artigo** (objetivo 6) seguem em elaboração.

Como continuidade imediata, recomenda-se:

1. **Integrar a branch `fix/validacao-e-consistencia` em `development` e `main`**, publicando as correções de física de canal, contagem de nós, higiene de repositório e suíte de testes.
2. **Executar uma campanha experimental multi-semente** (variando `RANDOM_SEED` com 30+ repetições por cenário) para produzir intervalos de confiança de 95% para o artigo científico.
3. **Refinar a resolução temporal** do passo de co-simulação (`time_resolution` sub-segundo) e **implementar a fragmentação por MTU** para avaliar estratégias sensíveis a atraso sub-segundo e payloads extensos.
4. **Acoplar a plataforma aos demais times do OpenTES** (TSRE, TSDQ e TTESO), avaliando algoritmos de leilão de energia e controle distribuído sob perfis de comunicação degradados.

# Referências

[1] OPENTES. *Repositório geral do projeto* (inclui os *short-reports* semanais do TSCC, 20/02 a 02/10/2026). Disponível em: <https://github.com/grei-ufc/general-opentes>. Acesso em: 20 out. 2026.

[2] GREI-UFC. *tscc-com-opentes: co-simulação PADE + OMNeT++ + Mosaik* (branch `development`, commit `1309b9a`, e branch `fix/validacao-e-consistencia`). Disponível em: <https://github.com/grei-ufc/tscc-com-opentes>. Acesso em: 20 out. 2026.

[3] MOSAIK. *Mosaik: smart grid co-simulation framework*. Disponível em: <https://mosaik.offis.de>.

[4] OMNeT++. *OMNeT++ Discrete Event Simulator* e *INET Framework*. Disponíveis em: <https://omnetpp.org> e <https://inet.omnetpp.org>.

[5] GREI-UFC. *PADE: Python Agent DEvelopment framework*. Disponível em: <https://github.com/grei-ufc/pade>.

[6] MANGO. *mango: Modular Python Agent Framework*. Disponível em: <https://github.com/OFFIS-DAI/mango>.

[7] FIPA. *FIPA ACL Message Structure Specification*. Foundation for Intelligent Physical Agents. Disponível em: <http://www.fipa.org>.

[8] ZEROMQ. *ZeroMQ: distributed messaging*. Disponível em: <https://zeromq.org>.

[9] COSIMA e *cosima-mango: Investigating Multi-Agent System robustness through integrated communication simulation*. **Citações completas (autores, ano e DOI) a inserir** a partir dos artigos revisados pela equipe em jul./2026.

[10] ALMADA, J. *Tese e simulação de referência PADE + Mosaik*, utilizada como padrão para o protocolo FIPA nativo. **Citação completa a inserir.**
