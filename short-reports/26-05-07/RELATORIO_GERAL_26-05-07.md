---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-05-07)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-05-07**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Consolidação da infraestrutura de **co-simulação com foco em métricas de rede,
  escalabilidade e congestionamento**, com ênfase no ambiente **OMNeT++ + PADE +
  Docker**.
  - Implementação de **largura de banda configurável** no OMNeT++.
  - Criação de lógica para **perda de pacotes** e **jitter**.
  - Atualização do script de plotagem para exibir métricas de eficiência e
    jitter.
  - Validação de cenários com **topologia estrela** e múltiplos agentes.
  - Simulação de **congestionamento** com redução de largura de banda.

### 📈 Evidências / resultados

- Progresso atual: **100%**.
- As **3 issues planejadas** foram concluídas.
- O ambiente foi reportado como **estável e pronto para cenários de pesquisa**.
- Houve evolução da co-simulação para cenários mais complexos, incluindo perda de
  pacotes, jitter e limitação de banda.

### ⚠️ Dificuldades / bloqueios

- **Nenhum bloqueio ativo foi informado.**

### 🧩 Próximas ações para concluir

- **Não foram informadas novas ações**, indicando fechamento da etapa atual.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Evolução do sistema de **leitura, interpretação e visualização de dados de
  co-simulação** no dashboard Streamlit.
  - Atualização do arquivo de **mapeamento dinâmico (`mapeamento.json`)**.
  - Adequação do parser para leitura automática de grandezas elétricas com
    **regex**.
  - Revisão da padronização de colunas e metadados nos arquivos CSV.
  - Melhoria do algoritmo de **autoescala de unidades** e do ajuste dinâmico do
    eixo Y.
  - Atualização do manual técnico em **LaTeX**.
  - Implementação inicial de uma nova interface para leitura de dados do
    **OMNeT++**.

### 📈 Progresso reportado

- Progresso atual: **80%**.
- Principais entregas reportadas:
  - mapeamento dinâmico via JSON e regex;
  - correção de ambiguidades entre potência da rede e geração;
  - melhoria da visualização gráfica com autoescala;
  - nova aba de comunicação no dashboard;
  - integração inicial com CSVs exportados pelo OMNeT++.

### ⚠️ Dificuldades / bloqueios

- Ambiguidade inicial entre padrões regex de potência ativa da rede e geração.
- Inconsistências entre unidades descritas no manual e aquelas presentes nos
  arquivos CSV.
- Necessidade de tratamento específico para grandezas sem identificação explícita
  de fase.
- Ajustes no algoritmo de autoescala para evitar conversões incorretas em sinais
  de baixa magnitude.
- Tratamento de arquivos híbridos com dados numéricos, texto e estruturas JSON
  oriundos do OMNeT++.
- Necessidade de refinar pivotamento e filtragem de variáveis válidas na nova
  interface de comunicação.

### 🧩 Próximas ações para concluir

- Expandir os recursos de visualização da comunicação com indicadores
  estatísticos e eventos de troca de mensagens.
- Validar os resultados com conjuntos reais de dados de co-simulação.
- Corrigir o erro de análise ainda existente na parte de comunicação.

### 📅 Prazo

- Data de entrega pretendida: **22/05/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Evolução prática da trilha de pesquisa com **PADE 3.0 + OpenDSS**, com foco na
  transição de exemplos introdutórios para **arquiteturas multiagente mais
  próximas da tese de Lucas Silveira Melo**, além da preparação conceitual da
  futura camada de comunicação com **OMNeT++**.
  - Consolidação da trilha com `py-dss-interface`.
  - Implementação e validação dos exemplos `opendss_example_06` a
    `opendss_example_10`.
  - Estruturação de cenários com **DSO**, **prosumidores**, **agregador** e
    rodadas de negociação.
  - Ajuste dos logs para uso de identificadores de mensagens mais legíveis.
  - Registro inicial do plano técnico da futura integração **PADE + OpenDSS +
    OMNeT++**.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **50%**.

| Módulo/Atividade | Status | Observação |
|---|---|---|
| **Trilha `py-dss-interface`** | ✅ Consolidada | Exemplos introdutórios estruturados, explicados e validados |
| **Exemplo 06** | ✅ Validado | Caso mínimo entre lógica de decisão e OpenDSS |
| **Exemplo 07** | ✅ Validado | Primeiro fluxo real entre agentes PADE e OpenDSS |
| **Exemplo 08** | ✅ Validado | IEEE 13 com coordenador de preço, prosumidores e DSO |
| **Exemplo 09** | ✅ Validado | Rodadas com múltiplas restrições elétricas |
| **Exemplo 10** | ✅ Validado | Agregador e contraoferta progressiva do DSO |
| **Planejamento PADE + OpenDSS + OMNeT++** | ✅ Iniciado | Arquitetura-alvo descrita, sem introduzir OMNeT++ no laço ainda |

