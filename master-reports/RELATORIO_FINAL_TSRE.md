---
title: "Relatório Final de Projeto — TSRE"
subtitle: "Time de Rede Elétrica e Recursos Energéticos Distribuídos"
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
    \lhead{OpenTES — TSRE}
    \rhead{\nouppercase{\leftmark}}
    \cfoot{\thepage}
pdf-engine: xelatex
---

> **Observação:** A versão definitiva deve ser mantida em **até 12 páginas**.

# Sumário Executivo

O time de Simulação da Rede Elétrica e Recursos Energéticos Distribuídos (TSRE) desenvolveu, no âmbito do projeto OpenTES, entre outubro de 2025 e outubro de 2026, uma plataforma modular de co-simulação com suporte para redes elétricas de distribuição trifásicas desequilibradas com elevada penetração de Recursos Energéticos Distribuídos (REDs). A iniciativa teve como objetivo central apresentar uma evolução em relação ao simulador já implementado no âmbito do Grupo de Redes Elétricas Inteligentes da Universidade Federal do Ceará (GREI-UFC), restrito a modelos simplificados monofásicos equivalentes, no Pandapower, por uma solução de alta fidelidade física capaz de representar cada uma das fases de circuitos desbalanceados de média tensão (MT) e baixa tensão (BT).

No contexto de um ambiente Python, a arquitetura computacional acopla o motor de fluxo de potência OpenDSS (por meio da interface de baixo nível py-dss-interface) ao orquestrador de co-simulação Mosaik, operando em contâineres Docker isolados e com gestão de dependências via uv. O principal diferencial de engenharia do projeto consiste no desacoplamento dos elementos nativos fechados do OpenDSS: sistemas fotovoltaicos, BESS e reguladores de tensão foram segregados em simuladores externos dedicados. Esta arquitetura permite a implementação modular de algoritmos de controle dinâmico, incluindo inversores inteligentes em conformidade com as curvas Volt-Var e Volt-Watt da norma IEEE 1547-2018, máquinas de estado de carga e descarga para sistemas de armazenamento e compensação de queda de linha (Line Drop Compensation) em reguladores de tensão.

A plataforma foi validada em múltiplos cenários quasi-estáticos sobre os alimentadores de teste IEEE: 13 Bus, 34 Bus, 123 Bus e European LV Test Case. As simulações demonstraram convergência robusta e aderência estrita às soluções de referência do OpenDSS puro, apresentando erro quadrático médio (RMSE) situado na faixa de $10^{-5}$ a $10^{-3}\text{ pu}$ e com baixo impacto no tempo total de execução decorrente da troca de dados e do sincronismo entre os módulos. As entregas consolidadas do time compreendem:
- A disponibilização do código-fonte modular no repositório grei-ufc/tsre-der-opentes;
- A publicação da documentação técnica estruturada no padrão Diátaxis via GitHub Pages (grei-ufc.github.io/tsre-der-opentes);
- A aceitação de artigo científico no Congresso Brasileiro de Automática (CBA 2026);   
- O fornecimento de esquemas padronizados de exportação de dados em JSON e CSV para integração direta com as frentes de Visualização de Dados (TSDQ), Comunicações (TSCC) e Mercados Transativos (TTESO).

# Introdução

## Contextualização

O Sistema Elétrico de Potência (SEP), particularmente o subsistema de distribuição brasileiro, atravessa uma mudança de paradigma impulsionada pela transição energética. Para além da diversificação das fontes de geração, a rede de distribuição passa por transformações topológicas profundas decorrentes da ascensão do prossumidor: o usuário da rede que deixa de ser um agente puramente passivo e passa a atuar ativamente como gerador local. 

Nesse contexto, os Recursos Energéticos Distribuídos (REDs) assumem protagonismo, sendo os vetores tecnológicos por meio dos quais os prossumidores interagem física e operacionalmente com o SEP. Entre esses recursos, destacam-se a geração solar fotovoltaica equipada com inversores inteligentes, os sistemas de armazenamento em baterias (Battery Energy Storage System - BESS), os postos de recarga de veículos elétricos e os mecanismos de resposta da demanda.

