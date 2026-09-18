---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-09-11)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-09-11**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Aprimoramento do script **`menu_streamlit.py`** no repositório **`tscc-com-opentes/development`**, com foco em usabilidade e organização visual da co-simulação.
  - Inserção de **ícones SVG customizados** para representar dinamicamente as topologias e a quantidade de agentes.
  - Melhoria do **ciclo de vida dos gráficos** exibidos na interface, garantindo limpeza dos resultados anteriores ao iniciar nova execução.
  - Atualização do estado da interface para exibir apenas os **PNGs gerados pela execução atual** após a conclusão bem-sucedida da co-simulação.

### 📈 Evidências / resultados

- Progresso percentual **não informado** no mini relatório.
- Foi consolidado um **menu interativo com interface web** para configuração da co-simulação.
- A interface passou a apresentar **preview visual mais robusto das topologias**, com melhor descrição dos agentes.
- A gestão dos resultados visuais ficou mais fluida, evitando sobreposição de gráficos de execuções anteriores.

### ⚠️ Dificuldades / bloqueios

- O mini relatório não detalhou bloqueios técnicos específicos na semana.
- O principal ponto pendente é a etapa de **testes**, ainda marcada como **WIP**.

### 🧩 Próximas ações para concluir

- Realizar os **testes** da nova interface e da lógica de atualização de resultados.
- Incorporar os gráficos e as atualizações implementadas ao **artigo** relacionado ao trabalho.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Continuidade do desenvolvimento do **Mapa de Rede** da plataforma **ARGOS/OpenTES**, com foco no aprimoramento da visualização **D3/JavaScript** e na integração com a **Análise Elétrica**.
  - Refinamento do controle temporal diretamente no grafo D3, com modos de exibição por fase, mínimo, máximo, média e spread.
  - Redução de recarregamentos desnecessários do **Streamlit** por meio de seleção local de nós e sincronização explícita via botão **"Analisar nó"** e duplo clique.
  - Reorganização conceitual das medições e aprimoramento dos cards do Inspetor para barramentos, linhas, transformadores e equipamentos fotovoltaicos.
  - Correção da unidade de irradiância para **`kW/m²`**, preservando os dados originais.

### 📈 Progresso reportado

- Progresso atual: **não informado explicitamente** no mini relatório desta semana.
- A visualização D3 ganhou **maior estabilidade** durante a navegação e preservação do estado temporal e do layout.
- Houve evolução da ferramenta de uma visualização mais estática para um ambiente de **acompanhamento temporal interativo das tensões**.
- Foi criado o **SavePoint 3**, consolidando um novo ponto estável de recuperação do projeto.

### ⚠️ Dificuldades / bloqueios

- O mini relatório registra uma dificuldade, mas o texto foi **interrompido no arquivo original** e não permite recuperar integralmente sua formulação.
- Ainda permanecem pendentes os **testes completos com diferentes cenários de co-simulação**, o que indica que a validação cruzada da solução não foi concluída.

### 🧩 Próximas ações para concluir

- Finalizar os testes com diferentes cenários de co-simulação.
- Prosseguir no refinamento da integração entre grafo D3, Inspetor e componentes de análise elétrica.
- Consolidar a estabilidade da interface para redes maiores e cenários mais diversos.

### 📅 Prazo

- **Não informado.**

---

## 3) 👨‍💻 Paulo Victor (TSRE)

### ✅ Tarefa principal

- Consolidação de uma nova arquitetura de co-simulação distribuída com **Mosaik + OpenDSS**, envolvendo:
  - Seleção e modelagem de alimentadores, com destaque para a subestação **Eusébio (ESB)** e o alimentador **ESB01S4**.
  - Reestruturação da modelagem fotovoltaica com elementos **`PVSystem`** e integração temporal de dados meteorológicos.
  - Estabilização do motor de co-simulação e da infraestrutura **Docker/Mosaik/OpenDSS**.
  - Desenvolvimento do orquestrador **`pipeline_cargas.py`** para geração estocástica de cargas residenciais com base em dados BDGD e telemetria australiana.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **95%**.
