---
title: "Relatório Final de Projeto — TTESO"
subtitle: "Plataforma de co-simulação multidomínio do OpenTES: integração dos simuladores, atualização do PADE e validação no IEEE 13 barras"
author:
  - "Francisco Douglas Barros da Silva (bolsista PIBIC/CNPq)"
  - "Orientador: Prof. Dr. Lucas Silveira Melo"
  - "Time TTESO — GREI/UFC"
date: "2026-10-22"
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
    \usepackage{etoolbox}
    \AtBeginEnvironment{longtable}{\setstretch{1.0}}
  - |
    \renewcommand{\topfraction}{0.85}
    \renewcommand{\bottomfraction}{0.6}
    \renewcommand{\textfraction}{0.07}
    \renewcommand{\floatpagefraction}{0.9}
  - |
    \usepackage{fancyhdr}
  - |
    \pagestyle{fancy}
    \fancyhf{}
    \lhead{OpenTES — TTESO}
    \rhead{\nouppercase{\leftmark}}
    \cfoot{\thepage}
pdf-engine: xelatex
---

# Sumário Executivo

O Time de modelagem e simulação de transações econômicas e otimização de prosumidores (TTESO) foi responsável por reunir em um único ambiente executável os simuladores que as três equipes do OpenTES mantinham em separado, e por levar esse ambiente a uma aplicação completa de sistema transativo de energia. O resultado é a plataforma de co-simulação do repositório `co-simulation-opentes`, em que os agentes de software do PADE, a rede de comunicação no OMNeT++, a rede elétrica no OpenDSS e o orquestrador Mosaik rodam juntos, cada um em seu contêiner, com um script único de execução.

Três entregas sustentam esse resultado. A primeira é a atualização do PADE para a versão 3.0, em Python 3.12, com runtime integrado e telemetria em arquivos CSV, o que permitiu voltar a executar os agentes em um ambiente atual. A segunda é uma camada de rede própria, que substitui o módulo de ligação com o ns-3 removido da plataforma e entrega as mensagens dos agentes por três caminhos possíveis: entrega ideal, um modelo de perda e atraso em Python, ou a rede 6TiSCH simulada no OMNeT++. A terceira é a montagem do alimentador IEEE 13 barras como benchmark padrão do grupo, com cinco sistemas fotovoltaicos, curvas medidas de irradiância e de temperatura e controle Volt/Var decidido pelos agentes.

A plataforma foi validada de ponta a ponta. Com 17,4% de perda de pacotes no canal simulado, o controle distribuído reduziu o desvio-padrão da tensão em 15% nas barras com geração e trouxe a barra 646 de 1,0517 para 1,0437 pu no meio da tarde. Uma varredura de perda de 0 a 100%, com 20 sementes por nível, mostrou que o benefício se mantém até 75% de perda e desaparece só quando nenhuma medição chega. Sobre essa base, a camada de mercado transativo portada da tese de referência do grupo roda no mesmo alimentador, com dez agentes prosumidores negociando a programação diária de armazenamento. Como o IEEE 13 é desequilibrado, a formulação foi estendida para vigiar a tensão de cada fase e despachar o armazenamento por fase, como um inversor de quatro fios. Após inserirmos a rede 6TiSCH entre os agentes, a negociação converge em 42 rodadas, nenhuma das 2.978 mensagens se perde, e nenhuma leitura de tensão sai da faixa A da ANSI C84.1 ao longo do dia. O tempo de rede, porém, passa do previsto em cada rodada. Posteriormente foi realizado a comparação com o Wi-SUN FAN (Field Area Network), sobre o mesmo rádio, reduz esse tempo em duas ordens de grandeza sem mudar o resultado elétrico.

# Introdução

## Contextualização

A rede de distribuição deixou de ter fluxo em um sentido só. Geração fotovoltaica em telhados, armazenamento e cargas controláveis passaram a responder a sinais locais, e a decisão sobre quando injetar ou absorver energia migrou para as extremidades do alimentador. Estudar esse comportamento exige avaliar três domínios ao mesmo tempo: o elétrico, que define tensões e limites; o de comunicação, que define quando a informação chega e se chega; e o de decisão, onde os agentes escolhem.

Nenhum simulador consagrado cobre os três. A prática da área é a co-simulação, com um orquestrador que sincroniza simuladores especializados e transporta dados entre eles [1, 2]. No OpenTES, cada equipe desenvolveu um bloco: o TSCC tratou da comunicação, o TSRE da rede elétrica e dos recursos distribuídos, e o TTESO dos agentes, da otimização, da camada transativa e da integração entre os times.

## Motivação

A motivação do trabalho do TTESO foi transformar esses blocos em uma plataforma única, reprodutível e documentada. Sem isso, cada resultado dependia do ambiente de quem o produziu, e a informação elétrica chegava aos agentes sem passar por rede de comunicação nenhuma, o que esconde justamente o efeito que o projeto quer medir.

Há também uma motivação interna à camada transativa. O mecanismo de mercado da tese de referência do grupo [3] existia em dois repositórios antigos, com PADE 2.2, Mosaik 2.2, ns-3 e o pacote PySP, e não rodava em nenhum ambiente atual. Recuperá-lo exigia a plataforma de pé.

## Justificativa

As atualizações, integrações e novas implementações desenvolvidas pelo TTESO são o "coração" do projeto, valorizando os trabalhos desenvolvidos pelas equipes TSCC, TSDQ e TSRE. Em resumo, ela é a base a qual as outras rodam. Um estudo de controle, de mercado ou de comunicação no OpenTES começa por subir a plataforma, escolher um cenário e ler as saídas. Documentar as decisões de integração, os defeitos encontrados e as condições de reprodução reduz o retrabalho dos próximos ciclos e permite que novos integrantes entrem sem refazer o caminho.

## Objetivos

### Objetivo geral