No ecossistema da plataforma OpenTES, enquanto os demais times de desenvolvimento modelam a dinâmica das redes de comunicação, as regras de mercado transativo e a conformidade da qualidade da energia elétrica, o TSRE assume o papel de núcleo físico da arquitetura de co-simulação, responsável por computar a física da rede, solucionando o fluxo de potência trifásico desequilibrado e atualizando as grandezas nodais a cada passo temporal. A documentação técnica, o código-fonte, os modelos desacoplados e os casos de teste desenvolvidos encontram-se disponíveis no repositório `github.com/grei-ufc/tsre-der-opentes`.



## Motivação

  Em estudos de redes de distribuição, é usual a adoção de simulações apoiadas em modelos monofásicos equivalentes. Porém, o avanço da penetração de Recursos Energéticos Distribuídos (REDs) impõe dinâmicas operacionais que ultrapassam a capacidade dessas abordagens. Além disso, em simuladores elétricos consolidados, como o próprio OpenDSS em sua utilização padrão, componentes como sistemas fotovoltaicos e sistemas de armazenamento de energia costumam ser implementados como blocos fechados ("caixas-pretas"), cujas lógicas de controle interno são rígidas e de customização limitada, o que inviabiliza a implementação de estratégias avançadas de controle, mecanismos autônomos de regulação de tensão e tomadas de decisão por agentes inteligentes externos. 
  
  Portanto, a motivação central do TSRE foi transformar a rede de distribuição e seus recursos associados em um ambiente de simulação aberto e modular, separando a solução da física da rede (o fluxo de potência) das lógicas dinâmicas de decisão dos equipamentos. Somou-se a isso uma dimensão de engenharia de software: conectar ferramentas heterogêneas de forma determinística, escalável e reprodutível, o que demandou a orquestração via Mosaik, a conteinerização em Docker e o gerenciamento de dependências com uv.

## Justificativa
  
  O simulador desenvolvido pelo TSRE é a base das demais camadas do projeto OpenTES. Estratégias de despacho econômico e mercados transativos formuladas pelo TTESO, bem como indicadores de qualidade de energia e visualização elaborados pelo TSDQ, perdem validade física se as características operacionais da rede elétrica não forem calculadas com a devida precisão a cada passo da simulação.

  A implementação de uma modelagem trifásica desequilibrada no OpenDSS justifica-se pelas características intrínsecas das redes de distribuição de média e baixa tensão. Modelos monofásicos balanceados mascaram fenômenos críticos reais, como o desequilíbrio entre fases e a circulação de corrente de neutro causados pela alocação de REDs monofásicos. Ao implementar uma arquitetura modular e alinhada aos requisitos normativos da IEEE 1547-2018 (com suporte a curvas Volt-Var e Volt-Watt) e aos critérios de tensão em regime permanente do PRODIST, o TSRE garante a validade física necessária para executar cenários complexos com alto grau de confiabilidade.

## Objetivos

### Objetivo geral

Desenvolver, validar e documentar uma plataforma modular de co-simulação para redes de distribuição de energia elétrica com elevada integração de REDs, acoplando o motor de fluxo de potência OpenDSS ao orquestrador Mosaik em uma modelagem trifásica e controladores dinâmicos desacoplados.

### Objetivos específicos

