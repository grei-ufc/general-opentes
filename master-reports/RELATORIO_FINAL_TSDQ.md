
---
title: "Relatório Final de Projeto — ARGOS"
subtitle: "Visualização de resultados de co-simulação e qualidade de energia elétrica"
author:
  - "Equipe TSDQ"
  - "OpenTES"
date: "2026-10-27"
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
    \lhead{OpenTES — TSDQ / ARGOS}
    \rhead{\nouppercase{\leftmark}}
    \cfoot{\thepage}
pdf-engine: xelatex
---

# Sumário Executivo

A ARGOS é uma aplicação desenvolvida em Python e Streamlit para a inspeção de resultados de co-simulação no âmbito do OpenTES. Topologias, medições elétricas e registros de comunicação são organizados em três áreas: Mapa de Rede, Análise Elétrica e Comunicação. Nessas áreas, os dados fornecidos pelos simuladores são apresentados de modo a preservar a identificação das medições e permitir o acompanhamento dos elementos ao longo do período disponível.

No Mapa de Rede, a entrada consiste em uma topologia JSON e um arquivo CSV de resultados vinculados por SHA-256, ou em um circuito OpenDSS compactado em ZIP. No primeiro caso, a estrutura da rede é relacionada às séries temporais; no segundo, a topologia é obtida pela compilação do circuito, sem que isso forneça, por si só, o histórico de uma co-simulação. A representação interativa permite consultar barramentos, ramos e equipamentos, acompanhar as tensões por fase e examinar os indicadores DRP e DRC, com suas contribuições de subtensão e sobretensão. Nessa organização, o cadastro topológico informa a presença de geração fotovoltaica, enquanto as medições disponíveis descrevem seu estado de potência.

A descrição técnica apresentada neste relatório baseia-se no código-fonte da aplicação [1] e se restringe às operações implementadas. A consulta dos resultados pela interface, portanto, não substitui a validação dos modelos utilizados pelos simuladores nem constitui homologação automática dos estudos de caso.

# Introdução

## Contextualização

A interpretação dos resultados de uma co-simulação de sistemas elétricos depende da relação entre as medições, suas referências temporais e as conexões dos equipamentos. Para essa leitura, é necessário reconhecer a origem de cada variável e distinguir as grandezas do barramento, os fluxos nos ramos e as potências dos equipamentos. Desenvolvida no âmbito das atividades do time TSDQ no OpenTES, a ARGOS reúne esses resultados em uma interface de consulta com navegação gráfica e tabular, seleção de elementos e análise temporal.

O acesso aos módulos ocorre pela tela inicial, que adota a identidade visual do Grupo de Redes Elétricas Inteligentes da Universidade Federal do Ceará, conforme a Figura \ref{fig:tela-inicial}. Ao selecionar uma área, o usuário é encaminhado às respectivas rotinas de entrada e análise; a página inicial não executa cenários de co-simulação.

\begin{figure}[H]
\centering
\includegraphics[trim=20 170 20 40,clip,width=0.9\linewidth,height=0.32\textheight,keepaspectratio]{master-reports/figures/tsdq/ARGOS _ GREI.pdf}
\caption{Tela inicial da plataforma ARGOS.}
\label{fig:tela-inicial}
\end{figure}

## Motivação e justificativa

A leitura de um valor isolado no CSV não esclarece sua relação com a rede. Dessa forma, ao reunir a posição topológica, a identidade do elemento e a evolução temporal da variável, a plataforma permite examinar ocorrências de tensão, identificar as fases envolvidas e consultar os equipamentos conectados. Essa associação preserva a distinção entre as grandezas de cada elemento, sem atribuir ao barramento uma potência pertencente a uma carga, geração ou ramo.

Para descrever como essas relações são estabelecidas, o relatório apresenta as regras de entrada, associação e apresentação dos dados. A distinção entre informações cadastradas, medições recebidas e grandezas calculadas orienta a interpretação dos resultados e delimita seu uso nos estudos de caso.

## Objetivos

### Objetivo geral

