---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos
  passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-04-10)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-04-10**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael Moura Sousa (TSCC)

### ✅ Tarefa principal

- Evolução da **co-simulação entre MOSAIK (Python) e OMNeT++/INET (C++)** em
  **containers Docker separados**, com novos incrementos implementados:
  - **Sincronização de Passos (SYNC)** entre Mosaik e OMNeT++: implementação de
    contador explícito de passos (`mosaik_step`) no `MosaikBridge.cc`, com
    verificação de divergência de tempo entre os dois simuladores e propagação
    do `time_resolution` do wrapper até o OMNeT++.
  - **Ciclo de Retroalimentação de Dados (Feedback Loop)**: conexão de feedback
    do `node_0` (hub) de volta ao `Controlador` via `time_shifted=True`,
    garantindo que o `data_out` do passo `t` chegue ao Controlador no passo
    `t+1` sem erros de causalidade.
- **Estudo e compilação de exemplos do PADE** atualizado, com o objetivo de
  habituar-se ao framework e posteriormente integrar a nova versão do PADE na
  co-simulação da professora Janaína.

### 📈 Evidências / resultados

- Progresso atual: **100%**.
- Sincronização temporal entre Mosaik e OMNeT++ validada com sucesso.
- Feedback loop funcional, com comunicação real entre `node_0` e `Controlador`.
- Exemplos do PADE estudados e integrados à co-simulação da professora Janaína
  com suporte às novas funções de limite de pacotes e desincronização de tempos.

### ⚠️ Dificuldades / bloqueios

- **Sem bloqueios significativos reportados.**

### 🧩 Próximas ações para concluir

- Validar **resultados preliminares com o orientador** (pendente no checklist).
- Incluir o **PADE** diretamente na co-simulação do time TSCC.

### 📅 Prazo

- Data de entrega pretendida: **xx/03/2026** (**dia não informado**).

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- **Desenvolvimento do artigo para o CBA 2026**:
  - Implementação do **uv** no projeto base para facilitar o gerenciamento do
    ambiente e das dependências.
  - Incorporação do **modelo oficial do CBA** ao repositório, substituindo o
    template utilizado anteriormente apenas como referência no Overleaf.
  - Migração da escrita do artigo para o **VS Code**, promovendo maior controle
    sobre o versionamento e a edição do texto.
  - Início da elaboração da **Seção 2 (Fundamentação Teórica)**, conforme
    orientação da Professora Raquel na última revisão.

### 📈 Progresso reportado

- Progresso atual: **82%**.

### ⚠️ Dificuldades / bloqueios

- **Problemas com o PATH ao utilizar o Pearl e o latexmk**, afetando a
  compilação do LaTeX no ambiente configurado.

### 🧩 Próximas ações para concluir

- Continuar a pesquisa e a escrita científica do artigo.
- Revisão do artigo com os orientadores.

### 📅 Prazo

- Data de entrega pretendida: **10/04/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- **Consolidação da Release v2.2.6 do PADE** para **Python 3.12.11**, com
  fechamento técnico completo da migração, incluindo estabilização final do
  core, consolidação dos exemplos, documentação, empacotamento e abertura do
  Pull Request para a branch `pade2026`.

### 📈 Resultados / entregas técnicas (destaques)

- Status geral: **100% concluído**.

| Módulo/Atividade | Status | Observação |
|---|---|---|
| **Core do PADE (Python 3.12.11)** | ✅ 100% | Runtime integrado, AMS, Sniffer e logging CSV consolidados |
| **CLI do PADE** | ✅ 100% | Modo detalhado (`--detailed`) implementado |
| **Exemplos Base** | ✅ 100% | `hello_world`, `agent_example_1–6` validados |
| **Integrações Avançadas** | ✅ 100% | `mosaik_example`, `iec_61850`, `power_systems` (IEEE-13) validados |
| **Release v2.2.6** | ✅ 100% | Wheel e sdist gerados e instalados em ambiente limpo |
| **PR para `pade2026`** | ✅ 100% | PR #85 criado e aguardando revisão do mantenedor |

- Principais atividades das semanas (30/03–10/04):
  - Refinamento final do runtime e correção de roteamento de mensagens.
  - Reestruturação pedagógica do `Hello World` (versão mínima + versão com logging real).
  - Validação e modernização do `mosaik_example` para Mosaik 3.x.
  - Criação da biblioteca local `mygrid` para viabilizar o exemplo `power_systems`.
  - Tradução técnica do código para inglês nos módulos e exemplos relevantes.
  - Empacotamento da `v2.2.6` (`pade-2.2.6.tar.gz` e `pade-2.2.6-py3-none-any.whl`).
  - Abertura do Pull Request #85 para a branch `pade2026`.