1. **Desenvolver a ponte entre o OpenDSS e a co-simulação (wrapper):** Integrar o motor de cálculo do OpenDSS à API v3 do orquestrador Mosaik por meio da biblioteca `py-dss-interface`, viabilizando a troca de dados e o controle quasi-estático passo a passo.
2. **Modelar REDs de forma desacoplada:** Implementar simuladores independentes para sistemas fotovoltaicos, inversores inteligentes, sistemas de armazenamento de energia em BESS, reguladores de tensão sob carga com compensação de queda de linha e modelos de mobilidade e recarga de veículos elétricos (incluindo o simulador avançado de VE com dinâmica CC/CV baseado no motor Caldera, em processo de integração ao ecossistema OpenTES).
3. **Automatizar a inserção de REDs na rede:** Desenvolver rotinas automatizadas em Python para dimensionamento e alocação dinâmica de geradores fotovoltaicos e carregadores de veículos elétricos, com perfis temporais.
4. **Padronizar a infraestrutura de software e a reprodutibilidade:** Estruturar a plataforma em contêineres Docker independentes, com gestão de ambientes virtuais e dependências utilizando a ferramenta `uv`.
5. **Validar a fidelidade física e o desempenho computacional:** Executar simulações comparativas nos alimentadores de teste IEEE, confrontando os resultados da co-simulação com o OpenDSS nativo por meio de métricas estatísticas de erro.
6. **Disponibilizar documentação e consolidar a produção acadêmica:** Estruturar a documentação técnica pública no padrão internacional Diátaxis e disseminar os resultados científicos por meio da publicação de artigos científicos.

# Estado da Arte e Revisão Bibliográfica

A avaliação do impacto da integração em larga escala de REDs na rede elétrica de distribuição demanda ferramentas computacionais capazes de reproduzir a física da rede e integrar estratégias dinâmicas de controle e fluxo de informação. Nesse cenário, a co-simulação consolidou-se como padrão para a análise de Sistemas de Energia Ciberfísicos (CPES - Cyber-Physical Energy Systems). O framework Mosaik, desenvolvido pelo Instituto de Pesquisa e Desenvolvimento para Ferramentas e Sistemas de Informática de Oldemburgo (OFFIS - Oldenburger Forschungs- und Entwicklungsinstitut für Informatik-Werkzeuge und -Systeme) [@steinbrink2019], destaca-se na literatura por sua arquitetura modular baseada em fluxo de dados e pela resolução de dependências cíclicas por meio de deslocamento temporal. Os fundamentos de interoperabilidade e a utilização da API v3 da ferramenta foram consolidados no trabalho desenvolvido por @paula2022.

No âmbito do controle de REDs em redes de distribuição, @silva2025 investigou previamente no GREI o suporte de tensão prestado pelas funções Volt-Var e Volt-Watt da norma IEEE 1547-2018 utilizando o Mosaik acoplado ao Pandapower e ao pacote OpenDER. Embora tenha comprovado a eficácia do controle local de tensão, o trabalho evidenciou a restrição de operar sobre equivalentes monofásicos balanceados, indicando a necessidade de evolução para circuitos polifásicos desbalanceados.

Como motor de cálculo elétrico, o Open Distribution System Simulator (OpenDSS), desenvolvido pelo Electric Power Research Institute [@epri2026], constitui a referência na simulação de circuitos de distribuição multifásicos desequilibrados em regime permanente no domínio do tempo (Quasi-Static Time Series — QSTS). Em seu trabalho, @radatz2020 demonstra o equacionamento da elevação de tensão causada por múltiplos geradores em redes desbalanceadas e detalha o funcionamento do laço de controle nativo do OpenDSS. Contudo, como no OpenDSS nativo, certos elementos operam como blocos fechados acoplados internamente ao fluxo de carga, o TSRE adotou o pacote py-dss-interface [@radatz2026] para superar essa limitação. Esse pacote viabiliza a comunicação direta do Python com o OpenDSS e permite a interceptação passo a passo do circuito.

A Tabela\ \ref{tab:questoes_norteadoras} alinha os eixos temáticos com as questões norteadoras da pesquisa e a aplicação direta nas decisões de engenharia do projeto.