Apresentar resultados de co-simulação de sistemas elétricos em uma interface integrada de inspeção topológica, análise temporal e avaliação das grandezas disponibilizadas nos arquivos de entrada.

### Objetivos específicos

- Receber topologias e resultados em formatos compatíveis com cada módulo.
- Verificar o vínculo SHA-256 entre a topologia JSON e o CSV associado.
- Relacionar as variáveis aos barramentos, ramos e equipamentos declarados.
- Apresentar medições instantâneas, séries temporais, tabelas e diagnósticos de associação.
- Distinguir fases ausentes de tensões medidas iguais a zero e decompor DRP e DRC por fase, subtensão e sobretensão.
- Permitir a consulta dos registros e indicadores de comunicação fornecidos pela co-simulação.

# Fundamentos da organização dos dados

A representação elétrica adotada distingue barramentos, ramos e equipamentos. O barramento identifica um ponto da rede e as tensões nele medidas, enquanto o ramo conecta barras e reúne suas próprias medições de corrente e fluxo de potência. Os equipamentos, por sua vez, conservam sua identidade e o vínculo com o barramento de conexão. Dessa forma, uma mesma barra pode reunir carga, geração fotovoltaica e outros equipamentos sem que a presença de um deles exclua os demais.

Essa distinção se estende à relação entre o cadastro topológico e os resultados temporais. Embora descreva conexões e atributos, o cadastro não comprova, por exemplo, que um PVSystem esteja injetando potência em determinado instante ou que um ramo possua medições no CSV. Do mesmo modo, o estado de abertura declarado na topologia não descreve uma sequência de manobras. O conteúdo do inspetor, das tabelas e dos gráficos respeita essa separação entre o que está cadastrado e o que foi medido ao longo do tempo.

# Materiais e Métodos

## Ferramentas e organização da aplicação

A leitura, o processamento tabular e a apresentação dos dados são realizados com Python, Streamlit, pandas e Plotly. Para a visualização da rede, a aplicação emprega *streamlit-agraph* ou um componente local em D3/JavaScript, enquanto o acesso ao circuito OpenDSS utiliza *OpenDSSDirect.py*. O código é organizado em páginas, componentes visuais, utilitários de análise e módulos de rede, com a navegação inicial concentrada em *Home.py*.

Cada módulo possui um fluxo de entrada próprio. O Mapa de Rede recebe o par JSON e CSV vinculado ou um circuito em ZIP; a página Análise Elétrica permite a leitura independente de CSV e de tabelas H5/HDF5 compatíveis com suas rotinas; e a página Comunicação recebe um CSV com os registros esperados pelo leitor de mensagens. O suporte a HDF5 restringe-se, assim, à análise tabular e não se estende à entrada do Mapa de Rede.

## Etapas metodológicas

O tratamento integrado dos resultados começa com a recepção dos arquivos e a conferência de seu vínculo. Essa etapa é importante, pois sem ela as chances de erro humano é maior, uma vez que se os dados de entrada pertencerem a sistemas distindos os resultados estarão errados. Em seguida, depois da validação, a topologia é adaptada, as colunas são catalogadas e as medições são associadas aos elementos da rede. Essa estrutura permite que as seleções do usuário definam o instante e o elemento consultados. As etapas a seguir descrevem os procedimentos nessa ordem de processamento.

### Fornecimento dos arquivos e identificação das medições

Na página Mapa de Rede, o usuário escolhe entre dois modos de entrada. A opção “Resultados da co-simulação” recebe um JSON topológico e um CSV temporal, cujo carregamento conjunto depende da verificação SHA-256. Já a opção “Circuito OpenDSS (.zip)” recebe um circuito compactado e o encaminha a um procedimento próprio de compilação. Esses modos são apresentados na Figura \ref{fig:modos-entrada}.

\begin{figure}[H]
\centering
\includegraphics[trim=20 170 20 40,clip,width=0.9\linewidth,height=0.32\textheight,keepaspectratio]{master-reports/figures/tsdq/ARGOS _ GREI_2.pdf}
\caption{Modos de entrada do Mapa de Rede.}
\label{fig:modos-entrada}
\end{figure}

