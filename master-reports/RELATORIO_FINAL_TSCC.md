---
title: "Relatório Final de Projeto — TSCC"
subtitle: "Time de Simulação de Comunicação e Co-simulação"
author:
  - "Equipe TSCC"
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
    \lhead{OpenTES — TSCC}
    \rhead{\nouppercase{\leftmark}}
    \cfoot{\thepage}
pdf-engine: xelatex
---

> **Observação:** este é um relatório-base preenchido com conteúdo demonstrativo para o time **TSCC**. Ele foi escrito para servir simultaneamente como exemplo visual de documento final e como ponto de partida para a redação definitiva. Recomenda-se manter o documento em até **12 páginas**.

# Sumário Executivo

O time TSCC concentrou suas atividades na camada de comunicação e na integração entre simuladores da arquitetura OpenTES. Ao longo do projeto, o grupo buscou estruturar uma base de co-simulação capaz de representar com maior fidelidade os efeitos da rede de comunicação sobre sistemas multiagentes e sobre o comportamento dos módulos acoplados ao ambiente elétrico.

De forma geral, os esforços do time se distribuíram entre revisão bibliográfica, desenho de arquitetura, estabilização de interfaces e instrumentação de telemetria. O trabalho evidenciou que a modelagem da comunicação não pode ser tratada como detalhe periférico quando o objetivo é avaliar desempenho, confiabilidade e tempo de resposta de estratégias coordenadas entre agentes. Como resultado, consolidou-se uma linha de desenvolvimento que privilegia desacoplamento controlado, rastreabilidade de mensagens e capacidade de experimentação em cenários heterogêneos.

O principal valor deste relatório é oferecer uma visão integrada do que foi aprendido: quais hipóteses orientaram o desenvolvimento, quais ferramentas se mostraram mais adequadas, quais gargalos emergiram durante a integração e como os resultados podem ser aproveitados pelos demais times do projeto.

# Introdução

## Contextualização

Sistemas ciberfísicos no domínio energético dependem, cada vez mais, da troca coordenada de informações entre controladores, agentes, sensores e simuladores especializados. Em arquiteturas desse tipo, a comunicação deixa de ser apenas um canal de suporte e passa a influenciar diretamente a validade dos resultados. Atrasos, perdas, jitter e limitações de escalabilidade podem alterar significativamente a dinâmica global observada em experimentos de co-simulação.

No contexto do OpenTES, o TSCC foi responsável por estudar e estruturar a dimensão comunicacional da plataforma, articulando simuladores, mecanismos de mensageria e integrações necessárias para o funcionamento conjunto dos módulos. Essa frente é especialmente relevante porque a avaliação de estratégias distribuídas depende de uma camada de comunicação minimamente realista e auditável.

## Motivação

A motivação central do trabalho foi superar abordagens excessivamente idealizadas de troca de mensagens. Em cenários simplificados, agentes costumam se comunicar de forma instantânea e perfeita, o que inviabiliza a análise dos efeitos reais de infraestrutura, concorrência e degradação do canal. Para que a plataforma OpenTES sustente estudos mais robustos, tornou-se necessário avançar da integração funcional para a integração representativa do comportamento de rede.

Além disso, a equipe precisou lidar com o desafio prático de conectar ferramentas heterogêneas sem comprometer reprodutibilidade e manutenção. Dessa forma, a motivação do time combinou uma dimensão científica, ligada à fidelidade da modelagem, e uma dimensão de engenharia, ligada à estabilidade da solução implementada.

## Justificativa

Documentar formalmente o trabalho do TSCC é importante porque a camada de comunicação atua como elo entre diversas frentes do projeto. Uma decisão arquitetural tomada nesse nível pode facilitar ou dificultar a integração com simuladores físicos, a coleta de métricas, a automação de experimentos e o escalonamento de cenários com múltiplos agentes. O relatório final, portanto, serve como base para continuidade técnica e para alinhamento metodológico entre equipes.

## Objetivos

### Objetivo geral

Consolidar a arquitetura de comunicação e co-simulação do OpenTES, documentando suas bases conceituais, sua implementação e os resultados obtidos ao longo do desenvolvimento.

### Objetivos específicos