\begin{table}[H]
\centering
\caption{Síntese da revisão bibliográfica e contribuições para o TSRE.}
\label{tab:questoes_norteadoras}
\begin{tabular}{|p{0.28\linewidth}|p{0.34\linewidth}|p{0.34\linewidth}|}
\hline
\textbf{Eixo da revisão} & \textbf{Pergunta associada} & \textbf{Contribuição para o projeto} \\
\hline
Orquestração de CPES via Mosaik (Steinbrink et al., 2019) & Como coordenar simuladores heterogêneos e resolver dependências cíclicas de dados sem instabilidade numérica? & Fundamentação da quebra de laços causais via deslocamento temporal (\textit{time shift}) e mapeamento de fluxo de dados no Mosaik. \\
\hline
Paradigmas Temporais e Mosaik 3.0 (Paula, 2022) & Como compatibilizar o fluxo de carga contínuo com controladores e eventos discretos de REDs? & Adoção de modelos \textit{time-based} e \textit{event-based}, padronização da resolução temporal e sincronização. \\
\hline
Controle de REDs e Limitações Monofásicas (Silva, 2025) & Quais os impactos operacionais de controles locais (Volt-Var/Volt-Watt) e por que superar modelos monofásicos? & Justificativa da migração para redes trifásicas desequilibradas e definição de métricas de desvio de tensão e corte de geração. \\
\hline
Fundamentos do OpenDSS (Radatz, 2020; EPRI, 2026) & Como são modelados os elementos do OpenDSS e por que desacoplar seus controles nativos? & Equacionamento analítico via matriz de impedâncias e justificativa para converter o OpenDSS em um atuador elétrico comandado externamente. \\
\hline
Ponte C-API de Baixo Nível: py-dss-interface (Radatz, 2026) & Como garantir alto desempenho e interoperabilidade do OpenDSS com o Python? & Adoção da API direta, permitindo troca ágil de dados em memória e controle quasi-estático passo a passo através do Mosaik. \\
\hline
\end{tabular}
\end{table}

A Tabela\ \ref{tab:comparativo_simuladores} compara as soluções analisadas na literatura com a plataforma desenvolvida pelo TSRE.

\begin{table}[H]
\centering
\caption{Comparativo técnico entre as abordagens de simulação da literatura e a plataforma desenvolvida pelo TSRE.}
\label{tab:comparativo_simuladores}
\begin{tabular}{|p{0.18\linewidth}|p{0.25\linewidth}|p{0.25\linewidth}|p{0.26\linewidth}|}
\hline
\textbf{Critério} & \textbf{Pandapower + OpenDER (Silva, 2025)} & \textbf{OpenDSS Nativo QSTS (Radatz, 2020; EPRI, 2026)} & \textbf{Plataforma TSRE (OpenTES)} \\
\hline
Modelagem Elétrica & Monofásica equivalente simplificada & Trifásica desbalanceada multifásica & Trifásica desbalanceada multifásica \\
\hline
Controle de REDs & Curvas IEEE 1547 via OpenDER & Lógicas nativas do OpenDSS & Módulos desacoplados de REDs \\
\hline
Acesso ao Motor & Funções Python via solver interno & Interface COM / DLL (Windows) & API direta \texttt{py-dss-interface} \\
\hline
Co-Simulação & Monodomínio local (Mosaik) & Nativamente ausente & Multidomínio integrada via Docker (Mosaik) \\
\hline
Ambiente de Execução & Instalação local (\texttt{requirements.txt}) & Dependente do sistema operacional & Contêineres Docker padronizados via \texttt{uv} \\
\hline
\end{tabular}
\end{table}

Em relação à literatura, o diferencial do TSRE consiste em: (1) desacoplar a física do circuito no OpenDSS das funções de controle dos inversores e baterias; (2) viabilizar a simulação trifásica desbalanceada em alimentadores primários e secundários; (3) empregar a biblioteca py-dss-interface para utilizar o OpenDSS em um ambiente de co-simulação Python; e (4) encapsular o ambiente em contêineres Docker, pronto para integração com as camadas de comunicação (TSCC), qualidade de energia (TSDQ) e mercados transativos (TTESO).