No fluxo temporal, a função *load_cosim_results* lê as colunas e constrói um catálogo que preserva o cabeçalho original, a variável e suas informações de associação. Quando o grafo está disponível, *vincular_medicoes_rede* compara essas colunas com o cadastro completo de entidades. Os cabeçalhos não reconhecidos permanecem identificados para consulta no diagnóstico, sem atribuição arbitrária a um barramento.

No fluxo ZIP, a função *compile_circuit* extrai os arquivos em um diretório temporário, ajusta as referências quanto à capitalização por meio de *normalize_dss_redirects* e seleciona o arquivo principal com *find_master*. Essa seleção prioriza nomes que contenham “master”, “main” ou “run”; na ausência dessas indicações, utiliza o único DSS ou o maior arquivo disponível. Antes da compilação, *sanitize_master* gera uma cópia sem os comandos *Show* e *Plot*. Concluída a compilação, *build_graph* obtém os barramentos e as conexões de linhas e transformadores. Por trabalhar diretamente com o circuito, esse fluxo não compara um par JSON e CSV nem produz a série temporal externa necessária às análises do período. Os métodos de entrada e saída de cada fluxo são resumidos na Figura \ref{fig:vinculo-csvjson} e Figura \ref{fig:vinculo-zip}.

\begin{figure}[H]
\centering
\begin{minipage}[t]{0.48\linewidth}
\centering
\vspace{0pt}
\parbox[c][7cm][c]{\linewidth}{%
\centering
\includegraphics[width=\linewidth,height=7cm,keepaspectratio]{master-reports/figures/tsdq/Fluxograma.pdf}
}
\caption{Fluxo por meio do JSON e o conteúdo do CSV.}
\label{fig:vinculo-csvjson}
\end{minipage}
\hfill
\begin{minipage}[t]{0.48\linewidth}
\centering
\vspace{0pt}
\parbox[c][7cm][c]{\linewidth}{%
\centering
\includegraphics[width=\linewidth,height=7cm,keepaspectratio]{master-reports/figures/tsdq/Fluxograma_zip.pdf}
}
\caption{Fluxo por meio do ZIP.}
\label{fig:vinculo-zip}
\end{minipage}
\end{figure}

### Leitura do JSON e localização do vínculo

A leitura do JSON é realizada por *carregar_json_upload*, função do utilitário de vínculo de arquivos que decodifica o conteúdo e exige um objeto na raiz. Em seguida, *obter_hash_vinculado* consulta os campos reconhecidos para localizar o resumo declarado. No contrato do JSON v2, esse resumo é informado em *results_sha256*, na raiz do documento. O leitor também aceita os campos equivalentes dos formatos legados, inclusive aqueles presentes em *metadata* e nos envelopes de hash previstos.

Nessa etapa, a verificação se limita à localização do vínculo declarado. A estrutura dos barramentos, das conexões e dos equipamentos é examinada somente após a comparação do resumo. Por isso, mesmo um JSON sintaticamente válido e com hash correspondente pode ser rejeitado posteriormente se contiver referências inexistentes, identidades duplicadas ou uma versão não suportada.

### Cálculo do resumo SHA-256 do CSV

Em *utils/vinculo_arquivos.py*, a função *calcular_sha256_upload* posiciona o cursor no início do arquivo, lê seus bytes e aplica *hashlib.sha256*. O resumo hexadecimal resultante é convertido para maiúsculas, e o cursor retorna ao início para permitir a leitura tabular posterior. Desse modo, o cálculo considera o conteúdo binário original do CSV, sem reconstruí-lo a partir de um DataFrame.

A comparação por SHA-256 verifica a correspondência entre o conteúdo carregado e o resumo registrado, mas não constitui criptografia reversível nem autentica, isoladamente, a autoria da topologia. Para preservar essa condição de conferência, a interface não gera um resumo substituto durante o upload que permita aceitar arquivos incompatíveis.

### Comparação do vínculo e condição para carregar os dados

