---
title: "Template de Relatório Final de Projeto — [SIGLA DO TIME]"
subtitle: "OpenTES — Modelo em Markdown para conversão em PDF"
author:
  - "Nome do(a) pesquisador(a) responsável"
  - "Demais integrantes do time"
date: "2026-09-18"
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
    \lhead{OpenTES}
    \rhead{\nouppercase{\leftmark}}
    \cfoot{\thepage}
pdf-engine: xelatex
---

> **Instrução de uso:** este arquivo serve como modelo-base para os relatórios finais em `master-reports/`. O texto abaixo foi propositalmente preenchido com conteúdo demonstrativo para que o documento possa ser convertido em PDF e para que os pesquisadores visualizem com clareza a diagramação final. Ao reutilizar este template, substitua os trechos exemplificativos pelas informações reais do projeto, preservando a estrutura geral.

> **Limite recomendado:** o relatório final deve ter **no máximo 12 páginas**, incluindo figuras, tabelas e referências. Esse limite exige objetividade, foco analítico e seleção criteriosa dos resultados mais relevantes.

# Sumário Executivo

Este relatório final sintetiza a trajetória de desenvolvimento de um subprojeto do OpenTES, destacando motivação, metodologia, resultados e perspectivas de continuidade. O objetivo de um sumário executivo é permitir que um leitor não técnico compreenda, em poucos minutos, o problema abordado, as principais decisões tomadas ao longo do trabalho, os artefatos produzidos e o impacto alcançado.

Em uma versão definitiva, esta seção deve responder de forma direta às seguintes perguntas: qual problema foi tratado, por que o problema é importante, como a equipe trabalhou, o que foi entregue e quais são os próximos passos. Recomenda-se que o texto mantenha linguagem objetiva, com parágrafos curtos e ênfase em evidências concretas, como protótipos implementados, experimentos realizados, integrações concluídas, dados analisados e limitações identificadas.

Como referência de estilo, um bom sumário executivo também explicita o estágio de maturidade do trabalho. Em vez de afirmar genericamente que houve “avanços significativos”, é preferível indicar que a equipe consolidou uma arquitetura, validou um fluxo de execução, obteve resultados quantitativos reproduzíveis ou identificou bloqueios que direcionam a etapa seguinte. Esse tipo de precisão aumenta a utilidade do relatório tanto para orientação acadêmica quanto para registro institucional.

# Introdução

## Contextualização

O projeto OpenTES articula diferentes frentes técnicas relacionadas à co-simulação de sistemas elétricos, comunicação, controle, otimização e análise de dados. Em um ecossistema com múltiplos simuladores e componentes especializados, a produção de um relatório final torna-se importante para documentar de forma estruturada a evolução do trabalho, as escolhas de modelagem, os resultados alcançados e as lacunas que permanecem abertas.

Em relatórios acadêmico-técnicos, a contextualização deve situar o leitor no domínio do problema. É importante apresentar o tema de forma suficientemente ampla para justificar sua relevância, mas também delimitada para mostrar qual recorte específico foi abordado pela equipe. No caso do OpenTES, isso pode envolver desde a necessidade de integrar simuladores heterogêneos até a análise de desempenho de algoritmos, interfaces, modelos físicos ou mecanismos de comunicação.

## Motivação

A motivação desta estrutura de relatório é oferecer um formato consistente, reutilizável e de fácil conversão para PDF, permitindo que diferentes equipes documentem seus resultados de maneira comparável. Quando os relatórios seguem um mesmo padrão, torna-se mais simples avaliar convergências entre frentes, identificar dependências técnicas, comparar metodologias e consolidar resultados em documentos institucionais mais amplos.

Além disso, o uso de Markdown com Pandoc reduz atrito de edição, favorece versionamento em Git e permite que pesquisadores com perfis distintos colaborem no mesmo documento sem depender de ferramentas proprietárias. O formato também facilita a inserção controlada de figuras, tabelas, equações e listas, mantendo qualidade tipográfica adequada para apresentações formais.

## Justificativa

Um relatório final bem estruturado não serve apenas como entrega documental. Ele funciona como memória técnica do projeto, reduz retrabalho futuro e apoia decisões sobre continuidade da pesquisa. Ao registrar hipóteses, ferramentas, parâmetros adotados, dificuldades enfrentadas e interpretações dos resultados, o documento passa a ser útil tanto para a equipe atual quanto para novos integrantes que venham a dar sequência ao trabalho.

