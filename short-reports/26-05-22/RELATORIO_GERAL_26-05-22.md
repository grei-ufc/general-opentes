---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-05-22)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-05-22**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Continuidade da trilha de pesquisa em **telemetria e modelagem de parâmetros de rede wireless** para a co-simulação no **OMNeT++**, com foco na futura injeção de perfis realistas de **5G** e **Wi-Fi**.
  - Levantamento teórico sobre velocidade de transmissão, latência e perda de pacotes em redes sem fio.
  - Análise da topologia e parametrização em `Network.ned` e `omnetpp.ini`.
  - Identificação de que os mecanismos atuais de degradação de canal já estão centralizados e prontos para extensão.
  - Mapeamento dos parâmetros existentes, como largura de banda, `drop_probability` e `jitter_mean`, visando calibração futura.

### 📈 Evidências / resultados

- Progresso atual: **90%**.
- O estudo indicou que a arquitetura atual suporta a injeção de perfis de conectividade wireless sem necessidade de refatoração estrutural ampla.
- Foi consolidado um entendimento técnico inicial de como representar perfis 5G e Wi-Fi dentro da camada de comunicação do projeto.

### ⚠️ Dificuldades / bloqueios

- O principal desafio agora é a **calibração empírica** dos parâmetros de perda e jitter para que o comportamento simulado reflita, com fidelidade, diferenças entre redes **5G** e **Wi-Fi**.
- Ainda não há validação prática da modelagem; a etapa reportada permanece predominantemente teórica.

### 🧩 Próximas ações para concluir

- Aplicar, de forma prática, os perfis estudados no `omnetpp.ini`.
- Estender propriedades dos nós em `Network.ned` para injeção controlada dos perfis de conectividade.
- Executar testes comparativos entre cenários com parâmetros de 5G e Wi-Fi.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Reestruturação da aba de **Análise Elétrica** da plataforma **OpenTES-TSDQ**, com foco em modularização da interface e início do módulo de **Qualidade da Energia Elétrica (QEE)**.
  - Consolidação da leitura dinâmica de arquivos CSV oriundos de simulações elétricas.
  - Organização semântica das variáveis a partir de `mapeamento.json`.
  - Implementação de seleção dinâmica de variáveis e elementos elétricos.
  - Estruturação de visualização individual e multissérie de sinais elétricos.
  - Implementação inicial do painel QEE com cálculo de **DRP**, **DRC** e desequilíbrio de tensão simplificado.
  - Revisão das regex e da padronização automática de unidades elétricas.

### 📈 Progresso reportado

- Progresso atual: **72%**.
- Principais entregas reportadas:
  - modularização da análise elétrica;
  - dashboard inicial para QEE;
  - cálculo inicial de indicadores conforme PRODIST;
  - gráficos multissérie para visualização trifásica;
  - parser semântico baseado em regex para grandezas elétricas;
  - estrutura preparada para futura integração com metadados de co-simulação.

### ⚠️ Dificuldades / bloqueios

- Inconsistências iniciais entre limites gráficos e cálculos de referência do PRODIST.
- Necessidade de reorganização semântica das variáveis elétricas e separação entre tipos distintos de potência.
- Problemas na padronização automática de unidades.
- Ajustes necessários na renderização dinâmica dos cards da interface.
- Limitações do dataset atual para análises mais completas de desequilíbrio via componentes simétricas.
- Dependência futura de metadados da co-simulação para consolidar a camada semântica do sistema QEE.

### 🧩 Próximas ações para concluir

- Refinar o sistema de autoescala de unidades elétricas.
- Implementar persistência das configurações de QEE.
- Adicionar exportação de relatórios elétricos.
- Desenvolver indicadores avançados de qualidade de energia e análise harmônica.
- Estruturar a futura integração com OMNeT++ e metadados da co-simulação.

### 📅 Prazo

- Data de entrega pretendida: **30/05/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Consolidação inicial do repositório agregador **`co-simulation-opentes`**, integrando os componentes **TTESO**, **TSCC** e **TSRE** em uma base comum para a próxima fase da co-simulação do **IEEE 13 Bus**.
  - Organização da estrutura em `simulators_teams/`.
  - Dockerização inicial com `docker-compose.yaml` principal e três Dockerfiles ativos.
  - Validação do **PADE** em Python 3.12.
  - Validação do **TSCC** com **Mosaik 3.5.0** e **OMNeT++** em container com ZMQ.
  - Validação do **TSRE/OpenDSS** com `py-dss-interface`, inclusive no cenário IEEE 13 Bus.
  - Execução de smoke test integrado com **PADE + Mosaik + OMNeT++**.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **20%**.