De posse dos dois resumos, *validar_vinculo* exige que o vínculo esteja declarado e compara os textos após remover espaços externos e normalizar a caixa. O resultado é apresentado na página do mapa por *render_validacao_vinculo*. Se o hash estiver ausente ou os valores forem diferentes, a chamada integrada dos carregadores de topologia e resultados é impedida. A Figura \ref{fig:vinculo-hash} representa o fluxo de verificação do hash pela plataforma.

\begin{figure}[H]
\centering
\includegraphics[width=0.45\linewidth,height=0.23\textheight,keepaspectratio]{master-reports/figures/tsdq/Fluxograma_hash.pdf}
\caption{Conferência do vínculo entre o JSON e o conteúdo do CSV.}
\label{fig:vinculo-hash}
\end{figure}

A aprovação dessa conferência confirma a igualdade dos resumos, sem demonstrar que as conexões representam corretamente o sistema físico. O registro explícito do vínculo pode ser feito fora da interface pelo script independente *aplicar_hash_topologia.py*, que utiliza a raiz do JSON no v2 e *metadata* no formato legado. Como um recorte temporal modifica o conteúdo do CSV, o arquivo recortado requer seu próprio vínculo correspondente.

### Adaptação topológica e construção do grafo em memória

Após a conferência do vínculo, *load_topology_json* encaminha a estrutura a *adapt_topology*, que seleciona o adaptador conforme a versão declarada. Arquivos sem versão ou com versão 1 recebem o tratamento legado, enquanto aqueles com versão 2 seguem o esquema v2; versões explícitas não suportadas são rejeitadas. Os dois adaptadores produzem uma representação interna comum, dispensando os componentes visuais de interpretar separadamente cada formato de origem.

No esquema v2, *nodes* reúne o nome, a base em kV, os nós conectados e as coordenadas de cada barramento. As conexões são descritas em *edges*, com tipo, nome, extremos, quantidade de fases, estado de abertura e controles reguladores, enquanto *elements* cadastra o tipo, o nome, a barra, os nós e as fases dos equipamentos. A identidade de um barramento corresponde ao seu nome; para ramos e equipamentos, ela resulta da combinação entre tipo e nome. A construção é impedida quando há duplicidades ou referências a barras inexistentes, mas admite listas vazias de ramos ou equipamentos, desde que exista ao menos uma barra válida.

Na adaptação, os nomes originais são preservados para apresentação, e as comparações utilizam identificadores normalizados. Os campos *phases* e *nodes* são tratados separadamente, pois um equipamento monofásico em delta pode ocupar dois nós. Quanto às coordenadas, valores iguais a zero são válidos, mas o par somente é considerado disponível quando ambos os eixos são utilizáveis. A base em kV também é armazenada conforme recebida, sem inferência de conversões automáticas entre tensão fase-neutro, fase-fase e pu.

Os dados adaptados são organizados em memória por meio de *NetworkGraph*, *NetworkNode* e *NetworkEdge*. O grafo mantém dicionários de barramentos, arestas e metadados, preenchidos pelos métodos *add_node* e *add_edge*. Por se tratar de uma estrutura própria, sua organização independe do renderizador e não utiliza NetworkX. A Figura \ref{fig:nos-barras} apresenta a representação visual dessa topologia.

\begin{figure}[H]
\centering
\includegraphics[width=0.9\linewidth,height=0.28\textheight,keepaspectratio]{master-reports/figures/tsdq/Nós_barras.png}
\caption{Representação da topologia por barramentos e conexões.}
\label{fig:nos-barras}
\end{figure}

### Leitura tabular e preparação do eixo temporal

A leitura tabular é realizada por *load_cosim_results* com o uso de *pandas.read_csv*. Nessa rotina, os espaços externos dos cabeçalhos são removidos, e conjuntos sem registros ou sem colunas posteriores à referência temporal são rejeitados. A primeira coluna é interpretada como tempo por *pandas.to_datetime*, com suporte a formatos mistos e conversão das entradas não interpretáveis em valores temporais ausentes. As colunas restantes compõem o catálogo de medições, mesmo quando não há associação reconhecida para elas.

