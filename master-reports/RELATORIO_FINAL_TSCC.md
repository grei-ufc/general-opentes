---
title: "Relatório Final de Projeto — TSCC"
subtitle: "Time de Simulação de Comunicação e Co-simulação"
author:
  - "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
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

# Sumário Executivo

O time TSCC desenvolveu, entre fevereiro e outubro de 2026, uma plataforma de co-simulação que acopla agentes PADE, o simulador de rede OMNeT++ e o orquestrador*Mosaik, executados em três containers Docker e sincronizados em lock-step via ZeroMQ. O objetivo é substituir a hipótese de comunicação ideal entre agentes por uma rede com latência, jitter, perda, filas finitas e posição geográfica.

O ponto de partida era um bloqueio de infraestrutur onde o container do OMNeT++ não iniciava. Hoje a plataforma suporta topologias (estrela, malha completa e anel) escaláveis até centenas de agentes, tecnologias de enlace (Cabeada, 5G, Wireless, 4G e 2G) atribuíveis por enlace ou por agente, telemetria de alta resolução e dashboards automáticos, tudo configurável por uma interface web ou pelo terminal.

# Introdução

## Contextualização

Sistemas ciberfísicos no domínio energético dependem da troca coordenada de informações entre controladores, agentes, sensores e simuladores especializados. Nesses sistemas a comunicação influencia diretamente a validade dos resultados: atrasos, perdas, jitter e saturação de canais podem alterar a dinâmica observada em estratégias distribuídas, como leilões de energia e coordenação de recursos energéticos distribuídos.

No projeto OpenTES, o TSCC é responsável pela simulação de comunicação e co-simulação, uma das quatro frentes do projeto, ao lado de modelagem econômica, rede elétrica e qualidade de energia. O código-fonte está em `grei-ufc/tscc-com-opentes`.

## Motivação

Em simulações de sistemas multiagentes é comum assumir mensagens instantâneas e sem perdas. Isso impede avaliar a robustez de uma estratégia sob infraestrutura real. A motivação do time foi tornar a rede uma variável experimenta: o pesquisador escolhe topologia, tecnologia de enlace e escala, e observa o efeito sobre o tráfego dos agentes. Há também uma motivação de engenharia: conectar ferramentas heterogêneas de forma reprodutível e operável por terceiros, o que levou à conteinerização e às interfaces de configuração.

## Justificativa

A camada de comunicação é o elo entre os demais times do OpenTES. Decisões tomadas nela (formato de mensagem, granularidade temporal, política de filas) condicionam como outros módulos serão acoplados. A revisão bibliográfica da equipe indicou ainda uma lacuna, o trabalho de referência na área, o COSIMA, não detalha a justificativa da estrutura de co-simulação, não compara desempenho entre topologias e não explica a conteinerização.

## Objetivos

### Objetivo geral

Construir e documentar uma plataforma de co-simulação PADE + OMNeT++ + Mosaik que represente, com fidelidade configurável, os efeitos de redes de comunicação heterogêneas sobre sistemas multiagentes em redes elétricas inteligentes.

### Objetivos específicos

1. Integrar PADE, Mosaik e OMNeT++ em containers separados, com sincronismo determinístico.
2. Modelar latência, jitter, perda de pacotes, congestionamento e efeito de distância, com perfis de tecnologia.
3. Suportar múltiplas topologias com escalabilidade dinâmica.
4. Prover telemetria e dashboards que permitam comparar tecnologias e topologias.
5. Facilitar o uso e a reprodução.
6. Revisar a literatura e produzir um artigo científico.

# Estado da Arte e Revisão Bibliográfica

A revisão concentrou-se na família de trabalhos do COSIMA, que acopla o Mosaik ao OMNeT++ para simular a infraestrutura de comunicação de sistemas de energia. O ponto de partida técnico da equipe foi reproduzir o exemplo do COSIMA em containers. A versão atual não depende do COSIMA, o acoplamento Mosaik–OMNeT++ foi reescrito sobre ZeroMQ, com criação dinâmica de nós a partir de um arquivo NED gerado em tempo de execução.

O artigo *cosima-mango: Investigating Multi-Agent System robustness through integrated communication simulation* foi revisado em detalhe, com foco na comparação entre os frameworks de SMA PADE e Mango. A Tabela 1 resume a comparação feita pela equipe.
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

O desenvolvimento foi incremental, com ciclos semanais de implementação, teste e relato em *short-reports*, em branches de trabalho (`main` e `development`).

## Ambiente e ferramentas