# Materiais e Métodos

O desenvolvimento da camada de simulação da rede elétrica fundamenta-se no princípio de que a análise do sistema de distribuição exige a segregação entre o cálculo da física da rede e as dinâmicas de controle distribuído dos equipamentos. Superando abordagens que utilizam modelos simplificados monofásicos equivalentes, a metodologia adotada estrutura um ambiente de co-simulação em regime permanente QSTS focado na representação trifásica desequilibrada. Nesse arranjo, o motor elétrico atua na resolução de equações nodais, enquanto as lógicas de conversão, despacho e regulação normativa dos REDs operam como modelos externos modulares. Essa concepção garante rigor técnico e alto grau de reprodutibilidade para subsidiar as análises de comunicação, qualidade de energia e mercados transativos no ecossistema OpenTES.

## Ambiente e Ferramentas 

A infraestrutura computacional concebida pelo TSRE foi projetada para atender a requisitos rigorosos de modularidade, desempenho computacional e reprodutibilidade entre diferentes sistemas operacionais. Para superar as limitações identificadas na literatura, adotou-se uma cadeia de ferramentas baseada em software livre, conteinerização e interfaces de baixo nível.

A Tabela\ \ref{tab:ferramentas_tsre} sintetiza os componentes fundamentais, as ferramentas selecionadas e suas respectivas atribuições no núcleo de simulação física do projeto OpenTES.

\begin{table}[H]
\centering
\caption{Especificação da cadeia de ferramentas e componentes do ambiente TSRE.}
\label{tab:ferramentas_tsre}
\begin{tabular}{|p{0.22\linewidth}|p{0.18\linewidth}|p{0.16\linewidth}|p{0.38\linewidth}|}
\hline
\textbf{Componente} & \textbf{Ferramenta} & \textbf{Versão Adotada} & \textbf{Papel na Arquitetura} \\
\hline
Runtime Principal & Python & 3.12.11 & Linguagem de programação principal dos scripts de simulação. \\
\hline
Motor Elétrico & OpenDSS & 10.1.0.1 & Solução do fluxo de potência trifásico desequilibrado e extração de estados nodais em regime permanente. \\
\hline
API & \texttt{py-dss-interface} & 2.3.0 & Ponte de comunicação direta entre o Python e o OpenDSS. \\
\hline
Orquestrador & Mosaik & 3.5.0 & Coordenação temporal da co-simulação e troca de dados. \\
\hline
Gerenciador de Pacotes & uv & 0.12.5 & Gerenciador de pacotes e ambientes virtuais. \\
\hline
Conteinerização & Docker & 29.7.2 & Engine de contêineres para execução da co-simulação isolada e reprodutibilidade independente do host. \\
\hline
Documentação Técnica & MkDocs Material & Framework Diátaxis & Publicação do portal de engenharia, especificações de API e catálogos de cenários. \\
\hline
\end{tabular}
\end{table}

## Arquitetura de Co-Simulação e Ciclo de Execução

Na arquitetura desenvolvida, o orquestrador Mosaik atua como o coordenador central do ambiente, sendo responsável por instanciar os modelos, sincronizar o avanço temporal e gerenciar o intercâmbio de dados entre os módulos ciberfísicos e o motor elétrico. A Figura\ \ref{fig:arquitetura_tsre} ilustra a estrutura modular da plataforma e a segregação de responsabilidades entre as camadas de controle, orquestração e simulação física.

\begin{figure}[H]
\centering
\includegraphics[width=0.95\linewidth]{figures/tsre/arquitetura_tsre.pdf}
\caption{Arquitetura da plataforma de co-simulação TSRE integrando o orquestrador Mosaik, os modelos de REDs desacoplados e o OpenDSS via \texttt{py-dss-interface}.}
\label{fig:arquitetura_tsre}
\end{figure}