Integrar os simuladores das três equipes do OpenTES em uma plataforma de co-simulação multidomínio reprodutível, e validá-la sobre um alimentador de teste publicado, com agentes decidindo a partir de informação que atravessa uma rede de comunicação simulada. Além disso, reafirmar o modelo de mercado transativo proposto em [3], com adaptações de arquitetura utilizada (omNET++, OpenDSS via py-dss-interface).

### Objetivos específicos

1. Atualizar o PADE para Python 3.12 e restabelecer a ponte com o Mosaik na versão 3.
2. Implementar uma camada de rede que entregue as mensagens dos agentes pela rede simulada, no lugar do módulo ns-3 removido.
3. Reunir os simuladores em contêineres por domínio, com execução por um único script.
4. Montar o IEEE 13 barras como benchmark, com geração fotovoltaica e controle Volt/Var nos agentes.
5. Medir o efeito do controle e a sensibilidade do resultado à qualidade da comunicação.
6. Exercitar a camada de mercado transativo sobre a mesma plataforma.

# Estado da Arte e Revisão Bibliográfica

Avaliar um sistema transativo de energia exige reproduzir, ao mesmo tempo, a física da rede de distribuição, a troca de mensagens entre os participantes e as decisões de cada um. A literatura trata esse tipo de sistema de energia ciberfísico (CPES, do inglês *Cyber-Physical Energy System*) por co-simulação: cada domínio fica no seu simulador, e um orquestrador sincroniza o tempo e transporta os dados [4, 16, 17]. O Mosaik [1, 2] segue essa linha. Ele trata cada simulador como uma caixa preta com uma interface de passo e descreve o cenário em Python, o que permite que equipes diferentes mantenham seus simuladores de forma independente. O HELICS [18], projetado para execuções com mais de cem mil federados, e o GridLAB-D [19], que reúne rede, cargas e mercado em uma ferramenta só, ficam nos dois extremos dessa escolha.

No GREI, a camada de decisão parte do PADE [5], uma plataforma multiagente em Python desenvolvida no grupo, que implementa a troca de mensagens e os protocolos de interação padronizados pela FIPA [20, 21]. Sobre ele, Melo [3] construiu um modelo de simulação multidomínio que acopla, pelo Mosaik, os agentes do PADE, a rede elétrica e o simulador de redes ns-3, e o aplicou a um sistema transativo [24]. No mecanismo proposto, os prosumidores programam seus recursos contra o preço de energia, um concentrador agrega as programações, o operador da distribuição verifica a tensão com uma matriz de sensibilidade, e o agente de mercado ajusta por decomposição dual o preço sombra, o multiplicador de Lagrange que acopla os dois lados. O trabalho mostrou que a negociação por preço mantém a tensão na faixa sem comandos diretos aos prosumidores, mas deixou três pontos em aberto. A plataforma dependia de PADE 2.2, Mosaik 2.2, ns-3 e PySP e não roda em um ambiente atual; a rede elétrica era descrita por dois modelos diferentes, um para a sensibilidade e outro para o fluxo de potência; e a tensão e o preço sombra eram tratados por barra, como em uma rede equilibrada.

O mecanismo de Melo [3] se apoia no controle transativo com restrições de rede de Hu et al. [25], em que o preço é ajustado rodada a rodada até que a programação dos recursos respeite os limites da rede. Essa linha segue a definição do GridWise Architecture Council, para quem energia transativa é um conjunto de mecanismos econômicos e de controle que equilibra oferta e demanda usando o valor como parâmetro operacional [22], e a visão de Kok e Widergren [23] de uma sociedade de dispositivos coordenados por mercado. O preço sombra se aproxima do preço marginal locacional da distribuição (DLMP), que Bai et al. [26] decompõem em parcelas de energia, congestionamento, suporte de tensão e perdas. Para redes desequilibradas, como o IEEE 13 Bus Liu et al. [27] calculam o DLMP com fluxo de potência ótimo trifásico, mas de forma centralizada, pelo operador. Nos mecanismos negociados entre agentes, a tensão de cada fase continua de fora. Este trabalho faz essa extensão, com o armazenamento despachado por fase como em um inversor de quatro fios, cujo quarto braço conduz a corrente de neutro [28].

Na comunicação, Melo [3] adotou uma rede de baixa potência e longo alcance (LPWA) [29] do tipo 6TiSCH, que leva IPv6 ao modo TSCH do IEEE 802.15.4 [31]. Cada enlace transmite em fatias de tempo reservadas e dorme fora delas, o que dá latência previsível e consumo baixo, e a função de escalonamento MSF [32] ajusta o número de fatias conforme o tráfego. Os parâmetros de atraso e de erro vieram do Simulador 6TiSCH [33] e da curva de erro medida por Prando et al. [30], e as medidas da referência cobrem a fase de operação, com mensagens de até 1,5 kB. Uma nova rede LPWA também foi analisada, o Wi-SUN FAN [34], perfil para redes de campo das distribuidoras, usa a mesma camada física IEEE 802.15.4g com acesso por disputa (CSMA/CA) e quadros de até 2047 bytes. Ele troca a previsibilidade e o baixo consumo da 6TiSCH por uma vazão próxima da taxa do rádio.

A Tabela\ \ref{tab:questoes_norteadoras} alinha os eixos da revisão às questões que orientaram o trabalho e ao que cada um definiu no projeto.

