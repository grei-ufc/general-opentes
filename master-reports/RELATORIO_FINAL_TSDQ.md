---
title: "Relatório Final de Projeto — TSDQ"
subtitle: "Time de Visualização de Dados e Qualidade de Energia Elétrica"
author:
  - "Equipe TSDQ"
  - "OpenTES"
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
    \lhead{OpenTES — TSDQ}
    \rhead{\nouppercase{\leftmark}}
    \cfoot{\thepage}
pdf-engine: xelatex
---

> **Observação:** este relatório foi preenchido com conteúdo ilustrativo para o time **TSDQ** e serve como base de escrita e como mockup renderizável em PDF. O documento final deve permanecer com **até 12 páginas**.

# Sumário Executivo

O time TSDQ dedicou-se à visualização de dados e à análise de qualidade de energia no contexto do OpenTES, com ênfase na transformação de saídas técnicas de simulação em artefatos interpretáveis, comparáveis e úteis para tomada de decisão. Em projetos multidisciplinares, essa frente tem papel estratégico porque conecta o resultado bruto dos simuladores às necessidades de validação, inspeção e comunicação dos achados.

Ao longo do desenvolvimento, a equipe trabalhou na estruturação de fluxos de ingestão, associação, filtragem e exibição de informações. O esforço foi direcionado para permitir que diferentes formas de dado — topologia, séries temporais, medições elétricas e metadados de variáveis — fossem articuladas em uma interface coerente. O trabalho também evidenciou a importância de preservar rastreabilidade e contexto das medições, evitando que a interface reduza a complexidade do sistema a uma visualização superficial.

Este relatório sintetiza a contribuição do TSDQ sob três perspectivas: organização de dados, desenho de mecanismos de visualização e discussão do valor analítico das representações produzidas.

# Introdução

## Contextualização

Em projetos de co-simulação, a geração de dados costuma crescer em volume e heterogeneidade à medida que novas frentes são integradas. Sem ferramentas adequadas de visualização e inspeção, grande parte desse valor analítico se perde. Interfaces bem projetadas não servem apenas para “mostrar resultados”; elas sustentam interpretação técnica, apoiam detecção de inconsistências e tornam o ciclo experimental mais eficiente.

No OpenTES, o TSDQ ocupa exatamente essa posição intermediária entre dados produzidos por simuladores e entendimento operacional do sistema. Isso envolve desde a preparação de entradas e a modelagem de estruturas visuais até a definição de critérios de destaque, filtros, inspeção contextual e análise temporal.

## Motivação

A motivação principal da equipe foi desenvolver meios mais claros de representar o comportamento da rede e de seus elementos ao longo do tempo. Em vez de trabalhar com tabelas dispersas e saídas pouco intuitivas, buscou-se evoluir para um ambiente visual que preserve a riqueza do dado, mas reduza o esforço cognitivo necessário para interpretá-lo.

Há também uma motivação metodológica importante: quando os resultados são mais legíveis, o processo de validação entre equipes melhora. A visualização deixa de ser etapa final de apresentação e passa a integrar a própria construção do conhecimento no projeto.

## Justificativa

O relatório final do TSDQ é justificado pela necessidade de registrar não apenas o que foi implementado, mas como a equipe transformou necessidades analíticas em soluções de interface e estruturação de dados. Esse tipo de documentação é valioso porque visualizações úteis raramente emergem de decisões triviais; elas dependem de critérios de modelagem, priorização e interpretação que precisam ser explicitados.

## Objetivos

### Objetivo geral

Documentar o desenvolvimento de soluções de visualização e análise de qualidade de energia que apoiem a interpretação dos dados produzidos no ecossistema OpenTES.

### Objetivos específicos

1. Estruturar formas de integração entre topologia, medições e séries temporais.
2. Organizar critérios visuais para destacar estados e comportamentos relevantes.
3. Facilitar análise exploratória e inspeção detalhada dos resultados.
4. Discutir ganhos e limitações das representações adotadas.

# Estado da Arte e Revisão Bibliográfica

A literatura de visualização aplicada a sistemas energéticos mostra que não basta representar a rede graficamente; é necessário permitir leitura contextual de estado, evolução temporal e qualidade das medições. Trabalhos da área frequentemente enfatizam dashboards, mapas de rede, classificação por faixas operacionais, sobreposição de variáveis e mecanismos de navegação temporal.

Para o TSDQ, a revisão bibliográfica cumpre um papel de referência conceitual para decisões de interface. Ela ajuda a responder perguntas como: quais grandezas devem ser priorizadas na visualização, como representar incerteza ou ausência de dados, como equilibrar visão geral e detalhe local e como evitar sobrecarga visual em redes maiores.

Outro aprendizado importante da revisão é que visualização técnica eficaz depende tanto de princípios de design da informação quanto de fidelidade ao domínio. Uma boa interface não “enfeita” o dado; ela o organiza de forma a manter seu significado operacional.

\begin{figure}[H]
\centering
\fbox{\rule{0pt}{4.5cm}\rule{0.82\linewidth}{0pt}}
\caption{Exemplo de figura para o relatório final do TSDQ. Em versões futuras, podem ser inseridos mapas de rede, screenshots da interface, gráficos comparativos ou diagramas do pipeline de ingestão e visualização.}
\end{figure}

