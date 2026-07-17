---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-07-17)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-07-17**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Atuação em duas frentes no repositório **`tscc-com-opentes`**:
  - Continuidade da **revisão bibliográfica** sobre co-simulação, com foco no artigo **"cosima-mango: Investigating Multi-Agent System robustness through integrated communication simulation"**.
  - Avanço na **integração cibernético-física** da plataforma, consolidando a comunicação entre agentes **PADE** e a física de rede no **OMNeT++**.
  - Evolução da arquitetura de comunicação para suportar **nós independentes e descentralizados**, com maior realismo de rede e escalabilidade.

### 📈 Evidências / resultados

- Progresso percentual **não informado** no mini relatório.
- Foi produzido um comparativo técnico entre os frameworks **PADE** e **Mango**, destacando aderência ao padrão **FIPA**, arquitetura de comunicação e capacidade de integração com **Mosaik** e **OMNeT++**.
- A plataforma passou a instanciar dezenas de agentes dinamicamente, gerando os respectivos clones físicos no OMNeT++.
- Foram implementados mecanismos de maior realismo de comunicação, incluindo **filas de buffer**, **jitter estocástico**, perfis heterogêneos de enlace e telemetria detalhada de payload, latência e confiabilidade.

### ⚠️ Dificuldades / bloqueios

- Os principais gargalos técnicos da semana foram tratados durante o desenvolvimento:
  - Bloqueio de envios simultâneos no OMNeT++ por saturação do canal físico.
  - Mistura indevida de tempos de chegada entre cabos distintos, impactando o roteamento e a leitura do jitter.
  - Dependência de nomes fixos de nós no simulador, dificultando o escalonamento dinâmico.
- O mini relatório não apontou bloqueios pendentes em aberto após essas correções.

### 🧩 Próximas ações para concluir

- Refatorar e melhorar os **gráficos e dashboards** de telemetria.
- Implementar o **posicionamento geográfico/cartesiano** dos agentes para correlacionar distância e comportamento de rede.
- Concluir a revisão dos demais artigos selecionados e avançar na **redação do artigo principal**.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Evolução do módulo **Mapa de Rede** da plataforma **ARGOS/OpenTES**, com foco na integração entre a topologia elétrica e os resultados temporais da co-simulação.
  - Integração simultânea de **topologia JSON** com resultados em **CSV**.
  - Preservação da compatibilidade com importação de circuitos **OpenDSS em ZIP**.
  - Implementação de navegação temporal para os **288 instantes** da simulação diária.
  - Associação automática de tensões, correntes, potências e variáveis do sistema fotovoltaico aos elementos da topologia.

### 📈 Progresso reportado

- Progresso atual: **95%**.
- O módulo passou a exibir a rede com **classificação visual por nível de tensão**, além de inspetores mais completos para nós e linhas.
- Houve preservação integral dos metadados importados e criação de **indicadores de cobertura** para medir a qualidade da associação entre variáveis e elementos da rede.
- A solução agora permite acompanhar o comportamento elétrico da rede ao longo do tempo com maior rastreabilidade e capacidade analítica.

### ⚠️ Dificuldades / bloqueios

- Dificuldade em estabelecer a correspondência correta entre variáveis da co-simulação e os elementos da topologia.
- Necessidade de tratar medições sem associação direta a nós ou arestas.
- Desafio de organizar a estrutura de dados para suportar navegação temporal com bom desempenho.
- Compatibilização entre os formatos **ZIP, JSON e CSV** em um fluxo único.

### 🧩 Próximas ações para concluir

- Expandir a associação automática para todos os equipamentos monitorados.
- Integrar **animações temporais** da evolução das grandezas elétricas.
- Implementar **filtros por tipo de equipamento e variável**.
- Adicionar métricas adicionais de **qualidade de energia** e otimizar a renderização para redes maiores.

### 📅 Prazo

- Data de entrega pretendida: **24/06/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Realização de uma **faxina técnica** no repositório **`grei-ufc/co-simulation-opentes`**, com foco em usabilidade, simplificação da execução e documentação.
  - Auditoria do que realmente compõe a cadeia viva do cenário **IEEE 13**.
  - Remoção de **código morto**, arquivos quebrados e materiais alheios ao escopo atual.
  - Unificação de quatro scripts de execução em um único **`./run.sh`**.
  - Atualização do **README** com os dois caminhos de instalação: **Docker** e **uv**.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **100%**.
- Foram realizados **3 commits**, com impacto em **35+ arquivos** e redução de aproximadamente **4.300 linhas**.
- A execução do projeto foi centralizada em um único comando com `--help`, reduzindo duplicação e facilitando manutenção.
- Também foram identificados e corrigidos dois problemas relevantes:
  - Um **race de inicialização** no cenário `ieee13`.
  - Uma dependência implícita do `mosaik-api`, agora declarada explicitamente.

### ⚠️ Dificuldades / bloqueios

- O mini relatório não indicou bloqueios ativos ao final da semana.
- O trabalho esteve concentrado em manutenção e organização do repositório, sem avanço científico direto no período.

### 🧩 Próximas ações para concluir

- Retomar a **redação do artigo** com revisão do texto pelos autores.
- Iniciar o estudo do **sistema transativo** para futura implementação.

### 📅 Prazo

- **Não informado.**

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Avançaram simultaneamente em **revisão bibliográfica** e no amadurecimento técnico da integração entre **PADE**, **Mosaik** e **OMNeT++**.
  - O destaque técnico foi a consolidação de uma arquitetura mais **escalável e realista de comunicação**, com buffers, jitter estocástico e telemetria detalhada.
  - Progresso: **não informado**.

- **Luiz Alberto (TSDQ)**
  - Deixou o **Mapa de Rede** muito próximo da conclusão, integrando topologia e dados temporais da co-simulação com visualização analítica e indicadores de cobertura.
  - Os desafios seguem concentrados na associação automática completa das medições e na otimização para redes maiores.
  - Prazo: **24/06/2026** — progresso em **95%**.

- **Douglas Barros (TTESO/PADE)**
  - Entregou uma semana de **manutenção estrutural** do repositório, simplificando execução, removendo código morto e fortalecendo a documentação.
  - O principal ganho foi tornar o projeto mais **executável, legível e sustentável**, além de eliminar dois bugs importantes de infraestrutura.
  - Progresso: **100%**.
