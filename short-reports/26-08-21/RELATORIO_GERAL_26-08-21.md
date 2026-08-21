---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos
  passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-08-21)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-08-21**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Evolução da plataforma **`tscc-com-opentes`** a partir das sugestões da última
  reunião.
  - Inclusão de um menu interativo para configurar a co-simulação, escolhendo
    topologia, quantidade de agentes e tipos de rede.
  - Generalização da geração de cenários com a modelagem das topologias em
    **malha** e **anel**, além da topologia estrela existente.
- Continuidade da redação do artigo científico.

### 📈 Evidências / resultados

- Progresso percentual **não informado** no mini relatório.
- O menu de configuração foi implementado e permite parametrizar a execução
  antes da co-simulação.
- A plataforma mantém a capacidade de instanciar dinamicamente dezenas de
  agentes PADE e seus clones físicos no OMNeT++, com perfis heterogêneos de
  comunicação.
- A generalização de topologias foi concluída no nível de modelagem para malha e
  anel.

### ⚠️ Dificuldades / bloqueios

- O mini relatório não descreveu dificuldades técnicas ou bloqueios explícitos.
- Os testes das topologias modeladas ainda não foram realizados, portanto a
  validação operacional de malha e anel permanece pendente.

### 🧩 Próximas ações para concluir

- Executar testes para as diferentes topologias.
- Incorporar os gráficos e as atualizações da plataforma ao artigo científico.
- Prosseguir com a redação do artigo.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Finalização da elaboração do artigo de **indicadores** para submissão ao **CBA
  2026**.
- Continuidade dos estudos para estruturar a interface de análise em página
  única, centralizando as funcionalidades hoje distribuídas.

### 📈 Progresso reportado

- O modelo final do artigo foi preparado para revisão da orientadora, como etapa
  anterior à submissão.
- Foram realizados testes unitários.
- O mini relatório não informou percentual de progresso.

### ⚠️ Dificuldades / bloqueios

- O mini relatório não registrou dificuldades técnicas ou bloqueios explícitos.
- Permanecem pendentes a documentação do código, a padronização automática de
  unidades, a correção da autoescala, o manual de colunas, a integração de
  métricas de comunicação e a validação dos resultados com o orientador.

### 🧩 Próximas ações para concluir

- Submeter o artigo de indicadores após a revisão da orientadora; o encerramento
  da submissão foi informado para **22/08/2026**.
- Unificar a interface e finalizar o estudo da reorganização dos blocos de
  programação.
- Otimizar a estrutura da interface centralizada.

### 📅 Prazo

- Data de entrega pretendida: **28/08** (ano não informado).

---

## 3) 👨‍💻 Paulo Victor (TSRE)

### ✅ Tarefa principal

- Preparação de uma rede elétrica real proveniente da **BDGD** para integração à
  co-simulação.
  - Seleção de um alimentador da subestação **Aldeota (ADT)**, região
    caracterizada por alta densidade de cargas e potencial para expansão de
    carregadores veiculares.
  - Importação e análise dos dados da Enel CE a partir da subestação.
  - Conversão para **OpenDSS** com `bdgd2opendss` e análise dos **14
    alimentadores** da subestação ADT.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **60%**.
- Foram documentados o código e o processo de seleção e análise da rede.
- A análise dos alimentadores foi concluída e resultou na escolha de um
  alimentador para a próxima etapa da integração.
- As ferramentas empregadas incluem **Python, BDGD, OpenDSS e QGIS**.

### ⚠️ Dificuldades / bloqueios

- O mini relatório não apontou dificuldades técnicas ou bloqueios explícitos.
- Testes unitários, atualização de container e validação preliminar com o
  orientador ainda estão pendentes.

### 🧩 Próximas ações para concluir

- Filtrar os arquivos de simulação gerados.
- Integrar os scripts à co-simulação.
- Integrar a rede **IEEE LV** à co-simulação para os EUs.

### 📅 Prazo

- Data de entrega pretendida: **28/08/2026**.

---

## 4) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Ajuste da implementação do mercado transativo na **MVLV75** e comparação
  rigorosa com as Figuras 55 a 59 e Tabelas 20 e 21 da tese de referência.
  - Criação das redes próprias **BT16** e **BT38** para testes.
  - Adaptação das figuras de energia, preço, tamanho e tempo de mensagens para o
    formato da referência.
  - Primeira execução completa de `./run.sh market` na rede **6TiSCH**
    publicada.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **80%**.
- A negociação na rede 6TiSCH convergiu em **35 rodadas**, com **40
  retransmissões**, preservando o resultado elétrico do canal ideal: violações
  de tensão de **337 para zero** e tensão mínima de **0,93946 para 0,97033 pu**.
- A participação do mercado bilateral aumentou de **0,6% para 21,6%** da energia
  após a correção que incluiu os 43 prosumidores sem bateria na negociação.
- Foram corrigidos quatro defeitos de fidelidade: tráfego artificial do
  `sniffer`, leitura incompleta das classes de tamanho de mensagens, exclusão
  indevida de prosumidores sem bateria e falha tardia após perda de proposta.
- A comparação por nó com a tese foi considerada inválida por uma divergência
  irrecuperável nos dados publicados: as curvas de carga são, em grande parte,
  as mesmas, mas atribuídas a nós diferentes. As comparações agregadas
  permanecem válidas e aderentes.

### ⚠️ Dificuldades / bloqueios

- O CFP ainda possui **35,7 kB** e não foi reduzido; esse tamanho impede uma
  comunicação confiável em enlaces desfavoráveis.
- O roteamento pela raiz ainda não foi implementado como alternativa comparável
  ao caminho direto.
- A mediana de tempo de recepção continua em **3,9 s**, abaixo dos cerca de 20 s
  observados na tese; o limite máximo foi reproduzido, mas não a distribuição
  central.

### 🧩 Próximas ações para concluir

- Reduzir o CFP, enviando a cada concentrador somente os valores necessários e
  evitando o reenvio de `p_init`; a estimativa é reduzir de **35.663 bytes / 281
  quadros** para cerca de **3,6 kB / 29 quadros**.
- Implementar o roteamento pela raiz como opção, mantendo o roteamento direto
  para comparação mensurável.

### 📅 Prazo

- **Não informado.**

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Adicionaram menu configurável e modelaram as topologias em malha e anel,
    ampliando a flexibilidade da co-simulação.
  - A prioridade imediata é validar as novas topologias por testes e registrar
    as atualizações no artigo.
  - Progresso: **não informado**.

- **Luiz Alberto (TSDQ)**
  - Preparou o modelo final do artigo de indicadores para revisão e submissão ao
    CBA 2026, enquanto avança na concepção da interface unificada.
  - A submissão depende da revisão da orientadora; o trabalho de interface segue
    como próxima frente.
  - Progresso: **não informado**; prazo da entrega: **28/08**.

- **Paulo Victor (TSRE)**
  - Selecionou e preparou um alimentador real da subestação ADT a partir da
    BDGD, com conversão e análise em OpenDSS.
  - A integração dos scripts e da rede escolhida à co-simulação é o próximo
    marco.
  - Progresso: **60%**; prazo: **28/08/2026**.

- **Douglas Barros (TTESO/PADE)**
  - Corrigiu quatro defeitos de fidelidade e demonstrou a execução ponta a ponta
    do mercado sobre a rede 6TiSCH, mantendo o resultado elétrico validado.
  - A redução do CFP e a comparação entre roteamento direto e pela raiz são os
    pontos pendentes para refinar a aderência da comunicação à referência.
  - Progresso: **80%**.