- A principal entrega da semana foi a consolidação de uma **base operacional integrada**, antes dispersa em componentes isolados.
- O repositório agregador passou a reunir, de forma funcional, as camadas de agentes, comunicação, orquestração temporal e simulação elétrica.
- A infraestrutura foi validada o suficiente para permitir o foco na próxima etapa: simulação contínua e confiável do **IEEE 13 Bus**.

### ⚠️ Dificuldades / bloqueios

- A integração exigiu compatibilizar componentes originalmente desenvolvidos de forma independente, com estruturas próprias de Docker e dependências distintas.
- O TSCC demandou consolidação de múltiplos Dockerfiles em uma estrutura mais coesa.
- A execução integrada ainda apresenta **logs muito verbosos**, especialmente na camada TSCC.
- O avanço atual resolve a integração estrutural, mas **não conclui ainda o problema principal** da simulação contínua, coerente e robusta do IEEE 13 Bus.

### 🧩 Próximas ações para concluir

- Definir o fluxo contínuo mínimo do IEEE 13 Bus.
- Garantir comunicação estável entre **PADE**, **Mosaik**, **OMNeT++** e **OpenDSS**.
- Reduzir a verbosidade dos logs sem perder rastreabilidade.
- Padronizar o armazenamento dos resultados da co-simulação.
- Criar validações automáticas para inconsistências temporais e falhas de comunicação.
- Evoluir o payload atual para mensagens com semântica elétrica real.

### 📅 Prazo

- Consolidação da simulação contínua IEEE 13 Bus com comunicação, armazenamento e logs coerentes: **próximas semanas de maio/2026 ou junho/2026**.

---

## 4) 👨‍💻 Paulo Victor Pereira Lima (TSRE)

### ✅ Tarefas principais

- Continuidade da implementação da **simulação do sistema IEEE 13 barras** com **OpenDSS + Mosaik + Docker**, incluindo o uso de **inversores inteligentes** e a evolução do script de criação de **geradores fotovoltaicos (PVs)**.
  - Consolidação da execução do IEEE 13 barras em containers.
  - Implementação do simulador com inversores inteligentes.
  - Elaboração de relatório de resultados.
  - Continuação das melhorias no script de tratamento de dados e criação automatizada dos geradores FV.

### 📈 Progresso reportado

| Frente de trabalho | Progresso |
|---|---|
| Implementação do sistema IEEE 13 barras em containers e inversores inteligentes | **100%** |
| Melhorias no script para tratamento dos dados e criação dos geradores FV | **96%** |

- O trabalho indica uma etapa bastante madura tanto na simulação elétrica em container quanto na automação associada à criação dos PVs.

### ⚠️ Dificuldades / bloqueios

- O mini relatório **não aponta bloqueios críticos ativos**.
- Foi registrada apenas a necessidade de **pequenos ajustes** no uso da simulação com Docker.
- A validação preliminar com o orientador ainda não foi concluída.

### 🧩 Próximas ações para concluir

- Implementar os ajustes finais na simulação via Docker.
- Definir diretório padrão para salvamento dos arquivos gerados pelo script.
- Concluir as melhorias no pipeline de tratamento de dados e criação dos geradores FV.
- Avançar para o uso de dados reais e geração automatizada de PVs no IEEE 13 barras.

### 📅 Prazo

- Data de entrega pretendida: **29/05/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Direcionaram a semana para estudo e preparação da modelagem de perfis **5G/Wi-Fi** no OMNeT++, com a arquitetura já pronta para receber novos parâmetros.
  - O principal desafio agora é transformar o mapeamento teórico em calibração prática confiável.
  - Progresso: **90%**.

- **Luiz Alberto (TSDQ)**
  - Avançou na reestruturação da análise elétrica e no módulo inicial de **QEE**, combinando parser semântico, visualização multissérie e indicadores iniciais conforme PRODIST.
  - A etapa segue dependente de refinamentos semânticos, melhor padronização de unidades e futura integração com metadados de co-simulação.
  - Prazo: **30/05/2026** — progresso em **72%**.

- **Douglas Barros (TTESO/PADE)**
  - Consolidou a infraestrutura inicial do repositório agregador do OpenTES, integrando **PADE, Mosaik, OMNeT++ e OpenDSS** em uma base comum.
  - O foco agora muda da integração estrutural para a confiabilidade operacional da simulação contínua do **IEEE 13 Bus**.
  - Prazo: **maio/2026 ou junho/2026** — progresso geral **20%**.

- **Paulo Victor (TSRE)**
  - Manteve avanço forte na simulação IEEE 13 barras com containers e inversores inteligentes, além de deixar quase concluída a evolução do script de geração dos PVs.
  - Restam ajustes finos em Docker e o fechamento da automação com dados reais.
  - Prazo: **29/05/2026**.
