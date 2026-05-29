---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-05-29)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-05-29**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Refatoração do protocolo de comunicação entre agentes **PADE** na simulação `tscc-com-opentes`, substituindo o transporte manual de mensagens ACL via Mosaik pelo uso do **protocolo FIPA nativo**.
  - Identificação dos métodos próprios que anteriormente contornavam o protocolo FIPA em `pade_sim.py` e `pade_star.py`.
  - Reescrita da lógica de comunicação para alinhamento com o padrão observado na simulação de referência baseada na tese da profa. Janaína Almada.
  - Preparação da base para padronizar a comunicação entre agentes em linha com a arquitetura esperada do OpenTES.

### 📈 Evidências / resultados

- Progresso atual: **90%**.
- Os arquivos `pade_sim.py` e `pade_star.py` foram reestruturados com o uso do protocolo FIPA nativo, reduzindo a dependência do transporte manual anterior.
- O trabalho desta semana concentrou-se em alinhar a implementação com uma referência acadêmica já validada, o que fortalece a consistência da camada de comunicação.

### ⚠️ Dificuldades / bloqueios

- O principal ponto em aberto é a **ausência de validação prática completa** da nova implementação.
- O relatório não aponta falhas funcionais específicas já diagnosticadas, mas o ambiente segue em transição e debugging até que o fluxo completo seja executado com sucesso.

### 🧩 Próximas ações para concluir

- Validar a execução completa com `docker compose up --build`, sem erros.
- Fechar as issues atualmente atribuídas ao time.
- Documentar no `README` o padrão **PADE + Mosaik + FIPA** para reutilização futura.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Continuidade do desenvolvimento da interface Streamlit do projeto **`tsdq-dataview-opentes`**, com foco simultâneo em **análise elétrica**, **indicadores de qualidade de energia elétrica (QEE)** e nova **página de comunicação** para dados da co-simulação.
  - Implementação e refinamento dos cards de QEE.
  - Correção de verificações de potência e ajustes em cards de tensão, corrente, potência ativa, potência reativa, potência FV, gerador, fator de potência e frequência.
  - Correção de plotagens e melhora parcial do algoritmo de escalas e autoescala de unidades.
  - Inclusão da página de comunicação com leitura de `results.csv`, validação mínima de colunas, processamento temporal por origem e desempacotamento de mensagens FIPA-ACL.
  - Cálculo de KPIs de comunicação, como pacotes enviados, recebidos e dropados, taxa de drop, latência média e jitter médio.

### 📈 Progresso reportado

- Progresso atual: **75%**.
- A interface passou a oferecer um painel de QEE mais completo, com indicadores globais e por barra monitorada.
- Foram adicionadas visualizações interativas para comunicação e uma aba de dados processados, ampliando a capacidade de inspeção da co-simulação.
- Houve avanço tanto na robustez da interface quanto na integração entre análise elétrica e análise de comunicação.

### ⚠️ Dificuldades / bloqueios

- Necessidade de tratar diferentes formatos e ausências de colunas nos arquivos de entrada.
- Ajustes sucessivos de escala, unidades e plotagem para manter coerência visual e semântica dos indicadores.
- Dependência de validação com dados reais adicionais para confirmar o comportamento da nova página de comunicação em cenários diversos.
- Testes automatizados e validação final com o orientador ainda permanecem pendentes.

### 🧩 Próximas ações para concluir

- Validar funcionalmente a página de comunicação com novos arquivos.
- Revisar problemas de encoding e acentuação na interface.
- Adicionar testes automatizados para processamento elétrico e de comunicação.
- Melhorar a padronização visual dos cards e gráficos.
- Consolidar a documentação de uso da interface.
- Implementar funções adicionais para análise de **DRP**, **DRC**, **P1** e **P99**.

### 📅 Prazo

- Data de entrega pretendida: **03/06/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Evolução da integração do repositório agregador **`co-simulation-opentes`**, com refatoração para uma **topologia de 4 containers**, migração do controlador do TSRE para **agente PADE** e absorção/validação do cenário **IEEE 13 Bus + Smart PV**.
  - Separação funcional dos domínios em `comm`, `pade`, `mosaik` e `grid`.
  - Fragmentação do TSCC e consolidação dos collectors na camada Mosaik.
  - Migração do `BatteryControllerSim` para `controller_agent.py`.
  - Adaptação do cenário IEEE 13 + Smart PV para a nova arquitetura.
  - Criação de cenário integrado, script robusto de execução e dashboard de resultados.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **40%**.
