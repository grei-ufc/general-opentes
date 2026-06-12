---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-06-12)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-06-12**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Continuidade da refatoração da camada de comunicação entre agentes **PADE** na co-simulação `tscc-com-opentes`, com adoção plena do padrão **FIPA-ACL** e evolução para uma rede **heterogênea** no **OMNeT++**.
  - Eliminação de métodos proprietários que contornavam o protocolo FIPA.
  - Implementação de um mecanismo de **lock-in arquitetural** sobre `send()` e `react()` do PADE, mantendo Mosaik e OMNeT++ transparentes para a aplicação.
  - Criação de buffers/filas com delimitador `|||` para evitar sobrescrita de mensagens em tráfego intenso.
  - Reestruturação da topologia `.ned` para uma estrela elástica e parametrizável, com uso de `DatarateChannel` para atrasos e perdas na camada física.

### 📈 Evidências / resultados

- Progresso percentual **não informado** no mini relatório.
- A comunicação entre agentes passou a operar sob o padrão **FIPA puro**, com uso das primitivas nativas do PADE e sem dependência de dicionários Python transmitidos manualmente.
- O problema crítico de sobrescrita/perda de mensagens por concorrência temporal foi tratado com filas robustas no envio e recebimento.
- O código C++ da rede foi simplificado para atuar como gateway de roteamento, preparando o ambiente para cenários heterogêneos mais realistas.

### ⚠️ Dificuldades / bloqueios

- O principal bloqueio atual é uma **condição de corrida no Docker**: o container do **OMNeT++** encerra antes que o **Mosaik Master** finalize sua inicialização e abra a conexão ZMQ.
- A retirada dos agendamentos internos do C++ acelerou demais a execução virtual do OMNeT++, levando o simulador ao `sim-time-limit` prematuramente.
- O mapeamento completo de métricas individuais por link (jitter, banda e perda) no `omnetpp.ini` ainda não foi concluído.

### 🧩 Próximas ações para concluir

- Implementar retenção temporal/sincronismo bloqueante no ciclo `keep_alive` do `NetworkNode.cc`.
- Validar cenários heterogêneos com diferentes quantidades de agentes usando o mesmo binário compilado.
- Consolidar testes de telemetria e leilões do OpenTES sob canais degradados de forma independente.
- Finalizar o mapeamento de métricas individuais por link na rede heterogênea.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Continuidade da evolução arquitetural da interface **ARGOS / OpenTES-TSDQ**, com foco no módulo **Mapa de Rede**, robustez da aplicação Streamlit e investigação de alternativas de visualização topológica.
  - Estudo da arquitetura atual do módulo `3_Mapa_de_Rede.py`.
  - Avaliação técnica da substituição do **Cytoscape** pelo **WebVis** do ecossistema Mosaik.
  - Diagnóstico de instabilidades ligadas à movimentação dos nós e às recompilações sucessivas do circuito no OpenDSS.
  - Correções no carregamento de circuitos via **OpenDSSDirect** e revisão da persistência de dados usados na visualização.
  - Organização do ambiente de desenvolvimento com **Forks**, sincronização de branches e uso de **UV** para dependências.

### 📈 Progresso reportado

- Progresso atual: **85%**.
- Foi definida uma nova estratégia arquitetural para evolução do módulo de visualização topológica.
- O estudo confirmou a viabilidade técnica do **WebVis** como alternativa futura e aprofundou o entendimento da arquitetura do **Mosaik-Web**.
- O ambiente de desenvolvimento foi reorganizado, deixando a base pronta para continuidade da interface ARGOS.

### ⚠️ Dificuldades / bloqueios

- Instabilidades durante a movimentação dinâmica dos nós da rede.
- Problemas de persistência de estado entre recompilações sucessivas do circuito.
- Complexidade da integração entre **OpenDSS**, **Streamlit** e os componentes gráficos.
- Necessidade de reavaliar parte da arquitetura original do módulo de topologia.

### 🧩 Próximas ações para concluir

- Iniciar a reconstrução do módulo `3_Mapa_de_Rede.py`.
- Implementar a nova arquitetura de visualização topológica.
- Avaliar a integração prática do **WebVis** à interface ARGOS.
- Aprimorar a persistência de estado da aplicação.
- Realizar testes de integração, estabilidade e desempenho.

### 📅 Prazo

- Data de entrega pretendida: **12/06/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Fechamento do **acoplamento causal** da co-simulação OpenTES sobre o **IEEE 13 Barras**, integrando **OpenDSS ⟷ OMNeT++ ⟷ PADE** com **5 inversores fotovoltaicos** sob controle **Volt/Var distribuído**.
  - Consolidação da topologia de **4 containers** (`comm`, `pade`, `mosaik`, `grid`).
  - Migração do controle do TSRE para agentes PADE no inversor.
  - Generalização do cenário para pares medidor/controlador por barra.
  - Execução automatizada de experimento comparando operação **SEM** e **COM** controle.
  - Organização das saídas em `output/` e criação de dashboard integrado de resultados.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **55%**.
- O laço causal **OpenDSS → OMNeT++ → PADE → OpenDSS** foi fechado, permitindo que decisões dos agentes alterem o estado elétrico da rede no passo seguinte.
- Os **5 PVs** já operam co-simulados e controlados, com tensão trafegando por uma rede de comunicação com latência, jitter e perda de pacotes.
- O benchmark mostrou suporte efetivo de tensão e validação do bloco elétrico isolado em conformidade com o resultado do TSRE.
- Surgiu um achado relevante: a qualidade da comunicação limita a agressividade segura do controle **Volt/Var**.

### ⚠️ Dificuldades / bloqueios

- O controle distribuído torna-se instável quando combinado com atraso/perda de pacotes e ganho agressivo, levando a sobre-injeção de reativo.
- A calibração do controle **Volt/Var** e da perda de pacotes ainda está pendente.
- A reprodutibilidade exata entre execuções ainda é limitada pela ordem assíncrona das mensagens, embora o comportamento qualitativo permaneça estável.

### 🧩 Próximas ações para concluir

- Calibrar o ganho **Volt/Var** e a curva de perda de pacotes com apoio do TSRE/TSCC.
- Estudar sistematicamente o impacto de perda e latência sobre estabilidade e qualidade da regulação.
- Padronizar colunas dos CSVs e o formato das saídas.
- Preparar um cenário reproduzível para execução no servidor do laboratório.
- Evoluir a base para a futura etapa de transações econômicas.

### 📅 Prazo

- Calibração do controle/comunicação e cenário reproduzível em servidor: **junho/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Consolidaram a migração da comunicação para **FIPA-ACL puro**, com filas anti-sobrescrita e base pronta para rede heterogênea no **OMNeT++**.
  - O avanço é estruturalmente importante, mas ainda depende da correção da sincronização entre containers e do fechamento das métricas por link.
  - Progresso: **não informado**.

- **Luiz Alberto (TSDQ)**
  - Reestruturou a estratégia do **Mapa de Rede** da interface ARGOS e preparou a base para uma possível migração de visualização do **Cytoscape** para o **WebVis**.
  - Restam a reconstrução prática do módulo, a validação da nova arquitetura e os testes de integração/estabilidade.
  - Prazo: **12/06/2026** — progresso em **85%**.

- **Douglas Barros (TTESO/PADE)**
  - Fechou o **acoplamento causal** da co-simulação no **IEEE 13 Barras** com **5 PVs** sob controle **Volt/Var** distribuído.
  - O principal desafio agora é calibrar o controle e a comunicação para garantir estabilidade e reprodutibilidade do benchmark.
  - Prazo: **junho/2026** — progresso geral **55%**.
