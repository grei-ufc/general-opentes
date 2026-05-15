---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-05-15)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-05-15**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Evolução da infraestrutura de **co-simulação com foco em telemetria de alta resolução e usabilidade da plataforma**.
  - Correção do problema de **aliasing** que ocultava pacotes simultâneos.
  - Implementação de **multiplexagem de métricas** no OMNeT++ via `NetworkNode.cc` e `MosaikBridge.cc`.
  - Atualização dos scripts `plot_results.py` e `plot_results_star.py` para desempacotar e plotar múltiplos pontos por step.
  - Início da implementação da **CLI `plataforma.py`** para abstrair a operação do ambiente Docker e simplificar o uso por pesquisadores.

### 📈 Evidências / resultados

- Progresso atual: **90%**.
- Os gráficos passaram a representar com fidelidade os eventos simultâneos do simulador, eliminando a sobreposição incorreta dos dados.
- Foi concluído um protótipo inicial do menu interativo da plataforma para os cenários 1, 2 e 3.
- A etapa foi reportada como **em transição**, com o menu ainda em depuração.

### ⚠️ Dificuldades / bloqueios

- Falhas na abertura das portas **5678 (Mosaik)** e **8000 (AMS)** ao executar via Docker, associadas a temporização e ao escopo do bloco `__main__`.
- Problemas na inicialização do PADE com o comando `start-runtime-detailed`, exigindo ajuste para a sintaxe oficial e flags corretas de porta.
- Erros de `ModuleNotFoundError` no container do Mosaik, indicando necessidade de garantir dependências gráficas como `matplotlib` também em modo ocioso.

### 🧩 Próximas ações para concluir

- Estabilizar a inicialização do motor PADE via CLI, garantindo a abertura correta do socket.
- Finalizar a blindagem do container `mosaik_master` para suportar bibliotecas gráficas em qualquer cenário.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Melhorias estruturais e funcionais na **interface Home do OpenTES-TSDQ** com foco em organização do fluxo e experiência de uso.
  - Reestruturação da lógica de **pré-visualização das séries temporais**.
  - Organização do fluxo de processamento para evitar chamadas redundantes.
  - Correção de erros de carregamento de mídia no Streamlit.
  - Investigação e correção de erros envolvendo `KeyError`.
  - Ajustes de sincronização com Git e GitHub.

### 📈 Progresso reportado

- Progresso atual: **72%**.
- Principais entregas reportadas:
  - melhoria da navegação e leitura dos dados na Home;
  - separação mais clara entre leitura, preparação e visualização das séries;
  - ampliação da funcionalidade de pré-visualização da série;
  - correção do erro `MediaFileStorageError`;
  - refinamento estrutural do código visando maior modularidade.

### ⚠️ Dificuldades / bloqueios

- Problemas no gerenciamento interno de arquivos de mídia do Streamlit.
- Dificuldade em reorganizar o fluxo de processamento sem redundância.
- Necessidade de evitar chamadas desnecessárias das funções de preparação.
- Ajustes na disposição das tabelas de pré-visualização para melhorar a experiência do usuário.

### 🧩 Próximas ações para concluir

- Continuar a modularização da interface do OpenTES-TSDQ.
- Implementar melhorias nas visualizações gráficas 2D e 3D.
- Aprimorar o tratamento automático de colunas e unidades.
- Desenvolver novas funcionalidades para análise de qualidade de energia.
- Estruturar validações adicionais para leitura de arquivos.
- Prosseguir com os testes da aplicação em diferentes bases de dados.

### 📅 Prazo

- Data de entrega pretendida: **22/05/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Organização conceitual e didática da próxima fase da pesquisa, com foco no início da trilha de **OMNeT++** e consolidação da arquitetura **PADE + Mosaik + OMNeT++**, preparando a entrada futura do **OpenDSS via `py-dss-interface`**.
  - Validação das helpers de threading do PADE.
  - Adaptação e validação do `opendss_example_07` com `defer_to_thread`.
  - Inspeção da estrutura local do projeto `tscc-com-opentes`.
  - Criação da pasta `Treino/` e dos materiais `00`, `01` e `02` para estudo progressivo de OMNeT++.
  - Ampliação da documentação explicativa de `mosaik-dir` e `omnet-dir`.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **55%**.