O ciclo de simulação QSTS opera de forma discretizada em intervalos regulares $\Delta t$. A cada instante temporal, a sequência de execução é coordenada pelo Mosaik da seguinte forma:

1. **Leitura de Dados Externos e Atualização de Cargas:** O Mosaik lê as séries temporais de irradiância solar, temperatura ambiente e curvas de carga normalizadas, encaminhando-as para cada módulo da simulação.
2. **Paineis Fotovoltaicos:** O modelo recebe os valores de irradiância e temperatura e calcula a potência contínua disponível no barramento CC.
3. **Inversores Inteligentes:** O inversor monitora a tensão no ponto de instalação calculada no passo imediatamente anterior e avalia os limites operacionais de acordo com as diretrizes da norma IEEE 1547-2018: **Suporte de Reativos (Volt-Var):** Define a injeção ou absorção de potência reativa em função da magnitude de tensão; **Mitigação de Sobretensão (Volt-Watt):** Caso a tensão ultrapasse o limiar crítico, impõe um corte proporcional na potência ativa gerada; **Capacidade Aparente:** Assegura que a potência aparente seja menor ou igual à nominal do inversor.
4. **Armazenamento de Energia e Regulação de Tensão:**
   - **BESS:** Avalia seu estado de carga atual (SoC) e define o regime de operação (carga, descarga ou repouso) segundo a curva de despacho recebida;
   - **Regulador de Tensão:** Monitora a corrente de linha e a tensão local e define a necessidade e altera os *taps* dos reguladores.
5. **Interação com o OpenDSS:** O *wrapper* acessa a API *py-dss-interface* e sobrescreve as propriedades de injeção de potência dos elementos equivalentes associados a cada RED no circuito, além de enviar os comandos de posição de *tap* aos reguladores de tensão.
6. **Convergência do Fluxo de Carga:** Quando comando de solução é disparado, o OpenDSS processa o fluxo de carga sobre a topologia de rede carregada até que as tensões nodais convirjam.
7. **Coleta de Estados e Fechamento do Passo:** O *wrapper* extrai os novos valores de grandeza da rede (tensão das barras, fluxos de potência nos ramos, correntes de condutores de fase e neutro e perdas elétricas) e retorna ao Mosaik. O orquestrador armazena os valores no *buffer* temporal e avança o passo da simulação.

As variáveis de entrada dos REDs e as grandezas resultantes na rede elétrica estabelecem uma dependência cíclica direta. No ambiente OpenTES, essa dinâmica é estabilizada por meio do mecanismo de deslocamento temporal (*time shift*), o qual contempla o atraso inerente de sensores, equipamentos de medição e algoritmos digitais dos equipamentos reais. Em cenários que exigem convergência do controle em iterações no mesmo passo de tempo (*same-time loops*), a conexão entre o controlador e a rede é configurada no Mosaik com o atributo `weak=True`, assegurando o sequenciamento causal e prevenindo travamentos de execução (*deadlocks*).

Para assegurar a coerência algébrica nas trocas de dados entre os modelos, adota-se a seguinte padronização de sinais e grandezas: A injeção de potência ativa na rede elétrica é convencionada como positiva ($P > 0$), já as cargas modeladas no sistema e a recarga dos BESS operam como absorção de potência da rede ($P < 0$). A injeção de reativos, é tratada como positiva ($Q > 0$) e a absorção de reativos é negativa ($Q < 0$). As potências ativa e reativa são expressas em grandezas físicas nominais: quilowatts ($\text{kW}$) e quilovolt-amperes reativos ($\text{kvar}$), enquanto as variáveis climáticas de entrada, irradiância e temperatura, são expressas respectivamente em $\text{kW/m}^2$ e $^\circ\text{C}$.

### Integração Interequipes no Ecossistema OpenTES

