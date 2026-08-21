---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-08-14)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-08-14**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Evolução da plataforma **`tscc-com-opentes`** em duas frentes:
  - Continuidade da redação do artigo científico e revisão técnica da base de código.
  - Mapeamento espacial dos agentes e refatoração dos painéis de visualização da telemetria.
- Implementação de um grid geográfico bidimensional de **1000 x 1000 m**, com o nó central fixo no centro e nós periféricos distribuídos aleatoriamente.
- Integração entre a distância euclidiana dos nós e a física da rede no **OMNeT++**, aplicando atraso de propagação e probabilidade de descarte por atenuação.

### 📈 Evidências / resultados

- Progresso percentual **não informado** no mini relatório; a redação do artigo permanece em andamento.
- Geração automática de **`posicoes.json`**, utilizado tanto pelo gerador de cenário Mosaik quanto pelos scripts de análise.
- O dashboard foi reestruturado com faixa min/max de latência, boxplot de jitter, tabela comparativa de perfis de rede e heatmap geoespacial de latência.
- Cada execução passa a exportar uma visão geral e visões individuais para os perfis **Cabeada, 5G, 4G e IoT**.
- A plataforma passou a correlacionar distância física, latência e descarte de pacotes, além de instanciar dinamicamente dezenas de agentes PADE e seus respectivos clones no OMNeT++.

### ⚠️ Dificuldades / bloqueios

- O mini relatório não descreveu bloqueios pendentes ou dificuldades ativas.
- A topologia atual ainda está restrita ao formato estrela, com um nó central e nós periféricos a um salto; essa limitação é o principal ponto técnico a ser expandido.

### 🧩 Próximas ações para concluir

- Generalizar o gerador de cenários para suportar topologias em **malha, anel e árvore hierárquica**.
- Avaliar como padrões distintos de dependência causal entre os simuladores impactam a sincronização e a física de rede.
- Prosseguir com a redação do artigo científico.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Atualização visual do **Mapa de Rede** na plataforma de análise da qualidade, reorganizando as informações em cards para tornar a navegação mais simples e intuitiva.
- Desenvolvimento do programa **`aplicar_hash_topologia.py`**, que calcula o hash **SHA-256** do arquivo CSV e o registra nos metadados do JSON.
- Implementação da leitura do hash pela interface para verificar se os arquivos JSON e CSV produzidos pela co-simulação correspondem entre si, permitindo ou impedindo a leitura dos dados conforme essa validação.

### 📈 Progresso reportado

- Progresso atual: **75%**.
- Foram concluídos testes unitários, a reorganização visual do Mapa de Rede e a implementação da leitura do hash.
- O vínculo criptográfico entre os arquivos de saída aumenta a rastreabilidade dos resultados e reduz o risco de análise sobre dados de execuções diferentes.

### ⚠️ Dificuldades / bloqueios

- O mini relatório não registrou dificuldades técnicas ou bloqueios explícitos.
- A validação preliminar dos resultados com o orientador permanece pendente.

### 🧩 Próximas ações para concluir

- Unificar as duas páginas atuais para fornecer uma visualização mais integrada.
- Migrar funções da página **Análise Elétrica** para o **Mapa de Rede**.
- Estudar a reestruturação dos blocos da nova página.

### 📅 Prazo

- Data de entrega pretendida: **28/08/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Portabilidade e validação da camada de **mercado transativo (SiMTES)** na plataforma de co-simulação modernizada.
  - Transição de um controle Volt/Var local em 13 barras para um mercado com **33 agentes** numa rede de **75 barras**.
  - Implementação dos modelos de otimização de prosumidor, concentrador e DSO, com decomposição dual e descoberta distribuída do preço sobre FIPA.
  - Reconstrução da rede LPWA **6TiSCH** da tese de referência no OMNeT++.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **100%**.
- Foram realizados **23 commits**, abrangendo **249 arquivos** e aproximadamente **26.600 linhas**.
- A rede da tese foi convertida e validada barra a barra em OpenDSS; também foram implementadas a matriz de sensibilidade de tensão, liquidação das transações e preço locacional.
- O resultado central da tese foi reproduzido: os pontos com tensão abaixo de **0,97 pu** caíram de **337 para zero**, e a tensão mínima às 17:45 subiu de **0,93946 para 0,97033 pu**.
- Experimentos reconciliaram divergências de preço sombra e número de rodadas, identificando o modelo estocástico como fator dominante no preço e o critério de parada como causa principal da diferença de convergência.
- A avaliação da comunicação revelou que a mensagem de negociação de **35.663 bytes** sofre **99,93% de perda** em enlace aceito pela referência; para viabilizar a chamada, o tamanho deve cair para aproximadamente **500 bytes**.

### ⚠️ Dificuldades / bloqueios

- A camada de comunicação ainda não é adequada para trafegar a negociação completa na rede de referência, tornando a redução das mensagens uma necessidade de projeto.
- Foram identificados e documentados problemas já tratados: regeneração incorreta da adjacência da rede, atalho que fazia o ciclo 2 ignorar a rede, negociação encerrada antes da convergência e três falhas de concorrência envolvendo OpenDSS, ZeroMQ e o relógio do OMNeT++.
- Há necessidade de refinamento adicional da comunicação antes de testes completos em redes maiores.

### 🧩 Próximas ações para concluir

- Reduzir o tamanho das mensagens de negociação para viabilizar seu tráfego na rede 6TiSCH.
- Realizar testes de mercado em rede menor.
- Remover a camada estocástica e tornar o comportamento do banco de baterias determinístico por meio de MILP com CPLEX.

### 📅 Prazo

- **Não informado.**

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Integraram o posicionamento espacial dos agentes à simulação de rede e elevaram a capacidade analítica dos dashboards de telemetria.
  - O próximo avanço é generalizar a topologia, hoje limitada à configuração estrela, enquanto prossegue a redação do artigo.
  - Progresso: **não informado**.

- **Luiz Alberto (TSDQ)**
  - Reorganizou o Mapa de Rede e adicionou validação criptográfica entre os arquivos JSON e CSV da co-simulação.
  - A frente está em **75%**, com validação junto ao orientador e unificação das páginas como próximos marcos.
  - Prazo: **28/08/2026**.

- **Douglas Barros (TTESO/PADE)**
  - Concluiu a implementação e validação do mercado transativo em 75 barras, reproduzindo o resultado de tensão da tese e evidenciando quantitativamente as limitações de comunicação.
  - O trabalho futuro concentra-se em reduzir mensagens e refinar a comunicação para permitir negociações completas na rede de referência.
  - Progresso: **100%**.