| Tema de revisão | Questão orientadora | Relação com o trabalho |
|---|---|---|
| Visualização temporal | Como mostrar evolução sem comprometer legibilidade? | Base para controles de navegação temporal |
| Topologias elétricas | Como associar nós, linhas e medições? | Estruturação do mapa de rede |
| Qualidade de energia | Quais indicadores merecem destaque visual? | Definição de classificações e alertas |

Table: Exemplo de tabela que articula a revisão bibliográfica com as decisões concretas de projeto do TSDQ.

# Materiais e Métodos

O método de trabalho do TSDQ combinou organização de dados, desenho de interface, testes iterativos e ajustes orientados por casos de uso. A equipe precisou tratar simultaneamente problemas de compatibilidade entre formatos, associação entre variáveis e elementos da rede, navegação temporal e preservação de metadados relevantes à análise.

Em termos práticos, a metodologia foi guiada por um princípio de rastreabilidade: cada elemento visual deveria estar ligado a dados identificáveis, passíveis de inspeção e contextualizados dentro da topologia ou do processo de simulação. Esse princípio reduz o risco de produzir interfaces visualmente atraentes, porém pouco confiáveis para análise técnica.

## Etapas metodológicas

1. Levantamento dos tipos de dado a serem integrados.
2. Definição de estruturas intermediárias para representação de topologia e medições.
3. Implementação de mecanismos de associação automática e inspeção contextual.
4. Desenvolvimento de recursos de navegação temporal e filtragem.
5. Avaliação da legibilidade, cobertura e coerência analítica da interface.

## Exemplo de formalização

Uma métrica simples para expressar cobertura de associação entre dados e elementos visuais pode ser escrita como:

$$
\text{Cobertura} = \frac{N_{\text{medições associadas}}}{N_{\text{medições totais}}} \times 100
$$

Essa métrica é útil para discutir maturidade do pipeline de visualização, pois mostra quanto do dado disponível está efetivamente representado na interface.

\begin{figure}[H]
\centering
\fbox{\rule{0pt}{4.2cm}\rule{0.84\linewidth}{0pt}}
\caption{Espaço reservado para um diagrama do pipeline de ingestão de dados do TSDQ, incluindo importação, associação, transformação e renderização visual.}
\end{figure}

# Resultados e Discussão

Os resultados do TSDQ podem ser avaliados pela capacidade de converter estruturas complexas de saída em instrumentos reais de análise. O ganho mais importante não reside apenas em “mostrar a rede”, mas em criar uma interface capaz de conectar topologia, séries temporais, estados operacionais e detalhes contextuais das medições em uma visão coerente.

Essa integração tem implicações práticas relevantes. Quando a interface revela cobertura de associação, destaca estados precários ou críticos e permite inspeção detalhada de nós e linhas, ela passa a atuar como ferramenta de validação técnica e não apenas como recurso expositivo. Isso é especialmente importante em um projeto com forte acoplamento entre geração de dados e interpretação interdisciplinar.

| Indicador | Situação inicial | Situação consolidada | Discussão |
|---|---:|---:|---|
| Integração entre topologia e medições | Baixa | Alta | A visualização ficou mais fiel ao comportamento do sistema |
| Rastreabilidade dos dados | Parcial | Ampliada | Metadados preservados melhoram auditoria e inspeção |
| Capacidade de análise temporal | Limitada | Funcional | O usuário consegue acompanhar evolução de estados |
| Suporte à validação | Restrito | Relevante | A interface passou a apoiar diagnóstico técnico |

Table: Exemplo de quadro para discussão final dos resultados do TSDQ.

A principal discussão conceitual desta seção é que uma boa visualização técnica não é neutra: ela seleciona, organiza e hierarquiza informação. Por isso, o relatório deve justificar por que certas variáveis receberam destaque, como foram definidas classificações visuais e de que maneira o desenho da interface evita ambiguidade ou perda de contexto.

Também é importante registrar limitações. Redes maiores podem exigir otimizações adicionais; nem toda medição se associa automaticamente à topologia; e certos indicadores podem demandar tratamento estatístico prévio antes de serem incorporados a uma interface final. Esses pontos não reduzem a utilidade do trabalho, mas delimitam seu estágio de maturidade.

# Conclusão

O TSDQ contribuiu para transformar dados de simulação em artefatos analíticos mais acessíveis e úteis, fortalecendo a etapa de interpretação dentro do OpenTES. O trabalho mostrou que visualização, quando tratada com rigor metodológico, é parte integrante da pesquisa e da validação técnica, e não apenas um acabamento posterior.

Os objetivos propostos foram alcançados ao se estruturar uma lógica de integração entre topologia, medições e análise temporal, acompanhada de mecanismos de inspeção e classificação visual. O principal ganho foi ampliar a capacidade de leitura operacional e comparativa dos resultados, apoiando tanto a própria equipe quanto as demais frentes do projeto.

Como continuidade, recomenda-se expandir a cobertura automática das associações, incorporar novos indicadores de qualidade de energia, otimizar o desempenho para redes de maior porte e refinar a interface com base em casos reais de uso. Esses passos podem consolidar o TSDQ como uma camada essencial de interpretação, depuração e comunicação científica do OpenTES.

# Referências

[1] PANDOC. *Pandoc User’s Guide*. Disponível em: <https://pandoc.org/>. Acesso em: 18 set. 2026.

[2] OPENTES. *Repositório geral do projeto*. Disponível em: <https://github.com/grei-ufc/general-opentes>. Acesso em: 18 set. 2026.

[3] Referências específicas sobre visualização de redes elétricas, análise temporal, dashboards técnicos e qualidade de energia devem ser incluídas na versão final.
