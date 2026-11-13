---
title: "Relatório Final de Projeto — TSRE"
subtitle: "Time de Simulação da Rede Elétrica e Recursos Energéticos Distribuídos"
author:
  - "Equipe TSRE"
  - "OpenTES"
date: "2026-09-18"
lang: "pt-BR"
bibliography: referencias.bib
csl: abnt.csl
citeproc: true
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
colorlinks: false
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
    \lhead{OpenTES — TSRE}
    \rhead{\nouppercase{\leftmark}}
    \cfoot{\thepage}
  - |
    \usepackage{etoolbox}
  - |
    \apptocmd{\tableofcontents}{\clearpage}{}{}
  - |
    \AtBeginEnvironment{longtable}{\small\setstretch{1.0}\renewcommand{\arraystretch}{1.15}}
  - |
    \AtBeginEnvironment{table}{\small\setstretch{1.0}\renewcommand{\arraystretch}{1.15}}
pdf-engine: xelatex
---

# Sumário Executivo

O Time de Simulação da Rede Elétrica e Recursos Energéticos Distribuídos (TSRE) desenvolveu, no âmbito do projeto OpenTES, entre outubro de 2025 e outubro de 2026, uma plataforma modular de co-simulação com suporte para redes elétricas de distribuição trifásicas desequilibradas com presença de Recursos Energéticos Distribuídos (REDs). O trabalho buscou superar as limitações do simulador anteriormente implementado no Grupo de Redes Elétricas Inteligentes da Universidade Federal do Ceará (GREI-UFC), que empregava equivalentes monofásicos no Pandapower, passando a representar individualmente as fases de circuitos desbalanceados de média tensão (MT) e baixa tensão (BT).

Desenvolvida em Python, a arquitetura acopla o motor de fluxo de potência *Open Distribution System Simulator* (OpenDSS), via biblioteca `py-dss-interface`, ao orquestrador de co-simulação Mosaik, com execução em contêineres Docker e gerenciamento de pacotes via `uv`. O principal diferencial técnico do projeto consiste em desacoplar os modelos nativos do OpenDSS: sistemas fotovoltaicos, sistemas de armazenamento em baterias (*Battery Energy Storage System*, BESS) e reguladores de tensão foram implementados como módulos da simulação independentes. Com isso, é possível aplicar algoritmos de controle próprios, como curvas *Volt-Var* e *Volt-Watt* da norma IEEE 1547-2018 em inversores inteligentes, lógicas de carga e descarga para BESS e compensação de queda de linha (*Line Drop Compensation*, LDC) em reguladores de tensão.

Com simulações executadas com sucesso em alimentadores de teste padronizados (como IEEE 13, 34, 123 barras e *European LV Test Case*), a plataforma foi validada em regime de série temporal quasi-estática (*Quasi-Static Time Series*, QSTS) no circuito *benchmark* IEEE 34 barras. As simulações convergiram sem instabilidade numérica e reproduziram os resultados de referência do OpenDSS nativo, apresentando um baixo Erro Quadrático Médio (*Root Mean Square Error*, RMSE) e também um baixo tempo médio de cálculo no *solver* elétrico. Até o momento de elaboração deste relatório, as entregas consolidadas do TSRE compreendem:

- A disponibilização do código-fonte modular no repositório do GitHub `grei-ufc/tsre-der-opentes`;
- A publicação da documentação técnica no padrão Diátaxis: `grei-ufc.github.io/tsre-der-opentes`;
- A aceitação e apresentação de artigo científico no XXVI Congresso Brasileiro de Automática (CBA 2026);
- A definição de rotinas padronizadas de exportação de dados em *JavaScript Object Notation* (JSON) e *Comma-Separated Values* (CSV) para integração com as camadas de Visualização de Dados e Qualidade de Energia Elétrica (TSDQ), Comunicação e Co-simulação (TSCC) e Sistemas Transativos e Otimização (TTESO).

# Introdução

## Contextualização