### ⚠️ Dificuldades / bloqueios

- Exemplos legados com comportamentos implícitos do PADE antigo exigiram
  **revisão cuidadosa** para preservar o registro correto no novo Sniffer CSV.
- Parte da lógica de exemplos avançados dependia de **bibliotecas externas
  ausentes** no repositório (ex.: `power_systems`), exigindo implementação
  local compatível.
- Validação via wheel evidenciou que **scripts de exemplo continuam sendo
  consumidos a partir do repositório**, aspecto considerado durante a validação
  final.

### 🧩 Próximas ações para concluir

- Acompanhar a **revisão e aprovação do PR #85** pelo mantenedor.
- Realizar o **fechamento formal da release** com tag e publicação no GitHub
  após o merge.
- Iniciar o planejamento do novo estudo de **sistema transativo** sobre a base
  PADE 3.12.11 (inspirado na tese de Lucas Silveira Melo, 2022).
- Definir arquitetura de **co-simulação** para o novo exemplo prático, com
  possibilidade de uso de **mosaik + OMNeT++**.

### 📅 Prazo

- Entrega técnica consolidada em: **10/04/2026**.

---

## 4) 👨‍💻 Paulo Victor Pereira Lima (TSRE)

### ✅ Tarefas principais

- **Implementação de geradores FV na rede IEEE 123 barras** e comparação entre
  os resultados da co-simulação e a simulação com OpenDSS puro.
  - Identificação e **correção de erro** nos códigos de coleta de dados de
    tensão referentes a linhas monofásicas.
  - Elaboração dos resultados da implementação dos simuladores FV, registrados
    na issue #11.
- **Discussão de alinhamento** sobre a utilização dos dados fotovoltaicos reais
  obtidos do LEA/UFC e do BR-PVGen/UFJF.
- **Estudo da simulação com inversores inteligentes** no sistema IEEE 123 barras
  com uso do OpenDER.

### 📈 Progresso reportado

- Progresso atual: **60%**.

### ⚠️ Dificuldades / bloqueios

- **Sem bloqueios reportados.**

### 🧩 Próximas ações para concluir

- Decisão consolidada acerca da **implementação dos dados reais** para geração
  FV e elaboração de pipeline de ingestão de dados reais.
- Implementação de **algoritmo de conversão** de arquivos de irradiância de CSV
  para `.dss` para cada gerador FV de forma automatizada.
- Implementação da **rede IEEE 13 barras** utilizando o novo simulador e os
  inversores inteligentes.

### 📅 Prazo

- Data de entrega pretendida: **17/04/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Implementaram sincronização de passos (SYNC) entre Mosaik e OMNeT++ e
    feedback loop funcional com `time_shifted=True`.
  - Estudaram e integraram exemplos do novo PADE na co-simulação da professora
    Janaína.
  - Progresso: **100%**; sem bloqueios significativos.
  - Pendência: **validação dos resultados com o orientador** e inclusão do PADE
    diretamente na co-simulação do time.
  - Prazo indicado como **xx/03/2026** (sem dia definido).

- **Luiz Alberto (TSDQ)**
  - Configurou o ambiente de escrita científica com **uv + VS Code + LaTeX** e
    incorporou o modelo oficial do CBA 2026 ao repositório.
  - Iniciou a **Seção 2 (Fundamentação Teórica)** do artigo.
  - Bloqueio: **problemas de PATH com Pearl/latexmk** na compilação LaTeX.
  - Próximos passos: continuar a escrita e submeter à revisão dos orientadores.
  - Prazo: **10/04/2026** — progresso em **82%**.

- **Douglas Barros (TTESO/PADE)**
  - Concluiu integralmente a migração do PADE para Python 3.12.11, com release
    `v2.2.6` empacotada, exemplos validados e PR #85 aberto para a branch
    `pade2026`.
  - Dificuldades contornadas (sem bloqueios ativos).
  - Próximo ciclo: **pesquisa aplicada em sistema transativo** sobre a nova
    base, com possível arquitetura mosaik + OMNeT++.
  - Prazo: **10/04/2026** — entrega técnica **100% concluída**.

- **Paulo Victor (TSRE)**
  - Implementou geradores FV na rede IEEE 123 barras e corrigiu erro na coleta
    de dados de tensão em linhas monofásicas; resultados registrados na issue #11.
  - Realizou discussão de alinhamento sobre uso dos dados fotovoltaicos reais
    (LEA/UFC + BR-PVGen/UFJF) e estudou inversores inteligentes com OpenDER.
  - Progresso: **60%**; sem bloqueios.
  - Próximos passos: definir pipeline de ingestão de dados reais, converter
    irradiância CSV→DSS e implementar a rede IEEE 13 barras com inversores.
  - Prazo: **17/04/2026**.