1. Investigar referências relevantes sobre co-simulação e comunicação em sistemas multiagentes.
2. Estruturar uma integração entre simuladores capaz de suportar cenários distribuídos.
3. Registrar mecanismos de telemetria e observabilidade para análise de mensagens.
4. Discutir gargalos, limitações e oportunidades de evolução da arquitetura proposta.

# Estado da Arte e Revisão Bibliográfica

A literatura sobre co-simulação em sistemas energéticos evidencia uma tensão recorrente entre fidelidade e complexidade. Soluções mais simples tendem a facilitar integração e execução, mas podem mascarar fenômenos importantes quando a comunicação afeta diretamente a coordenação entre agentes. Por outro lado, arquiteturas mais detalhadas aumentam custo de implementação e exigem maior cuidado com sincronização, serialização e gerenciamento de estados.

No caso do TSCC, a revisão bibliográfica foi útil para comparar frameworks de agentes, modelos de mensageria e abordagens de integração com simuladores de rede. O estudo também revelou que muitos trabalhos descrevem a arquitetura em alto nível, mas deixam pouco explícitos os detalhes necessários para reproduzir experimentos, como formatos de mensagem, estratégias de identificação de nós, instrumentação de latência e comportamento sob bursts.

Esse diagnóstico reforçou a importância de um desenvolvimento com foco em engenharia reprodutível. Em vez de tratar os detalhes de interoperabilidade como implementação secundária, o time precisou incorporá-los à própria metodologia de pesquisa.

\begin{figure}[H]
\centering
\fbox{\rule{0pt}{4.5cm}\rule{0.82\linewidth}{0pt}}
\caption{Exemplo de figura para o relatório final do TSCC. Em uma versão definitiva, esta área pode receber diagramas de troca de mensagens, topologias de rede, dashboards de telemetria ou fluxos de sincronização entre módulos.}
\end{figure}

| Referência ou eixo | Relevância para o TSCC | Uso no desenvolvimento |
|---|---|---|
| Co-simulação multidomínio | Fundamenta a integração entre camadas físicas e cibernéticas | Definição do acoplamento arquitetural |
| Sistemas multiagentes | Apoia decisões sobre protocolos e coordenação | Comparação entre frameworks e fluxos de mensagem |
| Simulação de comunicação | Permite avaliar latência, perda e concorrência | Interpretação de efeitos de rede no experimento |

Table: Exemplo de síntese de revisão bibliográfica focada nas decisões arquiteturais do TSCC.

# Materiais e Métodos

O desenvolvimento do TSCC foi conduzido de forma incremental, combinando estudo bibliográfico, análise da arquitetura existente, implementação de mecanismos de integração e validação em cenários progressivamente mais exigentes. Em termos metodológicos, a equipe trabalhou com ciclos curtos de ajuste, observação e refinamento, o que foi particularmente importante diante de problemas emergentes de sincronização e concorrência.

As ferramentas centrais incluíram repositórios versionados em Git, documentação em Markdown, organização de experimentos em ambiente conteinerizado e uso de componentes voltados à comunicação e à simulação distribuída. O papel de cada tecnologia foi registrado não apenas como dependência técnica, mas como parte da estratégia de garantir rastreabilidade e repetibilidade.

## Fluxo metodológico

1. Levantamento das necessidades de comunicação da co-simulação.
2. Revisão de literatura e estudo de alternativas tecnológicas.
3. Desenho de arquitetura para troca de mensagens entre módulos.
4. Implementação incremental com foco em escalabilidade e observabilidade.
5. Testes de integração, coleta de telemetria e análise de gargalos.
6. Consolidação do fluxo para uso pelos demais times.

## Exemplo de formalização

Uma forma simplificada de representar o custo operacional de comunicação em um cenário distribuído é dada por:

$$
C_{\text{rede}} = \sum_{i=1}^{N} \left( w_1 L_i + w_2 J_i + w_3 P_i \right)
$$

em que $L_i$ representa latência observada, $J_i$ representa jitter, $P_i$ representa perda associada a um conjunto de mensagens e $w_1$, $w_2$ e $w_3$ são pesos definidos conforme o objetivo experimental.