A operação das redes de distribuição no Sistema Elétrico de Potência (SEP) brasileiro tem passado por alterações decorrentes da expansão da geração distribuída e da atuação dos prossumidores, que combinam consumo e geração local. O aumento da penetração de REDs, como sistemas fotovoltaicos com inversores inteligentes, BESS e estações de recarga de veículos elétricos, modifica os fluxos de potência e o perfil de tensão ao longo dos alimentadores, exigindo ferramentas de simulação mais detalhadas para análise do SEP. Na plataforma OpenTES, enquanto as camadas TSCC, TTESO e TSDQ tratam, respectivamente, da rede de comunicações, do mercado transativo e dos indicadores de qualidade da energia elétrica, cabe ao TSRE desenvolver a camada de simulação da rede elétrica, resolvendo o fluxo de potência trifásico desequilibrado e atualizando as grandezas nodais a cada passo de simulação.

## Motivação

Em estudos de redes de distribuição, modelos monofásicos equivalentes não capturam adequadamente os efeitos da conexão desbalanceada de REDs. Por outro lado, mesmo em simuladores trifásicos consolidados como o OpenDSS em sua configuração padrão, componentes como geradores fotovoltaicos e BESS possuem controles internos fixos no programa, funcionando como "caixas-pretas", o que dificulta o monitoramento e controle de suas regras operacionais e a inclusão da atuação de agentes externos durante a simulação. Diante disso, a motivação do TSRE foi separar o cálculo elétrico da rede das rotinas de decisão dos equipamentos, integrando os diferentes módulos da simulação de forma reprodutível e escalável.

## Justificativa

O simulador desenvolvido pelo TSRE fornece a base elétrica para as demais camadas de simulação do projeto OpenTES: tanto a operação do mercado transativo quanto as análises de qualidade de energia e tráfego de dados dependem do cálculo correto das grandezas elétricas da rede a cada passo. O uso da modelagem trifásica desequilibrada no OpenDSS justifica-se por representar efeitos omitidos por equivalentes monofásicos, como o carregamento desigual entre fases e desequilíbrio de tensão. Somada à implementação das funções normativas da IEEE 1547-2018 (*Volt-Var* e *Volt-Watt*) e à verificação dos limites de tensão dos Procedimentos de Distribuição de Energia Elétrica no Sistema Elétrico Nacional (PRODIST), essa estrutura garante a consistência física dos cenários simulados.

## Objetivos

### Objetivo Geral

Desenvolver, validar e documentar uma plataforma modular de co-simulação para redes de distribuição de energia elétrica com integração de REDs, acoplando o motor de fluxo de potência OpenDSS ao orquestrador Mosaik com modelagem trifásica e módulos de controle desacoplados.

### Objetivos Específicos

1. **Desenvolver a ponte entre o OpenDSS e a co-simulação (*wrapper*):** Integrar o motor de cálculo do OpenDSS à interface de programação de aplicações (*Application Programming Interface*, API) v3 do orquestrador Mosaik por meio da biblioteca `py-dss-interface`, viabilizando a troca de dados e o controle QSTS passo a passo.
2. **Modelar REDs de forma desacoplada:** Implementar módulos da simulação independentes para sistemas fotovoltaicos, inversores inteligentes, BESS, reguladores de tensão sob carga com LDC e recarga de veículos elétricos, em integração ao OpenTES.
3. **Automatizar a inserção de REDs na rede:** Desenvolver rotinas em Python para dimensionamento e alocação dinâmica de geradores fotovoltaicos e carregadores de veículos elétricos com perfis temporais.
4. **Padronizar a infraestrutura de *software* e a reprodutibilidade:** Estruturar a plataforma em contêineres Docker independentes, com gestão de ambientes virtuais e dependências via ferramenta `uv`.
5. **Validar a fidelidade física e o desempenho computacional:** Executar simulações comparativas em alimentador de teste IEEE, confrontando os resultados da co-simulação com o OpenDSS nativo por meio de métricas estatísticas de erro.
6. **Disponibilizar documentação e consolidar a produção acadêmica:** Estruturar a documentação técnica pública no padrão Diátaxis e disseminar os resultados em artigo científico.

# Estado da Arte e Revisão Bibliográfica

## Co-Simulação e Controle de REDs

