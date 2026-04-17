---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos
  passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-04-17)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-04-17**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Evolução da infraestrutura de **co-simulação OMNeT++/Mosaik via ZeroMQ** e do
  suporte ao ecossistema **PADE/Mosaik** vinculado à tese da Profa. Janaína.
  - Reorganização do repositório `tscc-com-opentes`, com a branch `main`
    refletindo o estado estável da integração.
  - Atualização completa do `README.md` com o fluxo de build e execução em
    containers.
  - Configuração do **Broker como oráculo de rede**, consultando o OMNeT++ para
    calcular o atraso de tráfego antes da entrega das mensagens.
  - Migração da arquitetura PADE/Mosaik para **modo hybrid com triggers** e
    eventos discretos (*non-persistent*), eliminando warnings e reduzindo o
    risco de perda de pacotes.

### 📈 Evidências / resultados

- Progresso atual: **100%**.
- Branch principal estabilizada e documentada para a integração OMNeT++/Mosaik.
- Warnings de dados ausentes eliminados no fluxo PADE/Mosaik.
- Ambiente atualizado com **Mosaik 3.6.0**, **PADE** e **Python 3.10.20**.

### ⚠️ Dificuldades / bloqueios

- **Nenhum bloqueio identificado.**

### 🧩 Próximas ações para concluir

- Validar se o Broker está segurando corretamente as mensagens conforme o tempo
  calculado pelo OMNeT++.
- Executar testes de carga na interface híbrida com maior volume de mensagens.
- Realizar revisão final da documentação de integração.

### 📅 Prazo

- Data de entrega pretendida: **17/04/2026**.

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Continuidade do **desenvolvimento do artigo para o CBA 2026** e atividades de
  apoio ligadas à interface.
  - Depuração do código da interface para verificar a existência de erro na
    plotagem de gráfico.
  - Primeira revisão da conclusão do artigo.
  - Elaboração de um fluxograma do processo de utilização da interface.
  - Consolidação do ambiente de escrita no **VS Code com suporte a LaTeX**.

### 📈 Progresso reportado

- Progresso atual: **89%**.

### ⚠️ Dificuldades / bloqueios

- **Problemas com o PATH ao utilizar o Pearl e o `latexmk`**, afetando o fluxo
  de compilação no ambiente LaTeX.

### 🧩 Próximas ações para concluir

- Continuar a escrita científica.
- Finalizar o fluxograma do processo de utilização da interface.

### 📅 Prazo

- Data de entrega pretendida: **20/04/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Consolidação do **ambiente experimental da próxima etapa da pesquisa**,
  incluindo validação do **OpenDSS em Python 3.12.11** e instalação funcional
  do **OMNeT++ 6.3.0**.
  - Organização e validação de dois fluxos com OpenDSS:
    **`DSS-Python`** e **`py-dss-interface`**.
  - Correção de problema de **locale** no backend Linux-C++ do
    `py-dss-interface`, que comprometia a leitura correta de valores decimais.
  - Instalação, configuração, compilação e validação do **OMNeT++ 6.3.0**,
    incluindo teste do exemplo `aloha` e abertura funcional da IDE.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **20%**.

| Módulo/Atividade | Status | Observação |
|---|---|---|
| **OpenDSS com DSS-Python** | ✅ Validado | Fluxo mínimo executando corretamente em Python 3.12.11 |
| **OpenDSS com py-dss-interface** | ✅ Validado | Problema de locale corrigido e execução estabilizada |
| **OMNeT++ 6.3.0** | ✅ Instalado e compilado | `configure` e `make` concluídos com sucesso |
| **IDE do OMNeT++** | ✅ Funcional | Abertura validada no ambiente local |
| **Exemplo `aloha`** | ✅ Validado | Execução confirmada em `Cmdenv` |

### ⚠️ Dificuldades / bloqueios