\begin{table}[H]
\centering
\small
\caption{Síntese da revisão bibliográfica e contribuições para o TTESO.}
\label{tab:questoes_norteadoras}
\begin{tabular}{|>{\raggedright\arraybackslash}p{0.27\linewidth}|>{\raggedright\arraybackslash}p{0.33\linewidth}|>{\raggedright\arraybackslash}p{0.33\linewidth}|}
\hline
\textbf{Eixo da revisão} & \textbf{Pergunta associada} & \textbf{Contribuição para o projeto} \\
\hline
Co-simulação de CPES via Mosaik (Steinbrink et al. [2]; Gomes et al. [16]) & Como coordenar simuladores contínuos e de eventos discretos mantidos por equipes diferentes? & Mosaik como orquestrador, um contêiner por domínio e a rede de comunicação consultada a cada mensagem. \\
\hline
Agentes e protocolos FIPA (Melo et al. [5]; FIPA [20, 21]) & Como descrever papéis e conversas, e o que fazer quando uma mensagem atrasa ou se perde? & PADE 3.0 em Python 3.12, com contabilidade por remetente, tempo limite e retransmissão. \\
\hline
Sistema transativo de referência (Melo [3]; Melo et al. [24]) & Como recuperar uma plataforma que não roda mais sem mudar o mecanismo? & Porte para Pyomo e OpenDSS, com um único modelo de rede e sensibilidade por perturbação. \\
\hline
Coordenação por preço e DLMP (GWAC [22]; Hu et al. [25]; Bai et al. [26]) & Como coordenar recursos por preço respeitando os limites da rede? & Decomposição dual da referência, com o preço sombra como sinal de tensão em cada porta. \\
\hline
Redes desequilibradas (Liu et al. [27]; Zhang et al. [28]) & A média das fases basta para vigiar a tensão? & Restrição por fase, armazenamento por porta e comparação entre inversores de três e de quatro fios. \\
\hline
Redes LPWA para a distribuição (Vilajosana et al. [31]; Municio et al. [33]; Harada et al. [34]) & A rede da referência comporta o tráfego real da negociação? & 6TiSCH com 1 a 20 fatias por enlace e Wi-SUN FAN sobre o mesmo rádio, com o tamanho real das mensagens. \\
\hline
\end{tabular}
\end{table}

A Tabela\ \ref{tab:comparativo_abordagens} compara a plataforma do TTESO com a tese de referência e com o cálculo de DLMP em rede desequilibrada.

\begin{table}[H]
\centering
\small
\caption{Comparativo entre abordagens da literatura e a plataforma desenvolvida pelo TTESO.}
\label{tab:comparativo_abordagens}
\begin{tabular}{|>{\raggedright\arraybackslash}p{0.17\linewidth}|>{\raggedright\arraybackslash}p{0.25\linewidth}|>{\raggedright\arraybackslash}p{0.23\linewidth}|>{\raggedright\arraybackslash}p{0.27\linewidth}|}
\hline
\textbf{Critério} & \textbf{Tese de referência (Melo [3])} & \textbf{DLMP desequilibrado (Liu et al. [27])} & \textbf{Plataforma TTESO (OpenTES)} \\
\hline
Modelagem elétrica & Dois modelos de rede, com cargas equilibradas por barra & Trifásica desequilibrada & Trifásica desequilibrada, um único modelo no OpenDSS \\
\hline
Restrição de tensão & Por barra (média das fases) & Por fase & Por fase \\
\hline
Decisão & Negociada entre agentes, por decomposição dual & Centralizada no operador & Negociada entre agentes, com preço sombra por porta \\
\hline
Comunicação no laço & ns-3 com parâmetros do 6TiSCH, medida na operação & Ausente & OMNeT++ com o tamanho real de cada mensagem \\
\hline
Rede de comunicação & 6TiSCH & Não se aplica & 6TiSCH (1 a 20 fatias por enlace) e Wi-SUN FAN \\
\hline
Ambiente de execução & PADE 2.2, Mosaik 2.2 e PySP; & Não se aplica & Contêineres Docker, PADE 3.0, Mosaik 3.5 e um comando único \\
\hline
\end{tabular}
\end{table}

Em relação à literatura, o diferencial do TTESO consiste em: (1) recuperar a plataforma da referência em um ambiente atual, com um único modelo de rede elétrica e o registro das decisões de integração; (2) estender o mecanismo negociado entre agentes para a análise por fase, que a literatura trata de forma centralizada; (3) medir a comunicação da negociação com o tamanho real das mensagens e comparar a 6TiSCH com o Wi-SUN FAN sobre o mesmo rádio; e (4) encapsular o ambiente em contêineres Docker, pronto para a integração com as camadas de rede elétrica (TSRE), de comunicação (TSCC) e de qualidade de energia (TSDQ).

# Materiais e Métodos

## Arquitetura e contêineres

A plataforma tem cinco contêineres: um por domínio e um para o coletor de resultados. Os modelos de otimização do mercado formam uma biblioteca, sem processo próprio, que os agentes chamam dentro do contêiner `pade`. A separação é por domínio: o repositório do TSCC, que reunia agentes, modelo de rede e cenário, foi dividido entre os contêineres de agentes, de comunicação e de orquestração, e o repositório do TSRE virou o contêiner de rede elétrica.

O Mosaik decide quem executa em cada instante e transporta os dados. O PADE hospeda os agentes. O OMNeT++ simula a rede, e toda informação elétrica que chega a um agente passa por ele. O OpenDSS resolve o fluxo de potência. Os coletores, que gravam o estado elétrico e a telemetria de rede, ficam no contêiner de orquestração, que é quem enxerga o conjunto.

| Contêiner | Domínio | Ferramenta | Base |
|---|---|---|---|
| `comm` | rede de comunicação | OMNeT++ 6 e ponte ZeroMQ | C++ |
| `pade` | agentes, otimização | PADE 3.0, Pyomo e CPLEX | Python 3.12 |
| `mosaik` | orquestração | Mosaik 3.5 | Python 3.12 |
| `collector` | registro | coletor do Mosaik | Python 3.12 |
| `grid` | rede elétrica | OpenDSS via py-dss-interface | Python 3.12 |

Table: Contêineres da plataforma e o papel de cada um.