| Módulo/Atividade | Status | Observação |
|---|---|---|
| **Threading do PADE** | ✅ Validado | Helpers como `call_later`, `call_in_thread`, `call_from_thread` e `defer_to_thread` foram testadas |
| **`opendss_example_07`** | ✅ Atualizado | Avaliação OpenDSS migrada para thread sem bloquear o reactor |
| **Arquitetura `PADE -> Mosaik -> OMNeT++`** | ✅ Mapeada | Fluxo atual do projeto compreendido |
| **Trilha de OMNeT++** | ✅ Iniciada | Materiais `00`, `01` e `02` criados em `Treino/` |
| **Documentação do projeto** | ✅ Ampliada | `README.md` explicativos criados em `mosaik-dir` e `omnet-dir` |
| **Integração futura com OpenDSS** | 🟡 Planejada | Papel via `py-dss-interface` definido conceitualmente |

### ⚠️ Dificuldades / bloqueios

- O mini relatório não registra bloqueios técnicos específicos no projeto, mas indica impacto de dificuldades pessoais/acadêmicas no ritmo da semana.
- A etapa atual concentrou-se mais em reduzir incertezas arquiteturais e organizar a trilha didática do que em integração prática.

### 🧩 Próximas ações para concluir

- Consolidar o entendimento de `first.py`, `omnet_wrapper.py`, `MosaikBridge.cc` e `NetworkNode.cc`.
- Decidir se o próximo treino será focado em **ZMQ/lock-step** ou em mudanças controladas no `NetworkNode.cc`.
- Avaliar a criação de uma `venv` própria para a trilha do TSCC.
- Refinar a compreensão do passo temporal do OMNeT++ no fluxo do Mosaik.
- Preparar o desenho da futura entrada do OpenDSS via `py-dss-interface`.
- Só então iniciar a integração progressiva entre comunicação simulada e cálculo elétrico.

### 📅 Prazo

- Continuidade da trilha inicial de **OMNeT++** e aprofundamento do TSCC: **maio/2026**.

---

## 4) 👨‍💻 Paulo Victor Pereira Lima (TSRE)

### ✅ Tarefas principais

- Migração do código de automação de alocação de **painéis fotovoltaicos (PVs)** de notebook para **script Python estruturado**, com foco em modularidade, robustez e preparação para simulações no OpenDSS.
  - Criação da classe modular `PVGenerator`.
  - Otimização de laços de repetição com **list comprehensions**.
  - Tratamento avançado de strings para nomes de barras elétricas, evitando duplicações no OpenDSS.
  - Implementação de validações de dados de entrada para reduzir falhas em tempo de execução.

### 📈 Progresso reportado

- Progresso atual: **80%**.
- Principais avanços reportados:
  - código mais limpo, eficiente e performático para processamento de grandes volumes de dicionários;
  - filtragem dinâmica para gerenciamento de barras ocupadas e disponíveis;
  - diretrizes de robustez para proteção de memória e consistência da rede;
  - documentação técnica padronizada em inglês.

### ⚠️ Dificuldades / bloqueios

- **Nenhum bloqueio crítico ativo foi informado.**
- O foco restante está na consolidação dos mecanismos de blindagem e validação estrutural dos parâmetros de entrada.

### 🧩 Próximas ações para concluir

- Implementar rotinas automáticas de validação e verificação de integridade estrutural dos parâmetros de entrada.
- Automatizar o gerenciamento e a criação do ambiente de diretórios para leitura e escrita de dados.
- Executar o pipeline de simulação na rede IEEE 13 barras, consolidar os arquivos de saída e validar os resultados de injeção de potência.

### 📅 Prazo

- Data de entrega pretendida: **22/05/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Avançaram na fidelidade da telemetria da co-simulação ao eliminar o aliasing por meio de multiplexagem de métricas.
  - Também iniciaram a CLI da plataforma para abstrair a operação do ambiente Docker.
  - O principal ponto pendente está na estabilização da inicialização do PADE e das dependências do container Mosaik.
  - Progresso: **90%**.

- **Luiz Alberto (TSDQ)**
  - Melhorou a interface Home do dashboard, reorganizando o fluxo de processamento e corrigindo erros de visualização no Streamlit.
  - O foco agora é continuar a modularização da interface, robustecer a leitura de dados e evoluir as visualizações.
  - Prazo: **22/05/2026** — progresso em **72%**.

- **Douglas Barros (TTESO/PADE)**
  - Direcionou a semana para organização arquitetural, validação de threading no PADE e início formal da trilha didática de OMNeT++.
  - O trabalho reduziu incertezas sobre a integração futura entre **PADE, Mosaik, OMNeT++ e OpenDSS**.
  - Prazo: **maio/2026** — progresso geral **55%**.

- **Paulo Victor (TSRE)**
  - Estruturou a migração da automação de alocação de PVs para um script Python modular e mais robusto.
  - A etapa atual está próxima da conclusão e segue sem bloqueios críticos ativos.
  - Prazo: **22/05/2026** — progresso em **80%**.