O estudo de redes de distribuição com elevada presença de REDs requer ferramentas capazes de acoplar o cálculo elétrico a rotinas de controle e comunicação, configurando Sistemas de Energia Ciberfísicos (*Cyber-Physical Energy Systems*, CPES). O *framework* Mosaik, desenvolvido pelo instituto OFFIS [@steinbrink2019], é amplamente utilizado na literatura por sua estrutura modular baseada em fluxo de dados e pelo tratamento de dependências cíclicas via deslocamento temporal (*time shift*), cujos recursos de sincronização na API v3 foram detalhados por @paula2022. No âmbito do GREI-UFC, @silva2025 avaliou o controle local de tensão pelas funções *Volt-Var* e *Volt-Watt* da norma IEEE 1547-2018 integrando o Mosaik ao Pandapower e ao pacote OpenDER; entretanto, o uso de equivalentes monofásicos balanceados limitou a representação de desequilíbrios entre fases, motivando a adoção de um motor trifásico.

## Modelagem Trifásica e Acoplamento com o OpenDSS

Para o cálculo elétrico de redes de distribuição multifásicas desequilibradas em regime QSTS, o OpenDSS [@epri2026] constitui uma das principais ferramentas de referência. Em seu trabalho, @radatz2020 apresenta o equacionamento da elevação de tensão associada à geração distribuída em redes desbalanceadas e descreve o laço de controle nativo do programa. Contudo, o OpenDSS operando em seu ambiente nativo não é uma ferramenta flexível. Para isso, o TSRE adotou a biblioteca `py-dss-interface` [@radatz2026], que viabiliza a comunicação direta entre o OpenDSS e o Python, permitindo controlar o circuito e atualizar o estado dos equipamentos a cada passo coordenado pelo Mosaik.

## Síntese Comparativa da Literatura

A partir dos trabalhos revisados, foram definidas as diretrizes metodológicas para a construção do simulador elétrico no OpenTES. A Tabela\ \ref{tab:questoes_norteadoras} relaciona os cinco eixos temáticos da revisão bibliográfica com as respectivas questões norteadoras da pesquisa e detalha como cada referência fundamentou as escolhas de arquitetura e modelagem adotadas pelo TSRE.