![Arquitetura da plataforma de co-simulação. O orquestrador sincroniza o tempo e transporta os dados entre os simuladores; fora do ambiente ficam os arquivos de configuração, o solver de otimização e as saídas.](figuras/arquitetura.png){ width=96% }

## Atualização do PADE

O PADE foi atualizado do Python 3.6 para o 3.12 e publicado como versão 3.0. O fluxo de uso passou a ser o comando `pade start-runtime`, que sobe o AMS, o Sniffer e os scripts de agentes em uma sessão compartilhada. A telemetria saiu do Flask e do SQLite e passou a ser gravada em arquivos CSV (`sessions.csv`, `agents.csv`, `messages.csv` e `events.csv`), o que reduziu as dependências e tornou a leitura dos resultados direta.

O driver que liga o PADE ao Mosaik foi reescrito para a API da versão 3, cuja assinatura de passo mudou e cujo passo pode ser adiado até que os agentes terminem de responder. Essa possibilidade de adiar é o que permite que uma negociação inteira aconteça dentro de um passo do orquestrador.

## Camada de rede dos agentes

O módulo que ligava o PADE ao ns-3 não existe mais na plataforma. No lugar dele entrou uma camada que intercepta o envio de mensagens do agente em tempo de execução, sem tocar no núcleo do PADE, e a encaminha para um de três modelos de canal: entrega ideal, um modelo de perda e atraso em Python, ou o cliente do servidor de rede no OMNeT++. O tamanho de cada mensagem é o do seu conteúdo serializado em JSON, o que faz o modelo de rede reagir ao conteúdo real do protocolo.

O servidor de rede reproduz o rádio da referência [3] (IEEE 802.15.4g a 50 kbps, 0 dBm, propagação de Pister-Hack, curva de erro de Prando et al. [30]) e oferece dois MACs, escolhidos no console da plataforma. No modo 6TiSCH, cada enlace transmite um quadro de 127 bytes em cada fatia reservada a ele em um *slotframe* de 4,04 s; o número de fatias por enlace vai de 1 a 20, e o padrão, 2, é a calibração que põe os atrasos na faixa de 10 a 90 s relatada pela referência. No modo Wi-SUN FAN, o acesso é por CSMA/CA, com os parâmetros padrão do IEEE 802.15.4, quadros de 1.280 bytes e taxa de 50, 150 ou 300 kbps. Nas taxas maiores, a sensibilidade do receptor piora na proporção do ruído, 10 log$_{10}$ da razão entre as taxas, o que encurta o alcance e reduz o número de enlaces; e o erro de um quadro maior cresce com o número de bits. Nenhum dos dois modos representa disputa entre enlaces: cada mensagem é calculada sozinha, o que é otimista, sobretudo no Wi-SUN, em que a disputa existe de fato.

Dois problemas apareceram assim que a entrega deixou de ser instantânea. O protocolo *Contract Net* do PADE supõe entrega imediata e passou a fechar ciclos com menos respostas do que o esperado. E o FIPA não define retransmissão, de modo que uma rodada de vinte e quatro mensagens com 5% de perda tem 71% de chance de perder ao menos uma. Os agentes passaram a fazer contabilidade própria por remetente e por rodada, com tempo limite e reenvio apenas a quem falta.

## Rede elétrica e cenário de validação

O alimentador IEEE 13 barras [9] é o benchmark padrão da plataforma. Ele é publicado, conferido e deliberadamente difícil: curto, fortemente carregado, desequilibrado, com regulador de tensão, transformador de distribuição, trechos monofásicos e bifásicos e capacitores. Cinco sistemas fotovoltaicos foram alocados sobre ele, com curvas de irradiância e de temperatura de módulo medidas em usinas brasileiras da base BR-PVGen [10], reamostradas para o passo de cinco minutos.

Dois defeitos herdados foram corrigidos na montagem. O sistema fotovoltaico da barra 646 estava declarado como trifásico em uma barra que só tem as fases B e C, e 37% da potência pedida era injetada em um nó que nenhum outro elemento usa; com a correção, o circuito reproduz o perfil de tensão publicado com erro médio de 0,00044 pu. As curvas de temperatura vinham divididas por 25, o que fazia o painel operar como se estivesse permanentemente frio; com a temperatura em graus Celsius, a geração de pico caiu de 4.894 para 4.030 kW.

No cenário de validação, cada inversor tem um par de agentes. O agente medidor lê a tensão da barra, como média das fases presentes, e a publica em uma mensagem ACL. A mensagem entra na rede OMNeT++, sofre atraso e pode ser descartada. Se chega, o agente controlador aplica o controle Volt/Var, com faixa morta de $\pm 0{,}02$ pu em torno de 1,0 pu e reativo máximo igual a uma fração da potência aparente do inversor, respeitando $S \le S_{nom}$. O par de referências vai para o sistema fotovoltaico no OpenDSS, que recalcula a rede, e o laço fecha no passo seguinte. O passo é de cinco minutos e o horizonte é de um dia.

![Diagrama unifilar do IEEE 13 barras com a alocação de geração fotovoltaica e de armazenamento usada na aplicação de mercado transativo.](figuras/ieee13-unifilar.png){ width=86% }

## Execução e reprodutibilidade

Um script único sobe os contêineres na ordem certa, espera cada simulador ficar pronto e limpa o ambiente ao final, mesmo quando interrompido. Dois cuidados operacionais estão embutidos nele. Os simuladores remotos da rede elétrica aceitam uma única conexão do Mosaik e encerram depois dela, então a prontidão deles é detectada pelo registro de eventos, nunca por sondagem na porta, que consumiria a conexão. E os contêineres de perfis diferentes não são removidos por um desligamento simples, o que deixava a rede virtual presa entre execuções.