Ao final dessa leitura, são retornados o DataFrame, o catálogo, a identificação da coluna temporal e os tempos interpretados. A preparação dos gráficos cabe a *preparar_dataframe_analise*, que utiliza o tempo convertido ou, quando toda a referência temporal é inválida, a posição das amostras. Esse procedimento não cria medições nem reamostra os dados para adequar o período a exigências de medição oficial.

### Associação das medições e preparação das séries

A associação das colunas à rede utiliza o cadastro de barramentos, ramos, equipamentos e controles reguladores reunido por *vincular_medicoes_rede*. A correspondência considera a identidade completa que antecede a variável, inclusive em nomes com hífen. Assim, o cabeçalho *DSS-5.PVSystem-pv-4-P_meas* identifica o PVSystem denominado *pv-4* e sua variável *P_meas*. O identificador da instância DSS não é restrito a zero, e entidades de classes diferentes podem compartilhar um nome sem perder sua distinção.

Quando os nomes cadastrados compartilham um prefixo, a resolução adota a correspondência completa mais longa. Nas convenções que incluem uma indicação explícita de barra, essa indicação é confrontada com o vínculo topológico. Referências desconhecidas, ambíguas ou conflitantes permanecem sem associação, com o motivo registrado no diagnóstico. No v2, a presença de um único PV não é utilizada para inferir a barra de uma coluna; já *vincular_medicoes_pv* preserva os mecanismos de associação aplicáveis às entradas legadas.

Com as associações estabelecidas, *apply_measurement_snapshot* remove as medições do instante anterior, consulta a linha selecionada e atribui os valores numéricos aos elementos reconhecidos. O organizador *_measurement* preserva a variável, a unidade, o rótulo, a coluna original e a identidade. As tensões continuam vinculadas ao barramento, as correntes e os fluxos ao ramo, e as potências dos equipamentos aos respectivos proprietários, mesmo quando consultadas pela barra de conexão. Os valores iguais a zero são mantidos, enquanto as medições ausentes naquele instante não compõem o snapshot.

Além da consulta instantânea, a análise do período utiliza *montar_estrutura_analise_rede* para organizar as variáveis por tipo e elemento. A função *prepare_node_time_series* prepara, então, as séries do nó e dos equipamentos vinculados. Essas rotinas e os quadros temporais do D3 utilizam o mesmo resolvedor de associação, de modo que a consulta instantânea e a temporal seguem critérios comuns.

### Renderização e interação com os resultados

A apresentação do grafo pode ser feita por *render_graph*, que utiliza os objetos de *streamlit-agraph* com física habilitada, ou por *render_graph_d3*, que encaminha a topologia e os quadros preparados por *build_d3_temporal_frames* ao componente D3/JavaScript. Neste componente, o usuário pode reproduzir a evolução temporal, selecionar e arrastar os nós. A posição, o instante e o estado de reprodução são armazenados localmente para recuperação durante as interações.

Durante a reprodução no navegador, a consulta local do nó e sua curva acompanham a evolução temporal no D3. Ao acionar “Analisar nó”, o usuário executa *applySelectedNode*, que comunica a seleção e o índice temporal ao Streamlit. Esse evento atualiza o barramento analisado e as informações apresentadas fora do componente. A animação local, assim, não exige a execução das rotinas Python a cada quadro: o inspetor e os gráficos da página refletem o instante comunicado pelo componente ou selecionado no controle da aplicação.

Abaixo do grafo, o inspetor reúne cartões de medições, o cadastro dos equipamentos e as informações de regulação associadas. Nas abas de análise, é possível consultar o barramento, os ramos conectados que possuem medições, os equipamentos vinculados e as grandezas derivadas. A consulta temporal é apresentada por *render_oscilografia_no*, que traça as séries de tensão do CSV e marca o instante selecionado. O termo “oscilografia” refere-se, nesse contexto, à série temporal disponível, e não à reconstrução de uma forma de onda elétrica de alta frequência a partir de amostras espaçadas da simulação.

### Diagnósticos e verificação das saídas