Também é recomendável explicitar aqui por que o recorte do time foi relevante dentro do conjunto maior do projeto. Em relatórios reais, essa seção pode justificar o desenvolvimento de uma integração específica, a avaliação de determinado algoritmo, a adoção de certa infraestrutura computacional ou a necessidade de analisar um fenômeno ainda pouco explorado na literatura.

## Objetivos

### Objetivo geral

Apresentar, discutir e documentar de forma clara os resultados finais de um subprojeto técnico-científico desenvolvido no contexto do OpenTES.

### Objetivos específicos

1. Contextualizar o problema tratado e sua relevância para o projeto.
2. Descrever o estado da arte e as principais referências adotadas.
3. Documentar materiais, ferramentas e métodos utilizados pela equipe.
4. Apresentar resultados de desenvolvimento, testes e análises.
5. Consolidar conclusões e indicar caminhos para continuidade do trabalho.

# Estado da Arte e Revisão Bibliográfica

O estado da arte deve ir além de uma simples lista de referências. A função desta seção é demonstrar que a equipe compreendeu o cenário técnico e científico em que o trabalho se insere, identificando soluções existentes, limitações conhecidas e oportunidades de contribuição. Em termos práticos, isso significa comparar abordagens, explicitar diferenças arquiteturais, registrar pressupostos metodológicos e apontar o que cada referência acrescentou ao desenvolvimento realizado.

Em um texto final, recomenda-se organizar a revisão por eixos temáticos, e não apenas cronologicamente. Por exemplo, um relatório do OpenTES pode dividir a literatura entre: co-simulação multidomínio, modelagem de comunicação, controle de recursos energéticos distribuídos, visualização interativa de resultados, ou modelos de mercado e otimização distribuída. Essa organização ajuda a conectar a revisão bibliográfica às escolhas descritas nas seções seguintes.

Um parágrafo de revisão bem escrito costuma ter três movimentos: apresentar uma referência ou grupo de referências, explicar a contribuição principal de cada uma e posicionar o trabalho do projeto em relação a elas. Esse posicionamento é central, pois mostra se o trabalho reproduz, adapta, amplia ou contrasta com a literatura existente.

## Exemplo de síntese bibliográfica

Uma estratégia de revisão pode comparar soluções que priorizam fidelidade de simulação com outras que priorizam flexibilidade de integração. Em arquiteturas de co-simulação, por exemplo, alguns trabalhos favorecem acoplamentos fortemente sincronizados, enquanto outros aceitam maior desacoplamento em troca de escalabilidade e facilidade de composição. Essa distinção impacta diretamente o desenho de interfaces, a coleta de telemetria e a interpretação dos resultados.

Outro ponto importante é reconhecer que nem sempre a literatura descreve com profundidade os detalhes de engenharia necessários para reproduzir um sistema real. Por isso, relatórios finais devem registrar as adaptações efetivamente implementadas no projeto, inclusive quando elas dizem respeito a scripts, serialização de dados, formatação de entradas, gestão de dependências, automação de experimentos ou integração entre módulos.

## Exemplo de figura

\begin{figure}[H]
\centering
\fbox{\rule{0pt}{4.8cm}\rule{0.80\linewidth}{0pt}}
\caption{Exemplo de inserção de figura com legenda. Em relatórios reais, esse espaço pode ser substituído por diagramas de arquitetura, fluxos de execução, capturas de interface ou gráficos de resultados, sempre acompanhados de descrição interpretativa no texto.}
\end{figure}

Exemplo de sintaxe para inserir uma imagem real em Markdown/Pandoc:

```md
![Legenda da figura](caminho/da/imagem.png){ width=70% }
```

## Exemplo de tabela

| Eixo analisado | Exemplo de pergunta de revisão | Contribuição esperada para o relatório |
|---|---|---|
| Integração de simuladores | Como os componentes trocam dados e sincronizam tempo? | Justificar escolhas de acoplamento e interoperabilidade |
| Modelagem do domínio | Quais hipóteses físicas, econômicas ou computacionais foram adotadas? | Delimitar o escopo e as restrições do trabalho |
| Avaliação experimental | Como os resultados foram medidos e comparados? | Sustentar a discussão de desempenho e validade |

Table: Exemplo de tabela comparativa que pode ser adaptada para revisão bibliográfica, planejamento experimental ou síntese de resultados.

# Materiais e Métodos