Sem argumentos, o script abre um console no terminal, pelo comando `opentes`, com os experimentos e as configurações em um menu (formulação, inversor, rede entre os agentes, critério de parada); com argumentos, executa um experimento direto. O cenário Volt/Var e as varreduras de perda foram executados em uma versão anterior da plataforma, preservada no histórico do repositório na marcação `antes-da-limpeza`. A semente do modelo de rede é fixa, para que as passadas com e sem controle enfrentem a mesma rede.

## Camada de mercado transativo

Sobre a plataforma pronta, a camada de mercado transativo da tese de referência [3] foi portada e exercitada. Os modelos de otimização do prosumidor, do concentrador e do operador da distribuição foram reescritos em Pyomo, a rede passou a ser descrita uma única vez em OpenDSS, e a matriz de sensibilidade da tensão à potência ativa passou a ser obtida por perturbação no próprio OpenDSS, no lugar do jacobiano de um segundo simulador. Os quatro papéis de agente da tese conversam por protocolos FIPA sobre a rede 6TiSCH, e a negociação segue a decomposição dual da formulação original, com duas extensões deste trabalho. A primeira é a análise por fase: a restrição de tensão do operador e o preço sombra passam a existir por fase de cada barra, e o armazenamento é despachado por porta, uma por fase, como um inversor de quatro fios. A segunda é o critério de parada, que passou da variação absoluta do preço sombra para o desacordo entre concentrador e operador relativo à potência de cada porta, abaixo de 0,1%.

# Resultados e Discussão

## O laço causal fecha

A execução do cenário integrado confirma que a tensão atravessa a rede de comunicação antes de chegar ao controlador. Ao longo de um dia, os cinco medidores enviaram 1.227 pacotes, dos quais 213 foram descartados, uma perda de 17,4%, coerente com o parâmetro de 15% do modelo e com a flutuação de um sorteio por pacote. A latência ficou entre 32 e 451 ms, com média de 81 ms, e a variação de atraso teve média de 44 ms, próxima do parâmetro de 50 ms. A figura a seguir caracteriza o canal: a latência se concentra nos valores baixos com cauda à direita, e o vão entre a curva de pacotes enviados e a de entregues é a perda acumulada ao longo do dia.

## Efeito do controle Volt/Var

O controle injeta reativo e eleva as barras críticas no fim do dia: a mínima da barra 652 sobe de 0,9203 para 0,9366 pu, e a da barra 634, de 0,9450 para 0,9552 pu. No meio da tarde o sentido se inverte na barra 646, que passa de 1,05 pu sem controle e volta a 1,0437 pu com o inversor absorvendo reativo. O desvio-padrão da tensão cai em média 15%, e chega a 20% na barra 652.

| Barra | $\sigma$ sem | $\sigma$ com | Mínima sem | Mínima com | Máxima sem | Máxima com |
|---|---:|---:|---:|---:|---:|---:|
| 652 | 0,0285 | 0,0228 | 0,9203 | 0,9366 | 1,0217 | 1,0217 |
| 634 | 0,0193 | 0,0162 | 0,9450 | 0,9552 | 1,0114 | 1,0114 |
| 632 | 0,0114 | 0,0099 | 0,9674 | 0,9718 | 1,0067 | 1,0067 |
| 645 | 0,0184 | 0,0163 | 0,9665 | 0,9712 | 1,0385 | 1,0317 |
| 646 | 0,0215 | 0,0191 | 0,9648 | 0,9700 | 1,0517 | 1,0437 |
| Média | 0,0198 | 0,0169 | | | | |

Table: Efeito do controle Volt/Var nas barras com geração, com 17,4% de perda de pacotes. Valores em pu.

![Caracterização da rede de comunicação no cenário integrado: latência, variação de atraso, integridade dos pacotes e acumulado ao longo do dia.](figuras/voltvar-comunicacao.png){ width=78% }

O ganho do controle é um parâmetro, e a escolha dele é um resultado do benchmark. Com o valor padrão da norma IEEE 1547 [11], de 44% da capacidade do inversor para reativo, os cinco inversores agindo ao mesmo tempo sob atraso e perda sobre-injetam e a tensão chegou a 1,12 pu, com reativo total perto de 5,7 Mvar; com 5% o conjunto regula de forma estável, o que mostra que a qualidade da comunicação limita o ganho seguro do controle distribuído.

![Tensão das cinco barras com geração ao longo do dia, sem e com controle, e o resumo por barra do desvio-padrão e da tensão mínima.](figuras/voltvar-comparacao.png){ width=78% }

## Sensibilidade à qualidade da comunicação

Uma varredura de 0 a 100% de perda, em passos de 5% e com 20 sementes por nível estocástico, mostra que a redução do desvio-padrão fica em 15% até 75% de perda, com variação entre sementes abaixo de 0,3 ponto percentual, cai a partir de 80%, chega a 10,8% com 95% e desaparece em 100%. A tensão muda devagar entre passos de cinco minutos, e o controlador segura o último reativo válido, então a perda só pesa quando as medições passam a chegar com intervalos de vários passos. Esse resultado depende da dinâmica lenta do caso e não deve ser generalizado para controles com passo curto.

## Aplicação: mercado transativo sobre a mesma plataforma

Sobre a mesma plataforma roda a camada de mercado da tese de referência [3], estendida para a análise por fase. A negociação por barra, a da tese, vigia a média das fases, e no IEEE 13 a média esconde violação: conferida no fluxo de potência não linear, ela deixa 151 leituras de fase acima de 1,03 pu, com máxima de 1,0532 pu, fora da faixa A da ANSI C84.1 [12]. A negociação por fase, com o armazenamento despachado por fase como em um inversor de quatro fios, deixa 9 leituras acima de 1,03 pu, nenhuma acima de 1,031 pu, e mantém o dia inteiro na faixa A, deslocando 9% mais energia. No modelo do operador, a programação que cada prosumidor faria sozinho leva as leituras de fase acima de 1,03 pu de 287 para 552, e a negociação as leva a zero em 42 rodadas, com a tensão de cada fase entre 0,9710 e 1,0290 pu.