- Sensibilidade do `py-dss-interface` ao **locale do sistema** em Linux.
- Incompatibilidades iniciais entre `pyenv`, `python3-dev`, `clang`, `lld` e
  `libdw` durante a configuração e compilação do OMNeT++.

### 🧩 Próximas ações para concluir

- Consolidar o critério de escolha entre `DSS-Python` e `py-dss-interface`.
- Definir como o OpenDSS será acoplado ao fluxo principal com PADE.
- Avaliar o papel do OMNeT++ na arquitetura metodológica e eventual integração
  com `mosaik`.
- Iniciar o desenho do novo caso experimental de sistema transativo.

### 📅 Prazo

- **A definir.**

---

## 4) 👨‍💻 Paulo Victor Pereira Lima (TSRE)

### ✅ Tarefas principais

- Avanço na **simulação com inversores inteligentes na rede IEEE 13 barras**.
- Análise das fontes de dados do **LEA/UFC** e do **BR-PVGen/UFJF**, com decisão
  pela utilização do **BR-PVGen**.
- Desenvolvimento de script para automatização do tratamento de dados e criação
  de geradores fotovoltaicos para o simulador da rede elétrica.

### 📈 Progresso reportado

| Frente de trabalho | Progresso |
|---|---|
| Implementação dos inversores inteligentes no sistema IEEE 13 barras | **15%** |
| Decisão sobre a utilização dos dados | **100%** |
| Script para tratamento dos dados e criação dos geradores FV | **50%** |

### ⚠️ Dificuldades / bloqueios

- **Sem bloqueios reportados.**

### 🧩 Próximas ações para concluir

- Avançar na implementação da simulação com inversores inteligentes na IEEE 13
  barras.
- Finalizar o script de tratamento dos dados e geração automatizada dos
  geradores FV.
- Consolidar o uso dos dados do BR-PVGen na cadeia de simulação.

### 📅 Prazo

- Data de entrega pretendida: **25/04/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Consolidaram a integração **OMNeT++/Mosaik via ZeroMQ** e reorganizaram a
    branch `main` como base estável e documentada.
  - Migraram o fluxo **PADE/Mosaik** para modo híbrido com **triggers**, com
    eliminação de warnings de dados ausentes.
  - Progresso: **100%**; sem bloqueios ativos.
  - Próximos passos: validar retenção de mensagens pelo Broker, ampliar testes
    de carga e revisar a documentação.
  - Prazo: **17/04/2026**.

- **Luiz Alberto (TSDQ)**
  - Avançou na escrita do artigo para o **CBA 2026**, revisando a conclusão e
    desenvolvendo fluxograma da interface.
  - Também realizou depuração da interface para investigar erro de plotagem.
  - Bloqueio ativo: **problemas de PATH com Pearl e `latexmk`**.
  - Próximos passos: seguir com a escrita científica e finalizar o fluxograma.
  - Prazo: **20/04/2026** — progresso em **89%**.

- **Douglas Barros (TTESO/PADE)**
  - Consolidou a base experimental da próxima fase com **OpenDSS em Python
    3.12.11** e **OMNeT++ 6.3.0** operacionais.
  - Corrigiu problema de locale no `py-dss-interface` e validou o exemplo
    `aloha` no OMNeT++.
  - Dificuldades técnicas foram contornadas durante a preparação do ambiente.
  - Próximos passos: definir stack principal, acoplamento com PADE e arquitetura
    metodológica da nova pesquisa aplicada.
  - Prazo: **a definir** — progresso geral **20%**.

- **Paulo Victor (TSRE)**
  - Iniciou a simulação com **inversores inteligentes na IEEE 13 barras**.
  - Definiu o uso dos dados do **BR-PVGen** e avançou no script de tratamento de
    dados e criação de geradores FV.
  - Sem bloqueios reportados.
  - Próximos passos: aprofundar a implementação da simulação e finalizar a
    automação de tratamento dos dados.
  - Prazo: **25/04/2026**.