### ⚠️ Dificuldades / bloqueios

- A principal dificuldade passou a ser a **modelagem arquitetural dos agentes**,
  evitando que os exemplos fossem apenas scripts elétricos com troca superficial
  de mensagens.
- A preservação da legibilidade dos logs exigiu cuidado extra com os
  identificadores de mensagens e compatibilidade com o comportamento legado do
  PADE.
- Os exemplos `09` e `10` demandaram várias iterações até encontrar um equilíbrio
  didático entre aceitação e rejeição das propostas pelo DSO.
- O uso do **OMNeT++** foi conscientemente adiado para evitar misturar, cedo
  demais, problemas elétricos, lógicos e de comunicação.

### 🧩 Próximas ações para concluir

- Consolidar o entendimento didático do `opendss_example_10`, com foco no papel
  do agregador e da contraoferta do DSO.
- Registrar formalmente nas issues os resultados obtidos com os exemplos `07` a
  `10`.
- Revisar se ainda vale criar um exemplo intermediário antes do OMNeT++.
- Iniciar uma trilha básica e pedagógica de **OMNeT++**.
- Definir a interface mínima futura entre **PADE** e **OMNeT++**.
- Retomar depois a integração progressiva entre **PADE + OpenDSS + OMNeT++**.

### 📅 Prazo

- Término dos estudos iniciais de **OpenDSS + PADE** e início da trilha de
  **OMNeT++** estimados em: **maio/2026**.

---

## 4) 👨‍💻 Paulo Victor Pereira Lima (TSRE)

### ✅ Tarefas principais

- Continuidade das atividades de **co-simulação elétrica com OpenDSS/mosaik**,
  automação de tratamento de dados fotovoltaicos e estudo do **OpenDER**.
  - Correção de inconsistências na implementação com **inversores inteligentes**
    na rede IEEE 13 barras.
  - Desenvolvimento da segunda parte do script para automatização do tratamento
    de dados e criação de geradores FV.
  - Execução da **co-simulação do sistema IEEE 123 barras com containers**.
  - Continuidade do estudo da interface **OpenDER**.

### 📈 Progresso reportado

| Frente de trabalho | Progresso |
|---|---|
| Execução da co-simulação do sistema IEEE 123 barras com containers | **100%** |
| Estudo da interface OpenDER | **20%** |
| Implementação da co-simulação com inversores inteligentes no sistema IEEE 13 barras | **100%** |
| Primeira parte do script para tratamento dos dados e criação dos geradores FV | **100%** |
| Segunda parte do script para tratamento dos dados e criação dos geradores FV | **90%** |

- Também foi apresentado um comparativo quantitativo entre **OpenDSS puro** e
  **co-simulação sem Volt-Var** na barra monitorada 680 da IEEE 13 barras,
  incluindo métricas como **RMSE**, **MAE**, **desvio padrão** e **erro médio**.

### ⚠️ Dificuldades / bloqueios

- O mini relatório **não registra bloqueios ativos de forma explícita**.
- Ainda assim, o trabalho indica necessidade de refinamento final no código de
  geração dos PVs e continuidade da validação do cenário em containers.

### 🧩 Próximas ações para concluir

- Comentar melhor, descrever funções e organizar em um arquivo `.py` o código de
  geração dos PVs.
- Rodar o sistema IEEE 13 barras em containers.

### 📅 Prazo

- Data de entrega pretendida: **15/05/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Concluíram uma etapa de consolidação da co-simulação com foco em
    **congestionamento, escalabilidade, jitter e perda de pacotes**.
  - O ambiente foi reportado como estável e pronto para cenários de pesquisa.
  - Progresso: **100%**; sem bloqueios ativos informados.

- **Luiz Alberto (TSDQ)**
  - Avançou na padronização de metadados, no parser dinâmico via regex/JSON e na
    integração inicial com dados de comunicação vindos do **OMNeT++**.
  - O principal esforço agora está em robustecer a nova aba de comunicação e
    validar os resultados com dados reais.
  - Prazo: **22/05/2026** — progresso em **80%**.

- **Douglas Barros (TTESO/PADE)**
  - Consolidou a trilha prática **PADE + OpenDSS** com exemplos progressivamente
    mais complexos, já aproximando a arquitetura do desenho metodológico da
    pesquisa.
  - O próximo salto será estruturar a entrada do **OMNeT++** sem perder a clareza
    experimental já conquistada.
  - Prazo: **maio/2026** — progresso geral **50%**.

- **Paulo Victor (TSRE)**
  - Avançou fortemente na automação de dados FV e na co-simulação com
    **inversores inteligentes**, além de concluir a execução do sistema IEEE 123
    barras em containers.
  - O estudo do **OpenDER** segue em estágio inicial e a segunda parte do script
    de geração dos PVs está próxima da conclusão.
  - Prazo: **15/05/2026**.
