---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos
  passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-03-13)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-03-13**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael Moura Sousa (TSCC)

### ✅ Tarefa principal

- Conclusão da **co-simulação entre MOSAIK (Python) e OMNeT++/INET (C++)** em
  **containers Docker separados**, com:
  - **Orquestração via Docker Compose**
  - **Comunicação via ZeroMQ (porta 5555)**
  - **Criação dinâmica de nós no OMNeT++** a partir de comandos do MOSAIK
  - **Injeção de dados em tempo real** (ex.: `15.0` no `data_in` do `node_0`)
  - **Coleta de resultados e salvamento em `results.csv`**

### 📈 Evidências / resultados

- `results.csv` confirma funcionamento da co-simulação (incremento do `data_out`
  conforme esperado, status “active” durante a simulação).
- Consolidação das abordagens testadas (container único COSIMA+OMNeT; COSIMA
  existente + MOSAIK novo; e containers OMNeT/MOSAIK separados — abordagem final
  bem-sucedida).

### ⚠️ Dificuldades / bloqueios

- **Sem bloqueios atuais reportados.**
- Desafios anteriores (já contornados): complexidade/tempo de compilação do
  COSIMA, conflitos de portas, sincronização lock-step.

### 🧩 Próximas ações para concluir

- Finalizar **documentação do código (Docstrings)** (pendente no checklist).
- Validar **resultados preliminares com o orientador** (pendente).
- Preencher o planejamento final (Passo 1 / Passo 2) com ações objetivas.

### 📅 Prazo

- “Data de entrega pretendida: **/03/2026**” (**dia não informado**).

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Verificação de perdas de dados nas saídas das simulações:
  - Conclusão: problema **apenas visual** (camada de apresentação).
- Implementação de leitura:
  - **correntes**
  - **ângulos de corrente**
- Continuidade do desenvolvimento da ferramenta de análise em Python (relato
  menciona outras leituras/integrações, mas o texto está truncado no mini
  relatório).

### ⚠️ Dificuldades / bloqueios

- A simulação usada como referência **ainda não possui análise de potências**,
  impedindo que essa parte seja analisada/exibida na interface.

### 🧩 Próximas ações para concluir

- Iniciar estudo do **OpenDER** para apoiar o time TSRE e compreender sua
  função.
- Buscar nos **códigos-fonte** divergências/referências que ajudem na validação.
- Planejamento declarado:
  - Passo 1: Compreender os códigos utilizados para a co-simulação.
  - Passo 2: Comparar resultados entre o simulador e o **OpenDSS**.

### 📅 Prazo

- Data de entrega pretendida: **2026-03-20**.

---

## 3) 👨‍💻 Paulo Victor Pereira Lima (TSRE)

### ✅ Tarefas principais

- Continuidade do estudo do modelo de recursos elétricos distribuídos **OpenDER
  (EPRI)**:
  - Estudo de códigos de exemplo para compreender sintaxe, estrutura e
    funcionamento.
- Melhoria do script de visualização em **Streamlit**:
  - Exibição mais flexível/interativa como base para análises futuras.
- Início de análises de resultados das simulações para melhorias (inclui
  simulação de painéis FV).

### 📈 Progresso reportado

- OpenDER: **~80%**
- Visualização dos resultados do simulador FV: **~100%**

### ⚠️ Dificuldades / bloqueios

- **Nenhum bloqueio reportado.**

### 🧩 Próximas ações para concluir

- Rodar e estudar os demais exemplos do OpenDER.
- Analisar o sistema de **13 barras** com OpenDSS e mosaik:
  - com e sem geração FV
  - para verificar divergências.

### 📅 Prazo

- Data de entrega pretendida: **2026-03-20**.

---

## 4) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Atualização do **PADE** para **Python 3.12.11** (Twisted / sistema
  multiagentes), com estabilização do core, integrações e documentação final.

### 📈 Resultados / entregas técnicas (destaques)

- Correções críticas no core:
  - Propagação automática da tabela de agentes (AMS).
  - Correção do `notify()` (remoção de `message.copy()` inexistente).
  - Criação de `format_message_content` para tratar decodificação de `pickle` e
    evitar resíduos hexadecimais nos logs.
  - Refatoração de I/O de rede: substituição para **Strict Bytes** no Twisted.
- Validação de exemplos e scripts:
  - `agent_example_1` a `agent_example_6`
  - `script_2.py` a `script_5.py`
  - comandos CLI: `pade show-logs` e `pade export-logs`
- Integrações GREI:
  - Mosaik co-simulação: refatoração do `mosaik_driver.py` (API 3.0+ e
    sincronismo sem deadlocks).
  - Agente tradutor FIPA-ACL para envelopar dados TCP/JSON do Mosaik.
  - Power systems: cálculo Backward-Forward Sweep e envio de matrizes Numpy
    (IEEE-13).
  - Script analítico `analise_mosaik.py` (pandas/matplotlib).
- Documentação:
  - Reescrita de `README.md` (remoção SQLite, introdução CSV, arquitetura
    multi-terminal).
  - Atualização de guias Sphinx (`.rst`) e traduções (`.po`).
  - Ajustes em `setup.py` com bibliotecas analíticas (pandas/matplotlib/numpy).

### ⚠️ Dificuldades / bloqueios

- Pendente: validação do protocolo **IEC-61850**, aguardando dependência
  **`mygrid`**.

### 🧩 Próximas ações para concluir

- Aguardar disponibilização do `mygrid`.
- Testar/validar o agente IEC-61850 (`agent_example_iec_61850_1.py`).
- Fechar 2 issues pendentes no GitHub com documentação atualizada.
- Empacotar release (citada como **v2.2.6**) e aprovar PR na branch `/pade2026`.

### 📅 Prazo

- Data de entrega pretendida: **2026-03-13** (condicionada ao recebimento do
  `mygrid` para finalizar IEC-61850).

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Entregaram a co-simulação MOSAIK↔OMNeT em containers separados via
    ZMQ/Compose, com resultados registrados em `results.csv`.
  - Sem bloqueios atuais; pendências são **docstrings** e **validação com
    orientador**.
  - Prazo indicado apenas como **03/2026** (sem dia).

- **Luiz Alberto (TSDQ)**
  - Evoluiu a ferramenta de análise (Python): corrigiu interpretação de “perda
    de dados” (era visual) e implementou leitura de correntes e ângulos.
  - Bloqueio: ausência de **análise de potências** na simulação de referência
    para a interface.
  - Próximos passos: estudo de OpenDER e comparação de resultados com OpenDSS.
  - Prazo: **2026-03-20**.

- **Paulo Victor (TSRE)**
  - Avançou no estudo do OpenDER (códigos de exemplo) e melhorou visualização
    com Streamlit; análise FV/visualização está praticamente concluída.
  - Sem bloqueios reportados.
  - Próximos passos: rodar demais exemplos OpenDER e analisar sistema 13 barras
    com/sem FV.
  - Prazo: **2026-03-20**.

- **Douglas Barros (TTESO/PADE)**
  - Migração do PADE para Python 3.12.11 está em 95%, com várias correções core,
    logging CSV, integrações e documentação consolidadas.
  - Bloqueio: validação IEC-61850 depende de **`mygrid`**.
  - Próximos passos: validar IEC-61850, fechar issues, empacotar release v2.2.6
    e aprovar PR na `/pade2026`.
  - Prazo: **2026-03-13** (na prática, condicionado ao `mygrid`).