Para assegurar a interoperabilidade ciberfísica e a consistência das simulações entre os diferentes grupos de trabalho do projeto OpenTES, a camada de simulação da rede elétrica (TSRE) estabeleceu interfaces padronizadas de dados e infraestrutura computacional com as subequipes de Visualização e Qualidade (TSDQ), Redes de Comunicação (TSCC) e Energia Transativa (TTESO).

---

#### 1. Conexão TSRE $\leftrightarrow$ TSDQ: Topologia e Compatibilização de Grandezas

A interface com a equipe do TSDQ visa à alimentação do painel analítico interativo em Streamlit, possibilitando a visualização gráfica dos alimentadores e o monitoramento temporal dos índices de conformidade de tensão e carregamento:

* **Exportação da Topologia em JSON:** A partir da compilação do circuito no OpenDSS via `py-dss-interface`, desenvolveu-se uma rotina de extração e serialização da rede em um arquivo estruturado (`topology.json`). Esse documento mapeia a matriz de conectividade do alimentador, especificando a hierarquia de montante e jusante de barras, coordenadas espaciais ($x, y$) para renderização geoespacial, segmentos de linhas com suas respectivas fases, além dos pontos exatos de acoplamento dos transformadores reguladores, bancos de baterias (BESS) e geradores fotovoltaicos.
* **Alinhamento de Escalas e Convenções no Streamlit:** Durante a integração com o visualizador, identificou-se e corrigiu-se uma discrepância dimensional na leitura dos fluxos de potência. Padronizou-se o tráfego dos resultados em grandezas físicas nominais expressas em quilowatts ($\text{kW}$) e quilovolt-amperes reativos ($\text{kvar}$), unificando os fatores multiplicadores para conversão em base percentual e por unidade ($\text{pu}$) em relação à potência de base do sistema ($S_{\text{base}}$). Adicionalmente, compatibilizou-se a convenção de sinais de modo que a injeção ativa de geradores e inversores ($P > 0$) e a absorção de cargas e recarga de baterias ($P < 0$) sejam interpretadas sem ambiguidade pelas rotinas de renderização e cálculo de perdas do TSDQ.

---

## Integração Entre Camadas da Co-simulação

A integração com os times de comunicação (TSCC) e sistemas transativos (TTESO) estrutura o ambiente de co-simulação e possibilita a simulação das dinâmicas de rede de dados e os leilões de energia, que interagem em malha fechada com a física da distribuição. Ao mesmo tempo, o TSDQ possibilita a visualização gráfica e o monitoramento temporal de grandezas da rede.

* **Padronização da Infraestrutura em Docker:** Para mitigar inconsistências de ambiente, dependências de bibliotecas e conflitos de sistema operacional entre as equipes, a cadeia de execução foi encapsulada em contêineres Docker geridos via `docker-compose`. Os módulos de simulação comunicam-se por meio de uma rede virtual *bridge* dedicada (`opentes-net`), configurada com resolução interna de nomes via DNS do Docker e atribuição de portas TCP/IP isoladas, garantindo que as mensagens do protocolo Mosaik transitem de forma determinística entre os contêineres do motor elétrico, do emulador de rede de dados e dos agentes econômicos.
* **Acoplamento para Simulação de Atrasos e Mercados:** A arquitetura foi preparada para suportar a injeção de perturbações de comunicação governadas pelo TSCC (como latências de canal, jitter e perda de pacotes) nos comandos de despacho originados pelo TTESO. Nesse arranjo, os preços marginais locais e os sinais de despacho de potência ativa e reativa determinados nos leilões bilaterais e transativos sofrem a degradação temporal imposta pelo modelo de canal do TSCC antes de atingirem os atuadores dos REDs e do BESS no TSRE. Esse mecanismo viabiliza a avaliação dos limites de estabilidade de tensão e da eficácia das curvas normativas da IEEE 1547-2018 perante atrasos críticos de telecomunicação.
* **Disponibilização de Séries Temporais e Métricas de Qualidade de Energia (PRODIST):** Estruturou-se a exportação padronizada dos resultados da simulação temporal QSTS em arquivos tabulares (CSV) contendo as tensões nodais por fase ($V_a, V_b, V_c$), correntes de ramo, corrente de retorno pelo condutor de neutro e perdas elétricas ativas e reativas a cada passo $\Delta t$. Essa base temporal alimenta os módulos de pós-processamento do TSDQ dedicados à apuração dos índices de conformidade de tensão em regime permanente — classificando os registros nas faixas de tensão Adequada, Precária e Crítica conforme os padrões do Módulo 8 do PRODIST (ANEEL) —, além de viabilizar o cálculo do Fator de Desequilíbrio de Tensão ($\text{FDV}\%$) para verificação do impacto da inserção assimétrica de geração solar fotovoltaica.