- Foram gerados **artefatos CSV e JSON** otimizados para a interface gráfica, com rastreabilidade explícita de barras.
- Houve correção do `entrypoint` do OpenDSS, ajustes de portas Docker e mitigação de conflitos de rede e inicialização do Mosaik.
- O pipeline estocástico incorporou:
  - interpolação **PCHIP** para continuidade temporal;
  - cruzamento e limpeza **in-memory** de dados;
  - alocação de perfis via **Gale-Shapley**;
  - costura suave das curvas na transição de meia-noite;
  - herança entre componentes do modelo **ZIP**, preservando coerência física e reduzindo custo computacional.

### ⚠️ Dificuldades / bloqueios

- Foram enfrentados e mitigados diversos bloqueios técnicos:
  - crash loops e conflitos de rede no **Docker**;
  - travamentos na inicialização de simuladores no **Mosaik**;
  - problemas de parser e testes na integração com **py-dss-interface**;
  - inconsistências nos dados de temperatura e irradiância.
- Permanecem pendentes correções em parte dos dados do **BR-PVGen** e a ampliação dos cenários envolvendo geração FV e veículos elétricos.

### 🧩 Próximas ações para concluir

- Corrigir problemas identificados em dados de **temperatura e irradiância** do BR-PVGen.
- Implementar cenários de penetração de geração FV na rede **IEEE LVTestCase**.
- Integrar **veículos elétricos** à rede com uso de dados reais.

### 📅 Prazo

- Data de entrega pretendida: **18/09/2026**.

---

## 4) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Validação do **mercado transativo** nas redes próprias **BT16** e **BT38**, após a conclusão da etapa com a IEEE 13.
  - Execução da negociação completa com co-simulação envolvendo **PADE**, **Mosaik**, **OMNeT++**, **OpenDSS** e **Pyomo/CPLEX**.
  - Geração das **18 figuras de referência** para cada rede.
  - Verificação funcional do mecanismo para resolução de **subtensão** e **sobretensão**.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **100%**.
- O mercado transativo eliminou completamente as violações na **BT16** e reduziu a **BT38** a um resíduo de apenas **3 leituras** fora da faixa, associado a uma única barra e intervalo.
- A negociação convergiu em **29 rodadas** na BT16 e **32 rodadas** na BT38.
- A comunicação permaneceu operacional dentro das janelas temporais; na BT38, **17 mensagens perdidas** foram recuperadas por retransmissão do concentrador.
- A topologia de rádio foi gerada programaticamente para garantir alcançabilidade total dos agentes nas redes próprias.

### ⚠️ Dificuldades / bloqueios

- Persistem dois defeitos de registro ainda não corrigidos:
  - `deviation_kw` sai zerado quando o leilão é aberto.
  - retransmissões do concentrador ficam fora da contagem.
- Na **BT38**, o resíduo remanescente decorre do erro de linearização do modelo de operação, superior à margem de 1 mpu em um caso pontual.

### 🧩 Próximas ações para concluir

- Iniciar as tratativas dos **artigos** e do **relatório final CNPq**.

### 📅 Prazo

- **Não informado.**

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Melhoraram a interface web do menu de co-simulação, com ícones SVG e atualização mais limpa dos gráficos ao fim de cada execução.
  - O principal ponto em aberto é a realização dos **testes** e a incorporação das melhorias ao artigo.
  - Progresso: **não informado**.

- **Luiz Alberto (TSDQ)**
  - Continuou a estabilização do **Mapa de Rede D3**, com integração mais controlada à análise elétrica e melhor organização das medições e dos cards.
  - A validação mais ampla segue dependente de **testes completos** com diferentes cenários, e o próprio mini relatório veio parcialmente truncado na seção de dificuldades.
  - Progresso: **não informado explicitamente**.

- **Paulo Victor (TSRE)**
  - Consolidou a base elétrica e estocástica da co-simulação, integrando seleção de alimentadores, modelagem fotovoltaica, estabilização do Mosaik/OpenDSS e pipeline avançado de cargas.
  - O trabalho está próximo da conclusão, com foco restante em ajustes de dados climáticos e novos cenários com FV e veículos elétricos.
  - Prazo: **18/09/2026** — progresso em **95%**.

- **Douglas Barros (TTESO/PADE)**
  - Validou o mercado transativo nas redes **BT16** e **BT38**, comprovando a efetividade do mecanismo nos dois sentidos e consolidando a BT38 como rede final de estudo.
  - Restam apenas ajustes pontuais de registro e documentação para artigos e relatório final.
  - Progresso: **100%**.