![Tensão de cada fase ao longo do dia após a negociação por fase, no modelo do operador da distribuição. O teto plano em 1,029 pu é a restrição de tensão ativa, com a margem de $10^{-3}$ pu.](figuras/m13-tensao-depois.png){ width=94% }

Na co-simulação completa, com os agentes reais, a demanda realizada, a fase de operação e a rede 6TiSCH entre os agentes, a negociação por fase converge nas mesmas 42 rodadas, nenhuma das 2.978 mensagens se perde e as leituras fora da faixa A caem de 105 para zero. O resultado elétrico é idêntico ao da entrega ideal. O tempo de rede é o ponto fraco: cada rodada gasta de 474 a 541 s no ciclo 3, acima dos 300 s que a janela reserva a ele. Parte vem do caso: o concentrador do IEEE 13 fica na subestação, junto do operador e do agente de mercado, e com os três ligados por cabo o ciclo 3 sai do rádio. A outra parte vem das mensagens, de cerca de 24 kB, vinte vezes os tamanhos declarados na implementação de referência; com esses tamanhos, o ciclo 3 fica entre 18 e 26 s. Com perda de 1 e 5% por mensagem, a negociação converge nas mesmas 42 rodadas, com retransmissões. Esse teste achou uma falha de reenvio na fase de operação, que deixava janelas sem correção; corrigida a falha, o resultado elétrico volta a ser idêntico ao da entrega ideal.

## Comparação entre redes de comunicação

O mesmo cenário rodou com a 6TiSCH de 1 a 20 fatias por enlace e com o Wi-SUN FAN a 50, 150 e 300 kbps, todos sobre o rádio da referência. A tabela a seguir resume o resultado. Em todas as execuções que fecharam, a negociação converge nas mesmas 42 rodadas, nenhuma mensagem se perde, e o resultado elétrico é idêntico ao da entrega ideal, tensão a tensão; o que muda é só o tempo de rede.

| Rede | Ciclo 3 por rodada | Rodadas acima de 300 s | Despacho | Execução |
|--------------------------|----------------:|----------------:|----------:|----------:|
| 6TiSCH, 1 fatia | 945 a 1.081 s | 42 | 1.550 s | 33 min |
| 6TiSCH, 2 fatias (padrão) | 474 a 541 s | 42 | 779 s | 17 min |
| 6TiSCH, 5 fatias | 192 a 218 s | 0 | 316 s | 8 min |
| 6TiSCH, 10 fatias | 97 a 110 s | 0 | 161 s | 5 min |
| 6TiSCH, 20 fatias | 50 a 56 s | 0 | 84 s | 3 min |
| Wi-SUN FAN, 50 kbps | 5 a 6 s | 0 | 8 s | 1,2 min |
| Wi-SUN FAN, 150 kbps | 2 s | 0 | 4,5 s | 1 min |
| Wi-SUN FAN, 300 kbps | não fecha | | | |

Table: Tempo de rede do mercado por fase em cada rede, no IEEE 13 barras; a 300 kbps a rede perde o alcance da subestação.

Na 6TiSCH, o tempo cai na proporção das fatias, e o ciclo 3 cabe no orçamento a partir de quatro ou cinco fatias por enlace, um parâmetro que a referência não informa. O Wi-SUN FAN a 50 kbps, com o mesmo rádio, fica duas ordens de grandeza abaixo da 6TiSCH padrão: transmite sem esperar fatia e leva a mensagem de 24 kB em 19 quadros, contra 190. Taxa maior só ajuda enquanto o alcance cobre o alimentador: a 300 kbps, a sensibilidade cai cerca de 8 dB, a rede fica com 51 enlaces em vez de 74, e as mensagens de 24 kB não atravessam a ligação entre a subestação e o resto do alimentador.

O consumo maior do Wi-SUN FAN pesa pouco no mercado, cujos nós são alimentados pela rede elétrica. A disputa pelo meio, que o modelo não representa, favorece o Wi-SUN na comparação: o concentrador tem um rádio só e mandaria os dez despachos em sequência, cerca de 80 s no total, ainda bem abaixo do orçamento, mas como estimativa, e não como medida. A 6TiSCH com cinco ou mais fatias mantém a fidelidade à referência; o Wi-SUN FAN a 50 kbps é a rede mais adequada ao tráfego real do mercado por fase, desde que a disputa seja medida antes da adoção.

## Síntese e limitações

A tabela a seguir compara o ponto de partida com o estado atual da plataforma. O ganho principal é de natureza estrutural: os experimentos passaram a ser reprodutíveis por um comando, e a informação que chega ao agente atravessa um modelo de rede explícito.

| Item | Ponto de partida | Estado atual |
|------------|-------------------------|------------------------------|
| Execução | três repositórios separados, ambientes incompatíveis | um repositório agregador, cinco contêineres, um comando com console |
| Runtime dos agentes | PADE em Python 3.6, ponte com Mosaik 2 | PADE 3.0 em Python 3.12, ponte com Mosaik 3.5 |
| Rede no laço | módulo ns-3 removido, entrega imediata | camada própria com três modelos de canal, inclusive 6TiSCH e Wi-SUN FAN |
| Benchmark elétrico | circuito herdado com defeitos de fase e de curvas | IEEE 13 conferido contra o perfil publicado |
| Camada de mercado | dois repositórios antigos, sem execução | portada para Pyomo, analisada por fase e executada com a rede 6TiSCH |

Table: Situação da plataforma antes e depois do trabalho do TTESO.

As limitações a registrar são três. O modelo de perda da rede no cenário de validação é fenomenológico, sorteado pacote a pacote, e não emerge do tráfego. A topologia de rádio do IEEE 13 é reconstruída a partir das coordenadas do alimentador, e a mesma reconstrução, aplicada à rede da tese, gerou uma rede mais densa que a publicada, o que torna os resultados de comunicação otimistas. E o modelo do operador é linearizado: o erro chega a 9,5 mpu no fluxo de potência completo e deixa 28 leituras de fase abaixo de 0,97 pu no fim do ramal 684-611, todas dentro da faixa A.