A conferência das associações pode ser feita pelos contadores de barramentos e ramos com medições, colunas associadas e colunas sem associação. Para estas últimas, o expansor de medições sem vínculo apresenta o cabeçalho e o motivo do impedimento, mesmo quando não há valor disponível no instante consultado. O diagnóstico da rede complementa essa leitura com informações sobre barramentos, classes, conexões e estado topológico dos ramos, sem certificar a completude de todas as séries.

A verificação do código também inclui testes automatizados das rotinas de qualidade de energia, identificação de fases, associação fotovoltaica, cartões, recorte temporal e topologia v2. Os casos exercitados abrangem nomes com hífen, múltiplos PVs, coexistência de carga e PV em uma barra, identidades repetidas, referências inexistentes, coordenadas zero, ramos abertos e validação de hash. Embora essas fixtures permitam verificar o comportamento das rotinas, a homologação de um estudo depende da conferência do par de arquivos efetivamente exportado e dos critérios técnicos adotados pelos responsáveis pela simulação.

## Classificação dos barramentos e leitura das grandezas

A classificação dos barramentos no JSON v2 é construída a partir das informações declaradas: Vsource identifica a fonte, os equipamentos são agrupados por barra, os controles indicam a regulação e os extremos dos transformadores identificam suas conexões. Quando a representação exige um destaque principal, a precedência adotada é fonte, regulação, PV, armazenamento, gerador, carga, capacitor, conexão a transformador e barra comum. Essa prioridade não elimina as demais características, que permanecem disponíveis no cadastro e no inspetor.

A representação também preserva os ramos declarados como abertos, que aparecem tracejados e mantêm seu estado disponível para consulta. A classificação topológica é tratada separadamente da condição de tensão, indicada pelo preenchimento nas faixas adequada, precária e crítica. No D3, os setores do nó distinguem o estado de cada fase; fases ausentes ou sem medição são representadas em cinza, com informações complementares disponíveis ao selecionar o nó.

A distinção entre ausência de fase e falta de tensão é estabelecida por *motivo_fase_ausente*, que considera os nós explicitamente conectados no JSON ou uma série inteiramente NaN. Valores iguais a zero, mesmo que persistam durante toda a série, são medições válidas e podem representar tensão crítica. Da mesma forma, um NaN isolado não elimina uma fase com medições em outros instantes. Quando a fase é considerada presente, os zeros integram tanto as médias quanto os indicadores.

Na apresentação das medições, os cartões do inspetor se referem ao instante selecionado, enquanto os de qualidade energética utilizam as séries do período. Seus rótulos e unidades seguem as convenções dos cabeçalhos e os utilitários de mapeamento, unidades e escalas. Para *P_meas* e *Q_meas*, a apresentação adota provisoriamente W e var. A existência de um PVSystem no cadastro não permite gerar informações de temperatura, irradiância, potência DC ou potência separada do inversor quando as respectivas colunas não são fornecidas.

Para indicar o estado fotovoltaico, o cartão utiliza a potência ativa medida, priorizando as informações de PVSystem, inversor e painel, nessa ordem. A identificação de entrega, absorção ou ausência de entrega de potência segue a convenção de sinais implementada, cuja interpretação depende do contrato do exportador. Quando há pares correspondentes de P e Q por fase do próprio elemento, esses valores também permitem calcular a potência aparente na análise de grandezas derivadas:

$$
S_f = \sqrt{P_f^2 + Q_f^2}.
$$

O resultado é identificado como potência aparente calculada, distinguindo-se de uma coluna lida diretamente do arquivo. Sua evolução temporal por fase é ilustrada na Figura \ref{fig:potencia-aparente}.

\begin{figure}[H]
\centering
\includegraphics[width=0.95\linewidth,height=0.25\textheight,keepaspectratio]{master-reports/figures/tsdq/potencia aparente.png}
\caption{Potência aparente calculada por fase a partir dos pares de potência ativa e reativa.}
\label{fig:potencia-aparente}
\end{figure}

## Indicadores de qualidade de energia