| **Eixo da revisão** | **Pergunta associada** | **Contribuição para o projeto** |
| :-----------------------: | :-----------------------------: | :----------------------------------: |
| Orquestração de CPES via Mosaik (Steinbrink et al., 2019) | Como coordenar simuladores heterogêneos e resolver dependências cíclicas de dados sem instabilidade numérica? | Fundamentação da quebra de laços causais via deslocamento temporal (*time shift*) e mapeamento de fluxo de dados no Mosaik. |
| Paradigmas Temporais e Mosaik 3.0 (Paula, 2022) | Como compatibilizar o fluxo de carga contínuo com controladores e eventos discretos de REDs? | Adoção de modelos *time-based* e *event-based*, padronização da resolução temporal e sincronização. |
| Controle de REDs e Limitações Monofásicas (Silva, 2025) | Quais os impactos operacionais de controles locais (*Volt-Var*/*Volt-Watt*) e por que superar modelos monofásicos? | Justificativa da migração para redes trifásicas desequilibradas e definição de métricas de desvio de tensão e corte de geração. |
| Fundamentos do OpenDSS (Radatz, 2020; EPRI, 2026) | Como são modelados os elementos do OpenDSS e por que desacoplar seus controles nativos? | Equacionamento analítico via matriz de impedâncias e justificativa para converter o OpenDSS em um atuador elétrico comandado externamente. |
| Ponte C-API de Baixo Nível: `py-dss-interface` (Radatz, 2026) | Como garantir alto desempenho e interoperabilidade do OpenDSS com o Python? | Adoção da API direta, permitindo troca ágil de dados em memória e controle QSTS passo a passo através do Mosaik. |

Table: Síntese da revisão bibliográfica e contribuições para o TSRE. \label{tab:questoes_norteadoras}

De modo complementar, para posicionar a solução proposta frente às ferramentas já empregadas no grupo de pesquisa e na literatura, a Tabela\ \ref{tab:comparativo_simuladores} apresenta um comparativo técnico entre a abordagem anterior baseada em Pandapower, o uso isolado do OpenDSS nativo e a plataforma de co-simulação desenvolvida pelo TSRE, contrastando aspectos de modelagem elétrica, flexibilidade de controle de REDs e infraestrutura de execução.

| **Critério** | **Pandapower + OpenDER (Silva, 2025)** | **OpenDSS Nativo QSTS (Radatz, 2020; EPRI, 2026)** | **Plataforma TSRE (OpenTES)** |
| :-----------------: | :--------------------------: | :--------------------------: | :--------------------------: |
| Modelagem Elétrica | Monofásica equivalente simplificada | Trifásica desbalanceada multifásica | Trifásica desbalanceada multifásica |
| Controle de REDs | Curvas IEEE 1547 via OpenDER | Lógicas nativas do OpenDSS | Módulos desacoplados de REDs |
| Acesso ao Motor | Funções Python via *solver* interno | Interface COM / DLL (Windows) | API direta `py-dss-interface` |
| Co-Simulação | Monodomínio local (Mosaik) | Nativamente ausente | Multidomínio integrada via Docker (Mosaik) |
| Ambiente de Execução | Instalação local (`requirements.txt`) | Dependente do sistema operacional | Contêineres Docker padronizados via `uv` |

Table: Comparativo técnico entre as abordagens de simulação da literatura e a plataforma desenvolvida pelo TSRE. \label{tab:comparativo_simuladores}

# Materiais e Métodos

## Ambiente e Ferramentas

Na metodologia adotada pelo TSRE, o cálculo do fluxo de potência trifásico desequilibrado em regime QSTS permanece a cargo do motor elétrico, enquanto os controles de geração, armazenamento e regulação de tensão são executados em módulos da simulação independentes. Para garantir o amplo acesso à plataforma e reprodutibilidade entre diferentes sistemas operacionais, utilizou-se um conjunto de ferramentas baseado em *software* livre e conteinerização.

A definição desse ambiente computacional envolveu a seleção e a fixação de versões específicas para o interpretador, o *solver* elétrico, o orquestrador e os gerenciadores de pacotes e contêineres. A Tabela\ \ref{tab:ferramentas_tsre} relaciona os componentes dessa arquitetura, especificando as ferramentas adotadas, suas respectivas versões e a função desempenhada por cada uma na execução e documentação dos cenários do TSRE.

| **Componente** | **Ferramenta** | **Versão Adotada** | **Papel na Arquitetura** |
| :------------------: | :----------------: | :--------------: | :-------------------------------------------: |
| Linguagem de Programação Principal | Python | 3.12.11 | Linguagem de programação principal dos *scripts* de simulação e automação. |
| Motor Elétrico | OpenDSS | 10.1.0.1 | Solução do fluxo de potência trifásico desequilibrado e extração de estados nodais em regime permanente. |
| API | `py-dss-interface` | 2.3.0 | Ponte de comunicação direta entre o Python e o OpenDSS. |
| Orquestrador | Mosaik | 3.5.0 | Coordenação temporal da co-simulação e troca de dados. |
| Gerenciador de Pacotes | `uv` | 0.12.5 | Gerenciador de pacotes e ambientes virtuais. |
| Conteinerização | Docker | 29.7.2 | *Engine* de contêineres para execução da co-simulação isolada e reprodutibilidade. |
| Documentação Técnica | MkDocs Material | -- | Publicação do portal de engenharia, especificações de API e catálogos de cenários. |

Table: Especificação da cadeia de ferramentas e componentes do ambiente TSRE. \label{tab:ferramentas_tsre}

## Arquitetura de Co-Simulação e Ciclo de Execução

Na arquitetura implementada, o Mosaik instancia os módulos da simulação, sincroniza o passo de tempo e gerencia a troca de variáveis entre os módulos de REDs e o OpenDSS. A Figura\ \ref{fig:arquitetura_tsre}, elaborada por @souza2026, apresenta a estrutura modular da plataforma.

\begin{figure}[H]
\centering
\includegraphics[width=1\linewidth]{figures/tsre/arquitetura_tsre.pdf}
\caption{Arquitetura da plataforma de co-simulação TSRE integrando o orquestrador Mosaik, os módulos de REDs desacoplados e o OpenDSS via \texttt{py-dss-interface} (Fonte: Souza et al., 2026).}
\label{fig:arquitetura_tsre}
\end{figure}

O ciclo de simulação QSTS é discretizado em intervalos regulares, onde cada passo é executado no modo *snapshot* no OpenDSS (que realiza o cálculo do fluxo de potência para um único instante de tempo) e é implementado seguindo a seguinte sequência coordenada pelo Mosaik:

1. **Entrada de Perfis e Painéis Fotovoltaicos:** O Mosaik lê as séries temporais de irradiância solar, temperatura ambiente e curvas de carga, e o módulo fotovoltaico calcula a potência em corrente contínua disponível no arranjo.
2. **Inversores Inteligentes:** A partir da tensão nodal obtida no passo anterior, aplicam as funções da norma IEEE 1547-2018: ***Volt-Var*** (injeção ou absorção de potência reativa conforme a tensão), ***Volt-Watt*** (redução de potência ativa sob sobretensão) e limite de **capacidade aparente** nominal.
3. **BESS e Regulação de Tensão:** O módulo de BESS atualiza seu estado de carga (*State of Charge*, SoC) para definir a potência de carga, descarga ou repouso, enquanto o módulo de regulação monitora tensões e correntes de linha para comandar a comutação dos *taps*.
4. **Atuação e Solução no OpenDSS:** Por meio da `py-dss-interface`, o *wrapper* atualiza as injeções de potência dos elementos equivalentes e as posições de *tap* no circuito; ao receber o comando de cálculo, o OpenDSS resolve o fluxo de potência em modo *snapshot* e retorna tensões nodais, correntes e fluxos de potência ao Mosaik para o avanço do passo.

O acoplamento entre as ações dos REDs e as tensões da rede forma um laço fechado que é resolvido no Mosaik por deslocamento temporal (*time shift*), representando o atraso de medição e atuação dos controladores digitais. Quando há iterações no mesmo instante (*same-time loops*), a conexão recebe o atributo `weak=True` para definir a ordem de execução e evitar travamentos (*deadlocks*), conforme ilustrado na Figura\ \ref{fig:fluxo_dados_tsre} [@souza2026].

\begin{figure}[H]
\centering
\includegraphics[width=0.65\linewidth]{figures/tsre/data_flow_2.pdf}
\caption{Fluxo de dados entre os módulos da simulação e tratamento de laços algébricos via conexões \textit{time-shifted} (Fonte: Souza et al., 2026).}
\label{fig:fluxo_dados_tsre}
\end{figure}

Na troca de dados entre os módulos da simulação, adota-se a convenção de sinal positivo para injeção de potência ativa e reativa na rede ($P > 0$, $Q > 0$) e negativo para absorção pelas cargas ou recarga do BESS ($P < 0$, $Q < 0$). As potências ativa e reativa são expressas em $\text{kW}$ e $\text{kvar}$, e os dados de irradiância e temperatura em $\text{kW/m}^2$ e $^\circ\text{C}$, respectivamente.

## Integração entre Camadas da Co-Simulação

A comunicação com as camadas TSCC e TTESO permite avaliar o efeito do tráfego de dados e de mecanismos de mercado diretamente sobre a operação elétrica da rede, enquanto a camada TSDQ processa e exibe os indicadores de desempenho do circuito. Para evitar conflitos de dependências entre os pacotes de cada equipe, todas as camadas de simulação são executadas em contêineres Docker conectados por uma rede virtual com portas *Transmission Control Protocol/Internet Protocol* (TCP/IP) dedicadas, sob coordenação do Mosaik.

Ao final ou ao longo da simulação, os estados elétricos (tensões nodais, correntes e potências de cada módulo de RED por passo) são compartilhados com as demais camadas de simulação e gravados em arquivos CSV padronizados. Além disso, foi implementada uma rotina que extrai automaticamente a topologia do alimentador em formato JSON, listando barras, trechos de linha com suas fases e pontos de conexão dos REDs para alimentar a interface gráfica da camada TSDQ.

## Cenário de Teste e Métricas de Validação

A avaliação da precisão numérica e do tempo de processamento foi realizada no alimentador *benchmark* IEEE 34 barras ($24{,}9\text{ kV}$), cuja topologia e alocação de REDs são apresentadas na Figura\ \ref{fig:ieee34_tsre} [@souza2026]. Na configuração adotada, a geração fotovoltaica consiste em dois sistemas de $800\text{ kW}$ de pico conectados às barras 830 e 848, operando com controles *Volt-Var* e *Volt-Watt* ativos. Adicionalmente, alocou-se um BESS trifásico na barra 834 com capacidade de $4000\text{ kWh}$ e potência nominal de $800\text{ kW}$ (fator de potência unitário), inicializado em $50\%$ de SoC e operando na faixa de $34\%$ a $85\%$, enquanto os reguladores de tensão do alimentador são comandados externamente pelo módulo de controle de *tap* desacoplado.

\begin{figure}[H]
\centering
\includegraphics[width=0.80\linewidth]{figures/tsre/IEEE34Bus_normal.pdf}
\caption{Topologia do circuito de teste IEEE 34 barras e alocação dos REDs (Fonte: Souza et al., 2026).}
\label{fig:ieee34_tsre}
\end{figure}

O cenário foi simulado em regime QSTS para um período de 24 horas com resolução de 5 minutos (288 passos). Os perfis de tensão nodal obtidos na co-simulação foram comparados aos do OpenDSS nativo (no modo *daily*, regime QSTS nativo do OpenDSS) utilizando o RMSE por barra $k$, definido na Equação\ (1):

$$
\text{RMSE}_k = \sqrt{\frac{1}{N}\sum_{t=1}^{N} \left(V_{1,t}^{(k)} - V_{2,t}^{(k)}\right)^2} \tag{1}
$$

onde $V_{1,t}^{(k)}$ é a magnitude da tensão em $\text{p.u.}$ da barra $k$ no instante $t$ calculada na co-simulação via Mosaik, e $V_{2,t}^{(k)}$ é o valor correspondente obtido no OpenDSS nativo. Já o tempo de processamento foi levantado a partir da média de 100 execuções completas do cenário em um processador Intel Core 7 240H ($2{,}50\text{ GHz}$).

# Resultados e Discussão

Os resultados obtidos pelo TSRE foram consolidados no artigo *“Co-simulação de Redes Elétricas Inteligentes: Implementação e Análise de Desempenho da Integração Mosaik-OpenDSS”*, aceito e apresentado no CBA 2026 [@souza2026]. Os testes avaliaram duas questões principais: se o desacoplamento dos módulos de REDs com acoplamento *time-shifted* mantém a precisão do cálculo de fluxo de potência, e se o tempo de execução da camada elétrica é compatível com a operação conjunta com as camadas de comunicação e de mercado.

## Avaliação da Fidelidade Física e Perfil de Tensão

O comportamento das tensões nodais ao longo do alimentador IEEE 34 barras mostrou concordância entre a co-simulação e a solução nativa do OpenDSS: as barras próximas à subestação apresentaram menor variação de tensão, enquanto as barras mais distantes sofreram maiores variações em função da impedância acumulada dos trechos e das injeções de potência dos REDs.

O cálculo da Equação\ (1) resultou em um RMSE máximo de **$0{,}00810\text{ p.u.}$** (desvio inferior a $1\%$) entre todas as barras do circuito, indicando que a atualização externa dos equipamentos em modo *snapshot* não introduz divergência nem acúmulo relevante de erro numérico. Por outro lado, observou-se que inversores operando apenas com medições locais na função *Volt-Var* podem causar oscilações de potência reativa entre equipamentos próximos, o que reforça a utilidade de integrar a camada elétrica à camada TSCC para avaliar estratégias de controle secundário coordenado.

## Desempenho Computacional e Viabilidade de Co-Simulação

A medição do tempo de processamento por módulo da simulação mostrou que o *solver* OpenDSS responde pela maior fração de cálculo de cada passo, exigindo entre **$3{,}5\text{ ms}$ e $6{,}5\text{ ms}$** para convergir o fluxo de potência, ao passo que os módulos de inversores, leitura CSV e controle de BESS executaram em menos de $1\text{ ms}$. A Figura\ \ref{fig:tempo_execucao_tsre} apresenta os tempos medidos por módulo no primeiro passo temporal [@souza2026].

\begin{figure}[H]
\centering
\includegraphics[width=0.75\linewidth]{figures/tsre/execution_time.pdf}
\caption{Tempo de execução individualizado por módulo da simulação no primeiro passo temporal (Fonte: Souza et al., 2026).}
\label{fig:tempo_execucao_tsre}
\end{figure}

Nas 100 repetições do horizonte de 24 horas (288 passos), a co-simulação apresentou tempo total médio de **$2{,}93\text{ s}$** ($\approx 10{,}2\text{ ms}$ por passo completo, somando a comunicação entre processos, do inglês *Inter-Process Communication* [IPC], e a coordenação do Mosaik), contra **$0{,}099\text{ s}$** da simulação executada inteiramente dentro do OpenDSS nativo. Apesar do acréscimo decorrente da troca de mensagens entre processos, o tempo total de $2{,}93\text{ s}$ (sendo $\approx 3{,}5\text{ ms}$ por passo no *solver* elétrico) mostra que o cálculo da rede não limita o desempenho da co-simulação quando acoplado às camadas de comunicação e de mercado.

Para consolidar a avaliação experimental realizada no alimentador IEEE 34 barras, a Tabela\ \ref{tab:resultados_consolidados_tsre} resume os indicadores quantitativos de tempo de processamento e erro numérico obtidos na validação, confrontando o OpenDSS nativo com a co-simulação proposta.

| **Métrica** | **OpenDSS Nativo** | **Co-Simulação TSRE** | **Interpretação no OpenTES** |
| :-----------------------: | :------------------: | :--------------------------: | :----------------------------------: |
| Tempo médio ($24\text{ h}$ / 288 passos) | $0{,}099\text{ s}$ | $2{,}93\text{ s}$ ($\approx 3{,}5\text{ ms}$ no *solver*/passo) | Sobrecarga de IPC reduzida; viabiliza acoplamento com TSCC e TTESO. |
| RMSE (Tensão nas barras) | -- | Máximo de $0{,}00810\text{ p.u.}$ | Desvio inferior a $1\%$; preserva a física do circuito em modo *snapshot*. |
| Controle de REDs | Lógicas nativas fixas | Módulos desacoplados | Suporte dinâmico a curvas IEEE 1547 (*Volt-Var*/*Volt-Watt*) e BESS, além da associação do controle às outras camadas de simulação. |
| Interoperabilidade e dados | Saída local, arquivos `txt` | Exportação `JSON` e `CSV` | Mapeamento topológico e exportação de dados para integração com as demais camadas de simulação. |

Table: Síntese comparativa de desempenho e capacidades entre o OpenDSS nativo e a co-simulação TSRE. \label{tab:resultados_consolidados_tsre}

# Conclusão

O TSRE desenvolveu a camada de simulação elétrica do projeto OpenTES, entregando uma plataforma modular de co-simulação para redes de distribuição trifásicas desequilibradas com presença de REDs. O ambiente substituiu a modelagem monofásica equivalente anterior pela integração entre o Mosaik e o OpenDSS via `py-dss-interface`, utilizando contêineres Docker e gerenciamento de pacotes com a ferramenta `uv` para assegurar portabilidade e reprodutibilidade entre diferentes máquinas.

Os objetivos propostos foram alcançados e validados no alimentador IEEE 34 barras, com resultados publicados no CBA 2026. O erro máximo observado nas tensões nodais ($\text{RMSE} \le 0{,}00810\text{ p.u.}$) demonstra que o desacoplamento de inversores fotovoltaicos, BESS e reguladores de tensão em modo *snapshot* preserva a precisão do fluxo de potência, enquanto o tempo de processamento ($\approx 3{,}5\text{ ms}$ por passo no *solver* elétrico e $2{,}93\text{ s}$ para o ciclo de 24 horas) viabiliza a execução conjunta com as camadas de comunicação e de mercado transativo.

Os códigos-fonte e os cenários de teste foram disponibilizados no repositório público `grei-ufc/tsre-der-opentes`, acompanhados da documentação técnica estruturada no padrão Diátaxis. Como continuidade dos trabalhos no OpenTES, propõe-se avaliar estratégias de controle secundário coordenadas via rede de comunicação para evitar oscilações de potência reativa entre inversores, concluir a integração do módulo de recarga de veículos elétricos (motor Caldera) e estender os testes para redes secundárias de BT, incluindo o *European LV Test Case* e alimentadores reais modelados a partir da Base de Dados Geográfica da Distribuidora (BDGD).

\clearpage

# Referências

::: {#refs}
:::