Esta seção deve documentar como o trabalho foi realizado de modo que outro pesquisador consiga compreender, reproduzir ou estender a solução desenvolvida. Em um relatório final, é desejável que a descrição metodológica contenha o encadeamento lógico das atividades, os artefatos utilizados, as ferramentas adotadas, os dados manipulados, os parâmetros relevantes e os critérios de avaliação empregados.

Uma boa prática é estruturar a metodologia em subseções, diferenciando ambiente computacional, fluxo de desenvolvimento, preparação de dados, estratégias de validação e métricas de análise. Isso evita que a seção se transforme em um inventário desorganizado de ferramentas e ajuda o leitor a entender por que cada componente foi necessário.

## Ambiente e ferramentas

Como exemplo, um relatório pode descrever o uso combinado de repositório Git para versionamento, Markdown para documentação técnica, Pandoc para geração de PDFs, Python ou C++ para desenvolvimento principal, além de simuladores e bibliotecas específicas do domínio. O importante é não apenas listar as ferramentas, mas explicitar o papel de cada uma no fluxo do trabalho.

## Metodologia de desenvolvimento

O desenvolvimento pode ser descrito como um ciclo iterativo composto por levantamento de requisitos, estudo de soluções existentes, prototipagem, testes incrementais, consolidação de resultados e documentação final. Quando o projeto envolve integração entre múltiplos módulos, também vale detalhar como foram conduzidas as interfaces entre equipes, a definição de formatos de entrada e saída e a validação de compatibilidade entre componentes.

Outro aspecto relevante é o registro das decisões técnicas. Se uma estratégia foi descartada, essa informação pode ser mencionada de forma breve, especialmente quando ajuda a compreender por que a solução final assumiu determinado formato. Em pesquisas aplicadas, esse tipo de rastreabilidade é valioso.

## Exemplo de equação

Em muitos relatórios, a formalização matemática ajuda a apresentar métricas, critérios de comparação ou funções-objetivo. A seguir, apresenta-se um exemplo de equação que pode ser adaptado ao contexto do trabalho:

$$
J = \sum_{t=1}^{T} \left( \alpha \, \Delta V_t^2 + \beta \, P_{\text{perda},t} + \gamma \, C_t \right)
$$

Nessa expressão, $J$ representa uma função agregada de avaliação; $\Delta V_t$ pode representar desvio de tensão em um instante $t$; $P_{\text{perda},t}$, perdas elétricas; e $C_t$, algum custo computacional, econômico ou operacional. O propósito aqui é ilustrar a inserção de equações centralizadas com notação compatível com LaTeX.

## Exemplo de fluxograma ou elemento gráfico sem arquivo externo

\begin{figure}[H]
\centering
\fbox{\rule{0pt}{4.5cm}\rule{0.82\linewidth}{0pt}}
\caption{Área reservada para fluxograma, diagrama conceitual ou composição visual produzida posteriormente. Esse recurso é útil quando a equipe ainda não finalizou a arte, mas deseja testar o espaçamento e o impacto visual do elemento na paginação.}
\end{figure}

## Exemplo de lista metodológica

1. Definição do problema e do escopo da equipe.
2. Levantamento bibliográfico e análise de soluções correlatas.
3. Escolha das ferramentas e preparação do ambiente computacional.
4. Implementação incremental com validações parciais.
5. Consolidação dos experimentos e interpretação dos resultados.
6. Produção da documentação final e registro das limitações.

# Resultados e Discussão

Esta seção concentra o núcleo analítico do relatório final. Não basta apresentar imagens, números ou capturas de tela: é preciso discutir o significado dos resultados, relacionando-os aos objetivos da introdução e às referências apresentadas anteriormente. Sempre que possível, a discussão deve diferenciar o que foi efetivamente comprovado, o que foi observado empiricamente sem ampla generalização e o que permaneceu como hipótese para trabalho futuro.

Em documentos do OpenTES, os resultados podem assumir naturezas diversas: desempenho de integração entre módulos, estabilidade de uma arquitetura de co-simulação, qualidade de visualização de dados, aderência de uma interface às necessidades de análise, impacto de estratégias de controle, sensibilidade a parâmetros de comunicação, ou adequação de modelos de otimização. A seção deve ser flexível o suficiente para acomodar essas diferenças, mas disciplinada na interpretação.

## Exemplo de discussão qualitativa

Suponha que o trabalho tenha produzido uma nova versão de um fluxo de análise ou integração. Uma discussão adequada destacaria não apenas que o sistema “funcionou”, mas em que condições funcionou, quais limitações foram observadas, como a solução se compara ao ponto de partida e quais implicações práticas isso tem para o restante do projeto. A interpretação crítica é o elemento que transforma uma demonstração técnica em resultado acadêmico útil.