A apuração dos indicadores de qualidade de energia é realizada por *calcular_drp_drc_por_fase*, que seleciona as magnitudes de tensão e distingue amostras válidas, ausências e colunas descartadas. As séries em pu são utilizadas diretamente, enquanto as séries em valores absolutos exigem uma referência válida para o cálculo proporcional. Os limites aplicados e as contribuições de cada fase podem ser consultados na interface, juntamente com a apresentação temporal das tensões exemplificada na Figura \ref{fig:serie-exemplo}.

\begin{figure}[H]
\centering
\includegraphics[width=0.85\linewidth,height=0.25\textheight,keepaspectratio]{master-reports/figures/tsdq/plotagem_exemplo.png}
\caption{Apresentação das séries temporais de tensão de um barramento.}
\label{fig:serie-exemplo}
\end{figure}

O cálculo considera, em cada fase, a quantidade de amostras nas faixas precárias e críticas, separando as ocorrências abaixo e acima da faixa adequada. Cada contribuição é dividida pelo número de amostras numéricas válidas da respectiva série e multiplicada por cem; a soma das contribuições de subtensão e sobretensão resulta no total do indicador para aquela fase. Na síntese de DRP e DRC, a fase de maior total é selecionada separadamente para cada indicador, mantendo suas próprias contribuições, sem combinar máximos de fases distintas. A Figura \ref{fig:cards-qee} apresenta os indicadores e os valores discriminados por fase.

\begin{figure}[H]
\centering
\includegraphics[width=0.95\linewidth,height=0.31\textheight,keepaspectratio]{master-reports/figures/tsdq/cards_2.png}
\caption{Cartões de qualidade energética com contribuições de DRP e DRC por fase.}
\label{fig:cards-qee}
\end{figure}

Por se basear na contagem de amostras, esse cálculo não pondera a duração dos intervalos entre registros. Sua interpretação depende, portanto, da cadência e do tratamento dos resultados exportados.

## Consulta independente e análise de comunicação

Além da consulta vinculada à topologia, a página Análise Elétrica oferece uma leitura independente por meio de *ler_dados*, do mapeamento de colunas e dos organizadores de variáveis. A seleção por tipo, elemento e variável permite apresentar gráficos individuais e multissérie, distribuições de tensão, tabelas e cartões de qualidade energética, sem exigir o vínculo JSON e CSV adotado no mapa. As Figuras \ref{fig:correntes-fases} e \ref{fig:histograma-tensao} ilustram, respectivamente, a consulta temporal das correntes de um ramo e a distribuição das tensões por fase.

\begin{figure}[H]
\centering
\includegraphics[width=0.9\linewidth,height=0.25\textheight,keepaspectratio]{master-reports/figures/tsdq/corrente.png}
\caption{Série temporal das correntes nas três fases de uma linha.}
\label{fig:correntes-fases}
\end{figure}

\begin{figure}[H]
\centering
\includegraphics[width=0.9\linewidth,height=0.32\textheight,keepaspectratio]{master-reports/figures/tsdq/histograma.png}
\caption{Distribuição das magnitudes de tensão por fase no barramento analisado.}
\label{fig:histograma-tensao}
\end{figure}

Os registros de comunicação possuem um fluxo próprio na página Comunicação. A leitura é realizada por *ler_resultados_comunicacao*, com validação dos campos esperados antes da seleção da origem. Em seguida, *expandir_mensagens* organiza os registros FIPA-ACL, e *calcular_kpis* utiliza os contadores e dados disponíveis para apresentar pacotes enviados, recebidos, descartados e em trânsito, além da taxa de descarte, latência e jitter. Tanto os gráficos quanto as tabelas se restringem aos registros carregados, sem inferir resultados de comunicação a partir das medições elétricas.

# Resultados e Discussão

A aplicação reúne a consulta topológica, elétrica e temporal em um ambiente no qual a seleção de um barramento permite examinar seus dados e os elementos a ele vinculados. A associação explícita dos equipamentos preserva a distinção entre tensão da barra, fluxo no ramo e potência do dispositivo. Com isso, o usuário pode verificar a coexistência de carga e geração, consultar as medições reconhecidas e identificar os motivos que impedem outras associações.