# Conclusão

Os seis objetivos específicos foram cumpridos. O PADE roda em Python 3.12 como versão 3.0, com a ponte para o Mosaik 3 refeita; a camada de rede entrega as mensagens dos agentes por um modelo de canal explícito, com a rede 6TiSCH do OMNeT++ entre as opções; os simuladores das três equipes rodam em contêineres por domínio, com um script único; o IEEE 13 barras está montado como benchmark, com geração fotovoltaica e controle Volt/Var nos agentes; o efeito do controle e a sensibilidade dele à perda de pacotes foram medidos; e a camada de mercado transativo roda sobre a mesma plataforma, estendida para a análise por fase que o alimentador desequilibrado pede.

O resultado com maior valor para o projeto é a plataforma em si. Ela permite que um experimento seja descrito por um cenário e um comando, e que a informação elétrica que chega a um agente tenha atravessado um simulador de rede. Foi essa propriedade que expôs os achados do ciclo. No controle Volt/Var, o ganho seguro depende da qualidade da comunicação, e o benefício persiste sob perda alta quando a dinâmica do caso é lenta. No mercado, a análise por fase revela violações que a média por barra esconde, e a rede de comunicação precisa ser dimensionada pelo tamanho real das mensagens: com elas, a 6TiSCH da referência só cabe no tempo de cada ciclo com mais fatias por enlace, e o Wi-SUN FAN, sobre o mesmo rádio, cabe com folga.

Duas frentes previstas no início do ciclo foram concluídas: a documentação navegável do repositório, publicada com MkDocs, e a formulação por fase para o operador da distribuição. A continuidade tem três frentes. A primeira é reduzir o erro de linearização do operador, de até 9,5 mpu, recalculando a sensibilidade em torno do ponto negociado; é ele que deixa 28 leituras de fase abaixo de 0,97 pu, todas dentro da faixa A. A segunda é a comunicação do mercado, descrita nas Seções 5.4 e 5.5: escolher a rede entre a 6TiSCH com mais fatias e o Wi-SUN FAN, depois de medir o efeito da disputa pelo meio, e reduzir o despacho ao que cada prosumidor precisa. A terceira é ampliar o conjunto de benchmarks, aproveitando as redes de teste já geradas pelo grupo.

## Encaminhamentos

1. Recalcular a sensibilidade em torno do ponto negociado e medir o ganho no fluxo de potência não linear.
2. Modelar a disputa pelo meio no servidor de rede e, com ela, escolher entre a 6TiSCH com mais fatias e o Wi-SUN FAN; enxugar a mensagem de despacho.
3. Estender a validação a outras redes de teste do grupo.
4. Registrar os experimentos e as métricas em um formato comparável entre os times.

# Referências

\begingroup\small\setstretch{1.0}\raggedright\setlength{\parskip}{2pt}

[1] SCHÜTTE, S.; SCHERFKE, S.; TRÖSCHEL, M. *Mosaik: a framework for modular simulation of active components in smart grids*. In: IEEE First International Workshop on Smart Grid Modeling and Simulation (SGMS), Bruxelas, p. 55-60, 2011.

[2] STEINBRINK, C. et al. *CPES testing with mosaik: co-simulation planning, execution and analysis*. Applied Sciences, v. 9, n. 5, p. 923, 2019.

[3] MELO, L. S. *Modelo de simulação computacional multidomínio para análise de redes elétricas inteligentes com aplicação em transações econômicas de energia*. Tese (Doutorado em Engenharia Elétrica), Universidade Federal do Ceará, Fortaleza, 2022.

[4] PALENSKY, P. et al. *Cosimulation of intelligent power systems: fundamentals, software architecture, numerics, and coupling*. IEEE Industrial Electronics Magazine, v. 11, n. 1, p. 34-50, 2017.

[5] MELO, L. S. et al. *Python-based multi-agent platform for application on power grids*. International Transactions on Electrical Energy Systems, v. 29, n. 6, e12012, 2019. Repositório: <https://github.com/grei-ufc/pade>.

[6] VARGA, A.; HORNIG, R. *An overview of the OMNeT++ simulation environment*. In: 1st International Conference on Simulation Tools and Techniques for Communications, Networks and Systems (SIMUTools), Marselha, 2008.

[7] DUGAN, R. C.; McDERMOTT, T. E. *An open source platform for collaborating on smart grid research*. In: IEEE Power and Energy Society General Meeting, Detroit, p. 1-7, 2011.

[8] RADATZ, P. *py-dss-interface: a Python package that interfaces with OpenDSS*. Disponível em: <https://github.com/PauloRadatz/py_dss_interface>. Acesso em: 23 set. 2026.

[9] IEEE POWER AND ENERGY SOCIETY. *IEEE 13 node test feeder*. Distribution System Analysis Subcommittee, 2001. Disponível em: <https://cmte.ieee.org/pes-testfeeders/resources/>. Acesso em: 23 set. 2026.

[10] JESUS, C. D.; FERREIRA, R. N.; AGUIAR, E. P. *BR-PVGen: the Brazilian photovoltaic generation dataset*. Zenodo, 2026. DOI: 10.5281/zenodo.21511487.

[11] INSTITUTE OF ELECTRICAL AND ELECTRONICS ENGINEERS. *IEEE Std 1547-2018*: standard for interconnection and interoperability of distributed energy resources with associated electric power systems interfaces. Nova York, 2018.

[12] AMERICAN NATIONAL STANDARDS INSTITUTE. *ANSI C84.1-2020*: electric power systems and equipment: voltage ratings (60 Hz). Rosslyn, 2020.