| Componente | Papel | Versão / observação |
|---|---|---|
| PADE | Agentes FIPA-ACL | `pade-agents==0.1.3`; Twisted 24.7.0 |
| Mosaik | Orquestração e tempo simulado | 3.6.0; `mosaik-api-v3` 3.0.14 |
| OMNeT++ | Simulação de rede | Imagem `omnetpp/omnetpp:u22.04-6.0` |
| ZeroMQ | Transporte Mosaik–OMNeT++ | `pyzmq` 27.1.0 e 26.0.3; `cppzmq` |
| `nlohmann/json` | Serialização no lado C++ | Pacote do Ubuntu 22.04 |
| Docker Compose | Orquestração de 3 containers na rede `sim_net` | Python 3.12 nos containers Python |
| Streamlit, Plotly, Matplotlib | Interface web, dashboards e suíte `pytest` | Pré-instalados nos Dockerfiles e validados em Python 3.12 |

Table: Ferramentas e versões utilizadas no repositório.

## Arquitetura

A Figura 1 apresenta a arquitetura. Os agentes PADE enviam mensagens com `send()`. Um interceptador sobrescreve esse método: mensagens da ontologia de simulação (`telemetria_rede` em estrela e malha, `malha_restrita` no anel) são serializadas em JSON (performativa, remetente, destinatários, conteúdo, ontologia, `conversation_id`) e acumuladas no atributo `val_out`, separadas por `|||`. Mensagens de controle do PADE seguem pelo caminho nativo. O Mosaik transfere `val_out` ao nó correspondente do OMNeT++ (`val_in`) e devolve as mensagens entregues ao agente no passo seguinte, com `time_shifted=True`, que quebra o ciclo de causalidade.

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

O `MosaikBridge.cc` mantém um socket ZeroMQ `REP` bloqueante. A cada passo, o `omnet_wrapper.py` envia as entradas, o OMNeT++ avança um tick (`scheduleAt(simTime()+timeResolution)`) e responde com as saídas, o passo atual e a telemetria. Como cada lado espera a resposta do outro, o sincronismo é garantido por construção. O `scenario.py` lê `TOPOLOGY`, `NUM_PERIFERICOS`, `TIPOS_REDE` e `RANDOM_SEED`, sorteia as posições em uma área de 1000 × 1000 m, persiste `posicoes.json`, `links.json` e `config.json`, gera o `DynamicNetwork.ned` e cria as entidades no Mosaik.

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

O módulo `AgentNode.cc` implementa: (i) fila de transmissão por porta, limitada a 5 pacotes, com descarte do excedente; (ii) descarte no receptor tanto por erro de bit nativo do canal, regido pelo PER quanto por atenuação espacial dependente de distância e tamanho; (iii) atraso adicional por distância e ruído de jitter sobre o atraso-base em canais `cDatarateChannel` e `cDelayChannel`; e (iv) telemetria por pacote, exportada em strings multiplexadas com `|||`. Em notação simplificada, com $d$ em metros e $S$ em bytes:

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


## Discussão




# Conclusão


# Referências

[1] OPENTES. *Repositório geral do projeto* (inclui os *short-reports* semanais do TSCC, 20/02 a 02/10/2026). Disponível em: <https://github.com/grei-ufc/general-opentes>. Acesso em: 20 out. 2026.

[2] GREI-UFC. *tscc-com-opentes: co-simulação PADE + OMNeT++ + Mosaik* (branch `development`, commit `1309b9a`, e branch `fix/validacao-e-consistencia`). Disponível em: <https://github.com/grei-ufc/tscc-com-opentes>. Acesso em: 20 out. 2026.

[3] MOSAIK. *Mosaik: smart grid co-simulation framework*. Disponível em: <https://mosaik.offis.de>.

[4] OMNeT++. *OMNeT++ Discrete Event Simulator* e *INET Framework*. Disponíveis em: <https://omnetpp.org> e <https://inet.omnetpp.org>.

[5] GREI-UFC. *PADE: Python Agent DEvelopment framework*. Disponível em: <https://github.com/grei-ufc/pade>.

[6] MANGO. *mango: Modular Python Agent Framework*. Disponível em: <https://github.com/OFFIS-DAI/mango>.

[7] FIPA. *FIPA ACL Message Structure Specification*. Foundation for Intelligent Physical Agents. Disponível em: <http://www.fipa.org>.

[8] ZEROMQ. *ZeroMQ: distributed messaging*. Disponível em: <https://zeromq.org>.
