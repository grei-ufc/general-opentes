---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-10-02)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-10-02**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Início da documentação da branch **`tscc-com-opentes/development`** com base no método **Diátaxis**.
- Pesquisa sobre a relação entre topologias de rede e tecnologias de transmissão, apoiada na documentação do OMNeT++, do INET e na literatura associada.

### 📈 Evidências / resultados

- A estrutura de documentação recomendada pelo Diátaxis foi estudada e replicada na branch.
- O ambiente permanece reportado como estável e totalmente integrado, combinando Python, C++, Docker, ZeroMQ, PADE, OMNeT++, Streamlit e os demais componentes da co-simulação.

### ⚠️ Dificuldades / bloqueios

- A documentação completa e os testes ainda estão em andamento.
- A pesquisa precisa aprofundar a relação entre topologias de rede e tecnologias de transmissão para orientar as próximas decisões técnicas.

### 🧩 Próximas ações para concluir

- Executar testes pendentes.
- Avançar na documentação Diátaxis.
- Prosseguir com a pesquisa no OMNeT++ e na literatura sobre topologias e tecnologias de transmissão.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Atualização da interface **ARGOS** para suportar o novo formato de topologia JSON, mantendo compatibilidade com o formato anterior.
- Atualização da verificação de vínculo **SHA-256** entre os arquivos JSON e CSV.
- Revisão da apresentação do artigo **CBA 2026**, incluindo arquitetura, resultados, conclusões e referências normativas.

### 📈 Resultados / entregas técnicas (destaques)

- O Mapa de Rede foi atualizado para novas estruturas de conexão, com preservação dos metadados dos nós e compatibilidade retroativa.
- A verificação SHA-256 foi adaptada ao novo fluxo de topologia.
- A apresentação foi revisada quanto à introdução, objetivo, arquitetura computacional, resultados e conclusões.
- Foram incluídos conteúdos sobre PRODIST Módulo 8, desagregação de indicadores e as normas EN 50160 e ANSI C84.1.
- Os slides receberam ajustes de formatação, referências e conferência visual.

### ⚠️ Dificuldades / bloqueios

- O mini relatório não registrou dificuldades técnicas ou bloqueios explícitos.

### 🧩 Próximas ações para concluir

- Dar continuidade ao desenvolvimento da interface ARGOS.
- Prosseguir com os ajustes da apresentação do artigo.

### 📅 Prazo

- **Não informado.**

---

## 3) 👨‍💻 Paulo Victor (TSRE / EVs)

### ✅ Tarefa principal

- Conclusão da integração do motor físico **Caldera ICM** para modelagem de veículos elétricos na co-simulação OpenDSS/Mosaik.
- Finalização do pipeline de dados, do wrapper Python/Mosaik e da integração com o motor C++ via pybind11.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual da etapa de EVs: **100%**; prazo de 30/09/2026 atendido.
- Foi gerado o banco mestre `ev_sessions_caldera.csv` por amostragem estocástica baseada no *market share* da ABVE e com restrição de compatibilidade entre capacidade de bateria e energia da sessão.
- Foram mapeados veículos e wallboxes reais, incluindo carregadores monofásicos de **7 kW / 32 A**, para representar cargas críticas em redes de baixa tensão.
- O wrapper `caldera_wrapper.py` conectou o Mosaik às estruturas do Caldera; a API C++ foi mapeada por engenharia reversa e registrada em `caldera_api_docs_full.txt`.
- A co-simulação passou a suportar injeção reativa dinâmica, com fator de potência estocástico entre **0,98 e 1,00**, e atualização direta de P e Q no OpenDSS.
- Foi corrigida a divergência matricial no passo inicial: a curva solar nativa passou a ser desvinculada no *bypass*, evitando a desconexão simultânea de inversores e a instabilidade que elevava as tensões a 14.000.000 V.

### ⚠️ Dificuldades / bloqueios

- A integração exigiu engenharia reversa da API pybind11 do Caldera devido à ausência de documentação adequada.
- A frota brasileira utiliza majoritariamente baterias LFP, enquanto o Caldera oferece NMC como aproximação eletroquímica disponível; a escolha foi registrada como *proxy* para preservar o comportamento de carregamento na tomada AC.
- Foi necessário isolar e corrigir um defeito crítico herdado na inicialização Mosaik/OpenDSS.

### 🧩 Próximas ações para concluir

- Consolidar e revisar o *merge request* da branch `feature/caldera-icm-integration`.
- Criar notebooks Jupyter para analisar perdas e estresse no transformador sob diferentes densidades de EVs.
- Correlacionar heatmaps da subestação ESB01S4 com os níveis de penetração da frota.

### 📅 Prazo

- Data de entrega pretendida: **30/09/2026** — **atendida**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Estruturaram a documentação da branch segundo Diátaxis e iniciaram a pesquisa que relaciona topologias e tecnologias de transmissão.
  - Os testes e a documentação detalhada ainda estão em andamento.
  - Progresso: **não informado**.

- **Luiz Alberto (TSDQ)**
  - Atualizou a ARGOS para o novo formato de topologia e revisou a apresentação do CBA 2026 com resultados e normas de qualidade de energia.
  - A continuidade da interface e da apresentação é o próximo foco.
  - Progresso: **não informado**.

- **Paulo Victor (TSRE / EVs)**
  - Concluiu a integração do Caldera ICM, oferecendo veículos, baterias, carregadores e injeção P/Q com maior fidelidade física na co-simulação.
  - A etapa seguinte é consolidar a integração e iniciar análises de perdas, estresse do transformador e penetração de EVs.
  - Progresso: **100%**; prazo de 30/09/2026 atendido.