[13] OPENTES. *Repositório da plataforma de co-simulação*. Disponível em: <https://github.com/grei-ufc/co-simulation-opentes>. Acesso em: 23 set. 2026.

[14] OPENTES. *Repositório geral do projeto*. Disponível em: <https://github.com/grei-ufc/general-opentes>. Acesso em: 23 set. 2026.

[15] SCHLOEGL, F.; ROHJANS, S.; LEHNHOFF, S.; VELASQUEZ, J.; STEINBRINK, C.; PALENSKY, P. *Towards a classification scheme for co-simulation approaches in energy systems*. In: International Symposium on Smart Electric Distribution Systems and Technologies (EDST), p. 516-521, 2015.

[16] GOMES, C.; THULE, C.; BROMAN, D.; LARSEN, P. G.; VANGHELUWE, H. *Co-simulation: a survey*. ACM Computing Surveys, v. 51, n. 3, 2018.

[17] VOGT, M.; MARTEN, F.; BRAUN, M. *A survey and statistical analysis of smart grid co-simulations*. Applied Energy, v. 222, p. 67-78, 2018.

[18] PALMINTIER, B.; KRISHNAMURTHY, D.; TOP, P.; SMITH, S.; DAILY, J.; FULLER, J. *Design of the HELICS high-performance transmission-distribution-communication-market co-simulation framework*. In: Workshop on Modeling and Simulation of Cyber-Physical Energy Systems (MSCPES), Pittsburgh, 2017.

[19] CHASSIN, D. P.; FULLER, J. C.; DJILALI, N. *GridLAB-D: an agent-based simulation framework for smart grids*. Journal of Applied Mathematics, v. 2014, art. 492320, 2014.

[20] FOUNDATION FOR INTELLIGENT PHYSICAL AGENTS. *FIPA ACL message structure specification*. SC00061G. Genebra, 2002.

[21] FOUNDATION FOR INTELLIGENT PHYSICAL AGENTS. *FIPA contract net interaction protocol specification*. SC00029H. Genebra, 2002.

[22] GRIDWISE ARCHITECTURE COUNCIL. *GridWise transactive energy framework*: version 1.0. PNNL-22946. Richland: Pacific Northwest National Laboratory, 2015.

[23] KOK, K.; WIDERGREN, S. *A society of devices: integrating intelligent distributed resources with transactive energy*. IEEE Power and Energy Magazine, v. 14, n. 3, p. 34-45, 2016.

[24] MELO, L. S.; TOFOLI, F. L.; ISSICABA, D.; MONTEIRO, M. E. P.; BARROSO, G. C.; SAMPAIO, R. F.; LEÃO, R. P. S. *Co-simulation platform for the assessment of transactive energy systems*. Electric Power Systems Research, v. 223, art. 109693, 2023.

[25] HU, J.; YANG, G.; BINDNER, H. W.; XUE, Y. *Application of network-constrained transactive control to electric vehicle charging for secure grid operation*. IEEE Transactions on Sustainable Energy, v. 8, n. 2, p. 505-515, 2017.

[26] BAI, L.; WANG, J.; WANG, C.; CHEN, C.; LI, F. *Distribution locational marginal pricing (DLMP) for congestion management and voltage support*. IEEE Transactions on Power Systems, v. 33, n. 4, p. 4061-4073, 2018.

[27] LIU, Y.; LI, J.; WU, L. *Distribution system restructuring: distribution LMP via unbalanced ACOPF*. IEEE Transactions on Smart Grid, v. 9, n. 5, p. 4038-4048, 2018.

[28] ZHANG, R.; PRASAD, V. H.; BOROYEVICH, D.; LEE, F. C. *Three-dimensional space vector modulation for four-leg voltage-source converters*. IEEE Transactions on Power Electronics, v. 17, n. 3, p. 314-326, 2002.

[29] PETÄJÄJÄRVI, J.; MIKHAYLOV, K.; ROIVAINEN, A.; HÄNNINEN, T.; PETTISSALO, M. *On the coverage of LPWANs: range evaluation and channel attenuation model for LoRa technology*. In: 14th International Conference on ITS Telecommunications (ITST), p. 55-59, 2015.

[30] PRANDO, L. R.; DE LIMA, E. R.; DE MORAES, L. S.; HAMERSCHMIDT, M. B.; FRAIDENRAICH, G. *Experimental performance comparison of emerging low power wide area networking (LPWAN) technologies for IoT*. In: IEEE 5th World Forum on Internet of Things (WF-IoT), p. 905-908, 2019.

[31] VILAJOSANA, X.; WATTEYNE, T.; CHANG, T.; VUČINIĆ, M.; DUQUENNOY, S.; THUBERT, P. *IETF 6TiSCH: a tutorial*. IEEE Communications Surveys & Tutorials, v. 22, n. 1, p. 595-615, 2020.

[32] CHANG, T. (ed.); VUČINIĆ, M.; VILAJOSANA, X.; DUQUENNOY, S.; DUJOVNE, D. *6TiSCH minimal scheduling function (MSF)*. RFC 9033. Internet Engineering Task Force, 2021.

[33] MUNICIO, E.; DANEELS, G.; VUČINIĆ, M.; LATRÉ, S.; FAMAEY, J.; TANAKA, Y.; BRUN, K.; MURAOKA, K.; VILAJOSANA, X.; WATTEYNE, T. *Simulating 6TiSCH networks*. Transactions on Emerging Telecommunications Technologies, v. 30, n. 3, e3494, 2019.

[34] HARADA, H.; MIZUTANI, K.; FUJIWARA, J.; MOCHIZUKI, K.; OBATA, K.; OKUMURA, R. *IEEE 802.15.4g based Wi-SUN communication systems*. IEICE Transactions on Communications, v. E100-B, n. 7, p. 1032-1043, 2017.

\endgroup