# Resultados e Discussão

Os resultados do TSRE devem ser discutidos considerando seu papel de sustentação física para os demais módulos do OpenTES. Isso significa que, além de avaliar comportamento elétrico em si, o relatório também deve destacar como a modelagem adotada viabilizou integrações, testes de controle, análises de sensibilidade ou interpretação de dados visuais.

Uma discussão madura evita conclusões excessivamente genéricas. Em vez de apenas afirmar que a rede “respondeu adequadamente”, o texto deve explicar sob quais condições os resultados se mostraram coerentes, onde surgiram limitações, como os recursos distribuídos influenciaram o comportamento do sistema e quais parâmetros se mostraram mais sensíveis. A Tabela\ \ref{tab:resultados_tsre} sintetiza os indicadores de resultado e maturação da infraestrutura física do TSRE ao longo do projeto.

\begin{table}[H]
\centering
\caption{Estrutura de apresentação e discussão dos indicadores de resultado do TSRE.}
\label{tab:resultados_tsre}
\begin{tabular}{|p{0.25\linewidth}|p{0.18\linewidth}|p{0.20\linewidth}|p{0.31\linewidth}|}
\hline
\textbf{Indicador} & \textbf{Situação inicial} & \textbf{Situação consolidada} & \textbf{Discussão} \\
\hline
Maturidade do cenário elétrico & Parcial & Consolidada & A base física ficou apta a estudos integrados multifásicos. \\
\hline
Integração com outros módulos & Restrita & Viável & A representação elétrica passou a dialogar com as frentes TSCC, TSDQ e TTESO. \\
\hline
Capacidade de análise & Básica & Expandida & Novos cenários e interpretações de controle puderam ser explorados. \\
\hline
Reprodutibilidade & Moderada & Totalmente documentada & O trabalho ganhou clareza metodológica e automação via contêineres Docker e \texttt{uv}. \\
\hline
\end{tabular}
\end{table}

Ao longo do texto, convém registrar limitações como sensibilidade a parametrizações específicas, dependência de bases de dados, simplificações do modelo ou necessidade de calibração adicional. Esses elementos são parte natural do desenvolvimento e ajudam a posicionar corretamente a validade dos resultados.

# Conclusão

O TSRE cumpriu papel central na consolidação da base elétrica do OpenTES, oferecendo suporte para que os demais times trabalhassem sobre cenários fisicamente significativos. O desenvolvimento mostrou que a qualidade da modelagem da rede e dos recursos energéticos distribuídos influencia diretamente a consistência dos estudos integrados do projeto.

Os objetivos enunciados na introdução foram atendidos por meio da estruturação de cenários, da documentação das escolhas de modelagem e da construção de uma base interpretativa para análise dos resultados elétricos. O principal legado do trabalho está na combinação entre representação física útil, registro metodológico e abertura para futuras extensões.

Como continuidade, recomenda-se aprofundar validações cruzadas entre cenários, refinar parametrizações de recursos distribuídos, expandir estudos sensíveis a controle e comunicação e fortalecer a integração com as frentes de visualização e otimização. Essas ações podem elevar o grau de maturidade dos experimentos e ampliar o alcance científico do trabalho realizado.

# Referências

::: {#refs}
:::