**Tabela — Recursos da ARGOS e condições de utilização.**

| Recurso | Condição e alcance |
|---|---|
| Mapa temporal | JSON compatível e CSV com vínculo SHA-256 correspondente. |
| Circuito ZIP | Topologia obtida da compilação OpenDSS. |
| Inspetor | Medições do instante e cadastro topológico apresentados separadamente. |
| DRP e DRC | Contagem de amostras válidas por fase, com contribuições de subtensão e sobretensão. |
| Análise tabular | CSV ou tabela HDF5 compatível, com colunas reconhecidas pelo mapeamento. |
| Comunicação | CSV com estrutura e registros compatíveis com o leitor de mensagens. |

Esses recursos atuam em etapas distintas da conferência dos resultados. A correspondência SHA-256 verifica a identidade do CSV declarado, mas não detecta erros de modelagem ou de significado das unidades. As validações estruturais rejeitam referências inválidas, os diagnósticos apontam problemas de associação e os gráficos permitem examinar o comportamento dos elementos. Tais verificações se complementam, sem dispensar a análise do cenário de origem.

O alcance da consulta permanece condicionado aos arquivos fornecidos: um equipamento cadastrado pode não possuir colunas de resultado, assim como uma coluna sem entidade cadastrada pode permanecer sem associação. A interpretação de *kv_base* e das unidades provisórias de potência depende do contrato do exportador, enquanto o volume do CSV e a preparação dos quadros temporais influenciam o consumo de memória e o tempo de carregamento. A interface não gera relatórios PDF automaticamente nem realiza análises específicas de armazenamento e perdas apenas pela presença desses elementos no cadastro.

As verificações por testes sintéticos documentam o comportamento das funções nos casos exercitados, mas não comprovam os resultados de uma co-simulação real. A avaliação de cada estudo requer, portanto, a conferência da topologia, das colunas, do período, das unidades e da convenção de sinais nos arquivos efetivamente utilizados.

# Conclusão

A ARGOS permite consultar resultados de co-simulação relacionando a topologia da rede, a identificação das medições e sua evolução temporal. Essa organização se apoia em uma estrutura modular que separa carregadores, modelo de grafo, mecanismos de associação e componentes de apresentação. O Mapa de Rede reúne a inspeção contextual e a análise elétrica, enquanto as páginas de análise tabular e comunicação atendem aos respectivos conjuntos de dados compatíveis.

As regras de vínculo e os diagnósticos delimitam quais dados podem ser associados à rede. Ao distinguir ausência de fase de tensão zero, presença de PV de potência medida e informação topológica de resultado temporal, a interface preserva o significado das grandezas durante a consulta. Seus indicadores e visualizações apoiam a análise técnica, sem transferir à aplicação a responsabilidade pela validação física do cenário ou pela homologação do estudo, que permanece com seus avaliadores.

# Referências

1. ARGOS. *Código-fonte da plataforma de visualização de resultados de co-simulação*. Repositório TSDQ DataView OpenTES. Disponível em: <https://github.com/betomsales/tsdq-dataview-opentes>. Consulta ao código local em: 27 out. 2026.

2. HAFEMEISTER, Augusto. *Interface de supervisão para uma plataforma experimental de pesquisa e ensino em energia solar fotovoltaica*. 2018. Dissertação (Mestrado em Engenharia Mecânica) -- Universidade do Vale do Rio dos Sinos, São Leopoldo, 2018.

3. OLIVEIRA, José Carlos Leal. *Desenvolvimento de interface gráfica para um simulador de comunidades de energia*. 2025. Dissertação (Mestrado em Engenharia Informática) -- Instituto Superior de Engenharia do Porto, Porto, 2025.

4. PROTO, Andréa Barboza. *Interface gráfica para o planejamento da expansão da transmissão de energia elétrica*. 2009. Dissertação (Mestrado em Engenharia Elétrica) -- Faculdade de Engenharia, Universidade Estadual Paulista, Ilha Solteira, 2009.
