---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-07-03)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-07-03**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Início do **mapeamento do estado da arte** por meio de revisão bibliográfica voltada à co-simulação, com foco especial no trabalho do **COSIMA**.
  - Identificação de como a literatura trata a topologia do projeto de co-simulação.
  - Levantamento dos diferenciais do OpenTES em relação ao trabalho de referência.

### 📈 Evidências / resultados

- Progresso percentual **não informado** no mini relatório.
- A revisão inicial permitiu identificar que o **COSIMA** não detalha de forma suficiente as motivações estruturais da sua topologia de co-simulação.
- Também foi destacado como diferencial do trabalho em OpenTES o uso do **PADE atualizado** e a **conteinerização** da co-simulação, aspectos que não aparecem explicados com profundidade no COSIMA.

### ⚠️ Dificuldades / bloqueios

- O mini relatório **não apontou dificuldades técnicas específicas** nesta semana.
- O ambiente foi descrito como **"In Transition / Under debugging"**, mas sem bloqueios objetivos registrados.

### 🧩 Próximas ações para concluir

- Finalizar a revisão bibliográfica.
- Prosseguir com a **escrita do artigo**.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Início de modificações na estrutura da interface do projeto **CBA-2026-Quality-Analysis**.
  - Criação de uma nova branch para reestruturar a interface.
  - Definição da estratégia de utilizar um arquivo **`.json`** gerado a partir de **`coordenadas.csv`** para determinar as barras relevantes a serem exibidas.
  - Remoção da dependência de posições cartesianas para esse filtro, excluindo a plotagem de **barras virtuais**.
  - Estudo preliminar sobre a necessidade de uma **co-simulação interna** na plataforma.

### 📈 Progresso reportado

- Progresso atual: **25%**.
- O avanço técnico principal foi a definição de uma nova abordagem de estruturação da interface e da forma de selecionar os elementos relevantes para exibição.
- O checklist registra apenas **testes unitários realizados** como item concluído nesta etapa.

### ⚠️ Dificuldades / bloqueios

- Houve **divergência de conceitos** para a atualização da interface.
- Ainda permanecem pendentes itens importantes, como documentação, padronização de unidades, correção de autoescala, manualização de colunas e estudos ligados à co-simulação e comunicação OMNeT++.

### 🧩 Próximas ações para concluir

- Gerar o arquivo **`.json`** para a nova lógica de plotagem.
- Avançar na implementação da interface com base nessa estrutura.
- Dar continuidade ao estudo sobre obtenção de dados a partir de uma co-simulação.

### 📅 Prazo

- Data de entrega pretendida: **10/07/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Início da redação de um **artigo científico** sobre a **modernização do framework PADE**, com a integração OpenTES temporariamente em standby.
  - Estruturação do projeto **LaTeX** no template ACM.
  - Investigação das versões **2.2.5** e **3.0.0** do PADE.
  - Redação de um primeiro **rascunho completo** com seis seções.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **50%**.
- Foi produzida uma narrativa técnica consistente sobre a transição do PADE legado, baseado em **Twisted + Flask/SQLAlchemy + SQLite**, para a nova versão com **telemetria em CSV**, **CLI integrada**, empacotamento moderno e **driver Mosaik 3.0**.
- O rascunho completo do artigo já foi estruturado como base para revisão e refinamento pelos autores.

### ⚠️ Dificuldades / bloqueios

- A principal dificuldade foi **organizar e consolidar** fielmente as mudanças entre as versões do PADE a partir do guia de migração e do código.
- A integração OpenTES ficou **temporariamente em standby** para priorizar a produção científica.

### 🧩 Próximas ações para concluir

- Revisar e editar o conteúdo do artigo.
- Definir e inserir as principais **figuras técnicas**.
- Retomar futuramente a integração OpenTES e a frente do segundo artigo.

### 📅 Prazo

- **Não informado.**

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Iniciaram a **revisão bibliográfica** focada em COSIMA e identificaram lacunas importantes na literatura sobre topologia e justificativa estrutural da co-simulação.
  - O principal diferencial já apontado para o OpenTES é o uso do **PADE modernizado** e da **conteinerização**, ainda pouco explorados nos trabalhos de referência.
  - Progresso: **não informado**.

- **Luiz Alberto (TSDQ)**
  - Iniciou a reestruturação da interface com uma nova estratégia baseada em **JSON derivado de `coordenadas.csv`**, visando melhorar a seleção de barras relevantes e eliminar barras virtuais.
  - O trabalho ainda está em estágio inicial, com bloqueios conceituais na atualização da interface e vários itens pendentes no checklist.
  - Prazo: **10/07/2026** — progresso em **25%**.

- **Douglas Barros (TTESO/PADE)**
  - Dedicou a semana à **produção científica**, estruturando um primeiro rascunho completo do artigo sobre a modernização do **PADE**.
  - O principal ponto em aberto é a revisão do texto e a consolidação visual/técnica do material, enquanto a integração OpenTES permanece temporariamente em espera.
  - Progresso geral: **50%**.