- Os quatro componentes já operam de forma integrada sobre o IEEE 13 Bus, com coleta simultânea de dados elétricos e de comunicação.
- A validação física indicou coerência da geração fotovoltaica e das tensões de barra no cenário integrado.
- O repositório saiu de uma fase de integração estrutural para um estágio operacional executável de ponta a ponta.

### ⚠️ Dificuldades / bloqueios

- Foram enfrentados problemas relevantes de integração, incluindo CSV elétrico vazio, erro `cannot progress backwards`, limitações de simuladores `--remote` e falhas de rede do Docker Compose.
- O ponto técnico mais importante ainda em aberto é o **inversor OpenDER com `P_ac = 0`**, impedindo o fechamento correto do acoplamento do inversor com a rede.
- Os logs da camada TSCC seguem excessivamente verbosos.
- A etapa de acoplamento causal entre decisão dos agentes e resposta elétrica da rede ainda não foi concluída.

### 🧩 Próximas ações para concluir

- Investigar, junto ao TSRE, por que o inversor OpenDER não injeta potência.
- Fechar o acoplamento inversor → OpenDSS para que a injeção venha da co-simulação.
- Implementar o acoplamento causal entre decisões dos agentes e o despacho na rede.
- Padronizar o formato dos CSVs e reduzir a verbosidade dos logs.
- Evoluir o payload dos agentes para mensagens com semântica elétrica e econômica.

### 📅 Prazo

- Acoplamento causal agente → rede e investigação do inversor: **primeiras semanas de junho/2026**.

---

## 4) 👨‍💻 Paulo Victor Pereira Lima (TSRE)

### ✅ Tarefas principais

- Continuidade da integração de **dados climáticos reais** ao script de automação da criação e conexão de **geradores fotovoltaicos** no cenário de co-simulação do **IEEE 13 barras**.
  - Estruturação do diretório padrão de saída em `data/13Bus`.
  - Robustecimento do algoritmo de geração automatizada dos PVs.
  - Inclusão de validações estruturais e tratamento de entradas para leitura consistente dos perfis climáticos.
  - Continuidade das melhorias no tratamento dinâmico de dados climáticos e adequação dos artefatos gerados ao cenário Mosaik.

### 📈 Progresso reportado

| Frente de trabalho | Progresso |
|---|---|
| Automatização da geração de PVs com dados reais e estruturação de diretórios no IEEE 13 barras | **100%** |
| Melhorias no script para tratamento dinâmico de dados climáticos | **98%** |

- O trabalho está em estágio bastante avançado, com a base de automação praticamente concluída e já orientada para compatibilidade com o cenário de co-simulação.

### ⚠️ Dificuldades / bloqueios

- O relatório não aponta bloqueios críticos de implementação.
- Permanecem apenas ajustes finos relacionados ao uso da simulação com Docker e ao refinamento operacional do ambiente.
- A validação preliminar com o orientador ainda não foi concluída.

### 🧩 Próximas ações para concluir

- Implementar ajustes finais na simulação via Docker.
- Concluir as melhorias restantes no script para tratamento de dados e criação dos geradores FV.
- Adequar as colunas dos arquivos CSV ao padrão definido pelo Beto.

### 📅 Prazo

- Data de entrega pretendida: **05/06/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Reestruturaram a comunicação entre agentes para adotar o protocolo **FIPA nativo** no PADE, substituindo a abordagem manual anterior.
  - O avanço técnico é alto, mas ainda depende da validação prática do fluxo completo no ambiente Docker.
  - Progresso: **90%**.

- **Luiz Alberto (TSDQ)**
  - Expandiu a interface do TSDQ com melhorias em **QEE** e uma nova frente de **análise de comunicação**, incorporando KPIs e visualizações da co-simulação.
  - Restam validações com dados reais, testes automatizados e refinamentos de usabilidade e consistência visual.
  - Prazo: **03/06/2026** — progresso em **75%**.

- **Douglas Barros (TTESO/PADE)**
  - Consolidou uma arquitetura integrada em **4 containers** e deixou a co-simulação do **IEEE 13 Bus** executável de ponta a ponta, com resultados físicos já validados.
  - O principal desafio agora é sair da integração estrutural para o **acoplamento causal real** entre agentes, inversores e rede elétrica.
  - Prazo: **primeiras semanas de junho/2026** — progresso geral **40%**.

- **Paulo Victor (TSRE)**
  - Manteve a frente de geração automatizada de **PVs com dados climáticos reais** em estágio quase concluído, com estruturação de diretórios e robustez adicional no processamento.
  - Restam apenas ajustes finos em Docker, padronização dos CSVs e validação final.
  - Prazo: **05/06/2026**.