\begin{figure}[H]
\centering
\fbox{\rule{0pt}{4.3cm}\rule{0.84\linewidth}{0pt}}
\caption{Espaço reservado para um fluxograma de integração do TSCC. Esse tipo de quadro pode ser substituído por uma arquitetura com agentes, simuladores e canais de comunicação efetivamente utilizados no projeto.}
\end{figure}

# Resultados e Discussão

Os resultados do TSCC devem ser lidos em duas camadas complementares. A primeira camada é estrutural: a equipe avançou na organização de uma base de comunicação e co-simulação capaz de sustentar cenários menos idealizados e mais úteis para estudos posteriores. A segunda camada é analítica: o processo revelou que boa parte dos desafios não estava apenas na lógica dos agentes, mas no modo como mensagens, identificação de origem, buffers e concorrência eram tratados pela infraestrutura.

Do ponto de vista de engenharia, o principal ganho está na maior clareza sobre onde surgem gargalos e como eles afetam a observação do sistema como um todo. Do ponto de vista científico, o avanço mais importante é a possibilidade de discutir comportamento distribuído com maior lastro experimental, uma vez que a camada de comunicação passa a ser observada como variável de interesse e não como canal transparente.

| Indicador | Situação anterior | Situação consolidada | Discussão |
|---|---:|---:|---|
| Observabilidade de mensagens | Baixa | Média/alta | A telemetria passou a apoiar diagnóstico mais fino |
| Escalabilidade experimental | Restrita | Ampliada | A arquitetura ficou mais apta a cenários com múltiplos agentes |
| Reprodutibilidade de integrações | Parcial | Melhor estruturada | Menor dependência de ajustes manuais dispersos |
| Clareza sobre gargalos | Difusa | Objetiva | Problemas passaram a ser localizados com mais precisão |

Table: Exemplo de tabela para discussão final do TSCC, articulando ganhos estruturais e implicações para o restante do projeto.

Uma discussão importante para o relatório final é que os avanços do TSCC não devem ser avaliados apenas pelo número de funcionalidades implementadas, mas pela capacidade de o time transformar uma camada complexa e sensível em um componente mais compreensível e reutilizável. Isso tem efeito direto sobre os experimentos conduzidos por outros times, que passam a contar com uma base comunicacional mais explícita e passível de análise.

Ao mesmo tempo, permanecem limitações naturais desse tipo de desenvolvimento. Nem toda simplificação de infraestrutura pode ser removida de imediato, e algumas validações dependem de cenários maiores ou de integração mais madura com outras frentes. O relatório final deve registrar essas restrições sem reduzir o valor do que já foi consolidado.

# Conclusão

O trabalho do TSCC mostrou que a camada de comunicação precisa ser tratada como parte constitutiva do problema de pesquisa em arquiteturas ciberfísicas distribuídas. Ao longo do projeto, a equipe avançou na compreensão do estado da arte, no desenho de uma arquitetura mais consistente e na consolidação de mecanismos de integração e observabilidade úteis para o ecossistema OpenTES.

Os objetivos da introdução foram atendidos na medida em que o time estruturou uma base conceitual e técnica para discutir comunicação e co-simulação de forma mais rigorosa. O principal resultado não se resume a uma integração funcional, mas a uma plataforma mais preparada para investigação de latência, perda, escalabilidade e sincronização em cenários que envolvem agentes e simuladores heterogêneos.

Como continuidade, recomenda-se aprofundar a análise quantitativa dos efeitos de rede, expandir os cenários de teste, consolidar diagramas finais de arquitetura e fortalecer o acoplamento com os resultados dos demais times. Esses passos devem permitir que o TSCC transite de uma base consolidada de desenvolvimento para uma etapa mais madura de avaliação comparativa e produção científica.

# Referências

[1] PANDOC. *Pandoc User’s Guide*. Disponível em: <https://pandoc.org/>. Acesso em: 18 set. 2026.

[2] OPENTES. *Repositório geral do projeto*. Disponível em: <https://github.com/grei-ufc/general-opentes>. Acesso em: 18 set. 2026.

[3] Referências específicas de comunicação, co-simulação, OMNeT++, Mosaik e sistemas multiagentes devem ser listadas aqui na versão final do documento.