## Exemplo de tabela de resultados

| Indicador | Situação inicial | Situação final | Interpretação |
|---|---:|---:|---|
| Tempo médio de execução | 18,4 min | 11,2 min | Redução relevante de custo operacional |
| Etapas manuais do fluxo | 7 | 3 | Processo mais reproduzível e menos sujeito a erro |
| Cobertura funcional do protótipo | 55% | 88% | A solução amadureceu, mas ainda há lacunas pontuais |
| Itens documentados | 4 | 14 | Melhor rastreabilidade técnica e onboarding mais simples |

Table: Exemplo de apresentação tabular de resultados consolidados, útil para comparações “antes vs. depois”, versões de algoritmos ou cenários experimentais.

## Exemplo de interpretação orientada por evidências

Os resultados exemplificados acima sugerem que a principal contribuição do trabalho não estaria apenas em acelerar o fluxo, mas em torná-lo mais consistente, legível e fácil de manter. Em muitos projetos de pesquisa aplicada, essa dimensão de engenharia tem impacto direto na capacidade de reproduzir experimentos e de escalar a solução para novos casos de uso. Assim, a discussão deve valorizar tanto os ganhos quantitativos quanto os ganhos estruturais.

Também é recomendável apontar limitações explicitamente. Se determinada funcionalidade ainda depende de ajustes manuais, se a base de testes foi pequena, se alguns cenários não foram explorados, ou se a integração só foi validada em condições controladas, isso deve ser registrado com transparência. Relatórios finais fortes não escondem restrições; eles as delimitam.

## Exemplo de citação textual manual

Ao longo da discussão, é comum retomar referências importantes. Quando não se utiliza um arquivo bibliográfico automatizado, pode-se empregar uma forma simples de citação textual, por exemplo: “conforme discutido por Smith e Brown (2023), a integração entre simuladores tende a expor gargalos de sincronização temporal em cenários heterogêneos”. Em seguida, a referência completa é listada ao final do documento.

# Conclusão

O fechamento do relatório deve retomar os objetivos apresentados na introdução e indicar claramente em que medida eles foram alcançados. Recomenda-se evitar conclusões genéricas. Em vez disso, a seção deve sintetizar as entregas mais relevantes, destacar o principal aprendizado técnico-científico e apontar como o trabalho pode ser continuado com base no estado atual dos artefatos produzidos.

Em um relatório final do OpenTES, uma boa conclusão costuma combinar três dimensões. A primeira é a dimensão de resultado, isto é, o que foi implementado, analisado ou consolidado. A segunda é a dimensão de significado, explicitando por que isso importa para o projeto. A terceira é a dimensão de continuidade, apontando quais extensões, validações adicionais ou integrações futuras são mais promissoras.

Como orientação prática, esta seção pode encerrar com um parágrafo breve sobre continuidade do trabalho, mencionando oportunidades de generalização, integração com outros times, novos experimentos, refinamentos metodológicos ou produção científica derivada. Isso ajuda a transformar o relatório em ponte para o próximo ciclo de pesquisa.

## Encaminhamentos sugeridos

1. Consolidar os artefatos finais em repositórios e pastas estáveis.
2. Revisar nomenclaturas, parâmetros e dependências para facilitar reprodução.
3. Selecionar os resultados mais fortes para publicação, demonstração ou defesa.
4. Registrar limitações e hipóteses abertas que devam orientar o próximo ciclo.

# Referências

[1] SMITH, J.; BROWN, A. *Integrated Co-Simulation Architectures for Cyber-Physical Energy Systems*. Journal of Smart Systems, v. 12, n. 3, p. 45-68, 2023.

[2] DOE, M.; LI, P. *Reproducible Research Workflows with Markdown and Pandoc*. Computing Practice Review, v. 8, n. 1, p. 10-24, 2022.

[3] SILVA, R.; SOUZA, T. *Engineering Documentation in Multidisciplinary Research Projects*. Technical Communication Series, v. 5, n. 2, p. 77-91, 2024.

[4] PANDOC. *Pandoc User’s Guide*. Disponível em: <https://pandoc.org/>. Acesso em: 18 set. 2026.

[5] OPENTES. *Repositório geral do projeto*. Disponível em: <https://github.com/grei-ufc/general-opentes>. Acesso em: 18 set. 2026.
