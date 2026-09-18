---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-09-18)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-09-18**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Continuidade do aprimoramento do script **`menu_streamlit.py`**, com foco em flexibilidade de configuração e robustez da interface durante a execução da co-simulação.
  - Implementação da **atribuição manual de tecnologia por agente**, sem perder o comportamento cíclico automático como padrão.
  - Correção do **gerenciamento do terminal dentro da interface**, permitindo abrir ou fechar o painel sem interromper a co-simulação em andamento.

### 📈 Evidências / resultados

- Progresso percentual **não informado** no mini relatório.
- A interface passou a permitir **caracterização individual dos agentes**.
- O terminal tornou-se **compactável/ocultável** sem afetar a execução em tempo real.
- O conjunto de melhorias amplia a flexibilidade de uso da interface e melhora a experiência durante o acompanhamento da co-simulação.

### ⚠️ Dificuldades / bloqueios

- O mini relatório não detalhou bloqueios técnicos específicos da semana.
- A etapa de **testes** segue em andamento (**WIP**).
- Também foi apontada a necessidade de **realocar/distribuir melhor os gráficos** após o final da co-simulação.

### 🧩 Próximas ações para concluir

- Realizar os testes das novas funcionalidades da interface.
- Incorporar as atualizações e gráficos ao **artigo**.
- Reorganizar a distribuição dos resultados gráficos após a execução da co-simulação.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Estudo e planejamento da implementação de **geração de relatórios** na interface da plataforma **ARGOS/OpenTES**.
  - Leitura e análise da dissertação **"Interface Gráfica para o Planejamento da Expansão da Transmissão de Energia Elétrica"** como referência conceitual.
  - Avaliação de alternativas de exportação para **HTML, PDF, DOCX e Markdown**.
  - Estudo de bibliotecas e abordagens para geração de PDF, como **ReportLab**, **WeasyPrint**, **fpdf2** e **Playwright/Chromium**.
  - Definição preliminar de uma arquitetura baseada em **dados reais → template → relatório → exportação**.
  - Levantamento dos elementos que o relatório deve conter, com ênfase em rastreabilidade e no uso exclusivo dos dados presentes nos arquivos de entrada.

### 📈 Progresso reportado

- Progresso atual: **70%**.
- Foi estabelecida uma **base conceitual** para a futura implementação do gerador de relatórios.
- O formato **HTML** foi identificado como caminho promissor para integração direta com a interface.
- O relatório passou a ter uma **estrutura preliminar definida**, incluindo arquivos de entrada, resumo da rede, nós monitorados, séries temporais, linhas, elementos fotovoltaicos, alertas e medições não associadas.
- Também foi estabelecido o princípio de registrar **"informação não disponível nos arquivos de entrada"** em vez de estimar ou interpolar valores ausentes.

### ⚠️ Dificuldades / bloqueios

- Ainda é necessário definir qual **formato de saída** oferece melhor integração com os componentes atuais da plataforma.
- Preservar gráficos, tabelas e demais informações visuais da interface durante a exportação segue como desafio técnico.
- A arquitetura precisa permitir a adição futura de novos tipos de relatório **sem duplicar a lógica de processamento** dos dados.

### 🧩 Próximas ações para concluir

- Definir a estrutura final do relatório da simulação.
- Implementar a primeira versão do relatório diretamente na **interface Streamlit**.
- Criar o template utilizado para organizar as informações.
- Integrar dados da topologia e da co-simulação ao relatório.
- Incorporar tabelas e gráficos já disponíveis na plataforma.
- Implementar uma primeira opção de download e avaliar posteriormente a conversão para PDF.

### 📅 Prazo

- Data de entrega pretendida: **25/09/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Avançaram na usabilidade da interface de co-simulação, com personalização individual da tecnologia de rede dos agentes e terminal desacoplado da execução.
  - O principal ponto pendente segue sendo a etapa de **testes** e o refinamento da disposição dos gráficos ao final da execução.
  - Progresso: **não informado**.

- **Luiz Alberto (TSDQ)**
  - Mudou o foco da semana para o **estudo da geração de relatórios** na ARGOS, estruturando alternativas de exportação e uma arquitetura baseada em templates e rastreabilidade.
  - O trabalho já possui base conceitual sólida, mas ainda depende da implementação do gerador e da validação com dados reais.
  - Prazo: **25/09/2026** — progresso em **70%**.
