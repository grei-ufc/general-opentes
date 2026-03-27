---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos
  passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-03-20)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-03-20**

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
  - **Medição de latência e tamanho de pacote** na comunicação entre nós (ZeroMQ).
  - **Teste de escalabilidade** com aumento progressivo do número de nós
    (`plot-teste-escalabilidade.png`), analisando consumo de recursos e
    tempo de processamento.
  - **Geração de gráficos** (`simulacao-plot.png`) para visualização do fluxo de
    dados (pacotes enviados pelo `node_0` e recebidos pelo `node_1` ao longo do
    tempo).

### 📈 Evidências / resultados

- Progresso atual: **100%**.
- Gráficos gerados confirmam o comportamento esperado da simulação.
- Teste de escalabilidade realizado com sucesso, identificando possíveis
  gargalos para cenários mais complexos.

### ⚠️ Dificuldades / bloqueios

- **Sem bloqueios reportados.**

### 🧩 Próximas ações para concluir

- Validar **resultados preliminares com o orientador** (pendente no checklist).
- Passo 2 do planejamento de entrega não foi informado.

### 📅 Prazo

- Data de entrega pretendida: **xx/03/2026** (**dia não informado**).

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- **Reestruturação arquitetural** da interface gráfica de análise de resultados
  do OpenDSS:
  - Migração da lógica de mapeamento de variáveis do código Python para um
    **arquivo de configuração externo dinâmico (`mapeamento.json`)**, tornando o
    sistema universal.
  - Leitura e plotagem automática de diversas grandezas: **Tensão, Corrente,
    Potências e Irradiância**.
  - Captura de nomes via **Regex** mais robusta, aceitando nomenclaturas
    complexas, espaços e formatações alinhadas aos padrões ONS e BDGD (ANEEL).
  - Adição de **documentação instrutiva embutida no JSON** para orientar a equipe.
- Melhoria de **UX**: traduções dinâmicas e dicas de contexto automáticas
  (ex.: identificação dos lados primário e secundário de reguladores de tensão).

### 📈 Progresso reportado

- Progresso atual: **100%** (com barra visual em 75% — pode indicar progresso
  parcial da próxima etapa já considerada).

### ⚠️ Dificuldades / bloqueios

- **Problemas na plotagem de valores muito pequenos**, que são exibidos como
  linha reta na interface.

### 🧩 Próximas ações para concluir

- Correção da plotagem de valores muito pequenos.
- Estudo de ilustração para cada sistema (diagrama de rede).
- Passo 1: Compreensão dos códigos utilizados para a co-simulação do OpenDSS
  que incluem essa ilustração do sistema.
- Passo 2: Aplicação da estrutura no código.

### 📅 Prazo

- Data de entrega pretendida: **03/04/2026**.

---

## 3) 👨‍💻 Paulo Victor Pereira Lima (TSRE)

### ✅ Tarefas principais

- **Conclusão do estudo dos códigos de exemplo do OpenDER (EPRI)**:
  - 7 códigos de exemplo estudados, cobrindo comportamentos de sistemas FV e
    BESS para diferentes situações.
- **Encerramento das análises** da simulação de painéis FV desenvolvida pelo
  Caio Lucas (substituída por versão mais promissora do Luis Felipe).
- **Pesquisa e obtenção de dados fotovoltaicos reais**:
  - Identificado o repositório **BR-PVGen — The Brazilian Photovoltaic
    Generation** (UFJF / Kaggle) como base de dados para as simulações.
  - Contato em andamento com membro do LEA (UFC) para obtenção de dados
    adicionais.

### 📈 Progresso reportado

- Progresso atual: **100%**.
- Aquisição de dados para simulação: ✅ concluída.

### ⚠️ Dificuldades / bloqueios

- **Sem bloqueios reportados.**

### 🧩 Próximas ações para concluir

- Aplicar os dados fotovoltaicos reais nas simulações.
- Continuar contato com o LEA (UFC) para obtenção de mais dados.

### 📅 Prazo

- Data de entrega pretendida: **20/03/2026**.

---

## 4) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- **Finalização e refinamento** da atualização do **PADE** para **Python
  3.12.11**, com foco em correção de bugs residuais, polimento de código e
  preparativos para lançamento da release oficial.

### 📈 Resultados / entregas técnicas (destaques)

- Status geral: **100% funcional**.

| Módulo/Aplicação | Status | Observação |
|---|---|---|
| **Core e Protocolos FIPA** | ✅ 100% | Comunicação estável via Twisted (Python 3.12) |
| **Arquitetura de Logging** | ✅ 100% | Captura limpa em CSV (eventos, mensagens, agentes) |
| **Co-Simulação (Mosaik)** | ✅ 100% | Sincronismo sem *deadlocks* |
| **Documentação Oficial** | ✅ 100% | Manuais atualizados (sem SQLite, arquitetura CSV) |

- Correções e refinamentos da semana:
  - Ajustes de formatação e tratamento de exceções em mensagens de rede.
  - Limpeza de trechos de código legado comentados.
  - Validação da estrutura de pastas para empacotamento da versão final.

### ⚠️ Dificuldades / bloqueios

- **Sem dificuldades críticas** — semana dedicada a *code review* e garantia
  de qualidade (QA).

### 🧩 Próximas ações para concluir

- Empacotar a **Release v2.2.6** e realizar o **Pull Request** na branch
  principal (`/pade2026`).

### 📅 Prazo

- Data de finalização: **20/03/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Entregaram novos incrementos na co-simulação MOSAIK↔OMNeT++: medição de
    latência, teste de escalabilidade e geração de gráficos de fluxo de dados.
  - Progresso: **100%**; sem bloqueios.
  - Pendência: **validação dos resultados com o orientador**.
  - Prazo indicado como **xx/03/2026** (sem dia definido).

- **Luiz Alberto (TSDQ)**
  - Reestruturou a interface gráfica de análise do OpenDSS com configuração
    dinâmica via JSON, tornando o sistema universal para múltiplas grandezas.
  - Bloqueio: **plotagem incorreta de valores muito pequenos** (exibidos como
    linha reta).
  - Próximos passos: corrigir plotagem e adicionar ilustração do sistema de
    distribuição.
  - Prazo: **03/04/2026**.

- **Paulo Victor (TSRE)**
  - Concluiu o estudo dos 7 exemplos do OpenDER e encerrou análises da simulação
    FV anterior; identificou e iniciou obtenção de dados fotovoltaicos reais
    (BR-PVGen/UFJF + LEA/UFC).
  - Progresso: **100%**; sem bloqueios.
  - Próximos passos: aplicar dados reais nas simulações e continuar contato com
    o LEA.
  - Prazo: **20/03/2026**.

- **Douglas Barros (TTESO/PADE)**
  - Finalizou a migração do PADE para Python 3.12.11 com 100% de funcionalidade;
    semana dedicada a polimento, *code review* e QA.
  - Sem bloqueios.
  - Próximo passo: empacotar e lançar a **Release v2.2.6** via PR na branch
    `/pade2026`.
  - Prazo: **20/03/2026**.
