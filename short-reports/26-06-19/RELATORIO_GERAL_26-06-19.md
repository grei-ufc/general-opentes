---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-06-19)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-06-19**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Atuação em duas frentes complementares no repositório **`tscc-com-opentes`**:
  - Continuidade da implementação de **múltiplos nós com diferentes parâmetros de rede** no lado do simulador **OMNeT++**.
  - Início da redação do artigo científico sobre o arcabouço de co-simulação do OpenTES, com foco no **acoplamento dinâmico** entre **SMA**, **PADE**, **OMNeT++**, **Mosaik** e **ZeroMQ**.
  - Estruturação inicial do documento em **LaTeX**, incluindo o **Abstract** e a seção de **contextualização do projeto OpenTES**.

### 📈 Evidências / resultados

- Progresso percentual **não informado** no mini relatório.
- A base do artigo foi estruturada no template LaTeX.
- O **Abstract** foi redigido com ênfase na necessidade de sair de modelos ideais de comunicação para avaliar **latência dinâmica, perda de pacotes e jitter**.
- A seção de contextualização do OpenTES foi iniciada, organizando as quatro frentes principais do projeto.

### ⚠️ Dificuldades / bloqueios

- O mini relatório **não explicitou bloqueios técnicos específicos** nesta semana.
- Permanecem pendentes etapas relevantes de aprofundamento teórico e produção de material gráfico para consolidar o artigo.

### 🧩 Próximas ações para concluir

- Incluir a fundamentação teórica sobre o protocolo **FIPA** e a conteinerização via **Docker**.
- Criar **imagens** e **fluxogramas vetorizados** para o artigo.
- Avançar na redação para concluir o texto científico o mais rápido possível.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Desenvolvimento do módulo **Mapa de Rede** da plataforma **ARGOS**, para visualização topológica de redes elétricas modeladas em **OpenDSS**.
  - Estudo da arquitetura do **Mosaik WebVis**.
  - Implementação da leitura de arquivos **OpenDSS compactados (`.zip`)**.
  - Construção automática da topologia da rede.
  - Desenvolvimento de versões **simplificada** e **completa** da visualização com integração ao **Cytoscape/Streamlit**.

### 📈 Progresso reportado

- Progresso atual: **75%**.
- Foi implementada a primeira versão funcional do mapa de rede.
- O grafo elétrico passou a ser construído automaticamente a partir dos arquivos do circuito.
- Já há identificação e representação de barramentos e conexões, com base preparada para coloração dinâmica e animação temporal.

### ⚠️ Dificuldades / bloqueios

- Dificuldade na reconstrução correta das conexões entre elementos do **OpenDSS**.
- Inconsistências na identificação de terminais e barramentos durante o processamento dos arquivos.
- Problemas de renderização em redes maiores, devido ao volume de nós e arestas.
- Necessidade de adaptar conceitos do **Mosaik WebVis** para a arquitetura da plataforma **ARGOS**.

### 🧩 Próximas ações para concluir

- Finalizar a estabilização da geração automática da topologia.
- Implementar coloração dinâmica com base em grandezas elétricas.
- Integrar resultados temporais para atualização visual da topologia.
- Implementar persistência de estado, filtragem e navegação na rede.
- Integrar o módulo ao fluxo principal da plataforma ARGOS e ampliar os testes com alimentadores maiores.

### 📅 Prazo

- Data de entrega pretendida: **24/06/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Quantificação do impacto da **perda de pacotes** sobre o controle **Volt/Var distribuído** no cenário **IEEE 13 Bus** da co-simulação OpenTES.
  - Execução de uma **varredura de 0% a 100% de perda**, em passos de **5%**, com **20 sementes por nível**.
  - Análise estatística com média e desvio entre sementes.
  - Diagnóstico de um **artefato de inicialização (warm-up)** que contamina o início das rodadas.
  - Documentação técnica dos resultados e do experimento.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **50%**.
- Foram executadas **383 rodadas** do experimento, com saídas organizadas em `output/sensibilidade_perda_multiseed/`.
- A análise mostrou que o controle é **confiável apenas com 0% de perda**; a partir de **~5%**, o benefício médio torna-se praticamente nulo.
- Foi identificada **sobretensão noturna intermitente** em parte das sementes, associada ao uso de dados desatualizados na ação de controle.
- O artefato de warm-up foi localizado na camada de **orquestração Mosaik↔OpenDSS**, e não no modelo elétrico em si.

### ⚠️ Dificuldades / bloqueios

- Leituras com poucas sementes levavam a interpretações estatísticas frágeis do efeito da perda.
- O principal bloqueio atual é o **artefato de inicialização**, que mantém a rede "congelada" nas primeiras horas de simulação e distorce as métricas.
- A correção desse warm-up ainda não foi implementada.

### 🧩 Próximas ações para concluir

- Instrumentar o método `step` do simulador de grid para localizar a linha exata do warm-up.
- Descartar ou pré-aquecer as horas iniciais nas métricas e figuras, reprocessando o experimento.
- Revisar a métrica de benefício do controle para medir melhor o impacto da degradação da comunicação.

### 📅 Prazo

- Correção do artefato e reprocessamento das métricas: **próxima semana**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Avançaram na frente de **escrita científica** do OpenTES, estruturando o artigo em **LaTeX** e redigindo o **Abstract** e a contextualização do projeto.
  - Em paralelo, mantiveram a evolução da implementação de **múltiplos nós com diferentes parâmetros de rede** no **OMNeT++**.
  - Progresso: **não informado**.

- **Luiz Alberto (TSDQ)**
  - Entregou a primeira versão funcional do **Mapa de Rede** da plataforma **ARGOS**, com geração automática de topologia e visualização simplificada/completa.
  - Os principais desafios seguem na reconstrução correta das conexões, na renderização de redes maiores e na integração temporal da visualização.
  - Prazo: **24/06/2026** — progresso em **75%**.

- **Douglas Barros (TTESO/PADE)**
  - Produziu uma análise estatisticamente robusta da sensibilidade do controle **Volt/Var** à perda de pacotes, mostrando que o benefício prático desaparece já com pequenas perdas.
  - O principal ponto em aberto é a correção do **artefato de warm-up** na orquestração **Mosaik↔OpenDSS**, necessária para consolidar as métricas.
  - Prazo: **próxima semana** — progresso geral **50%**.
