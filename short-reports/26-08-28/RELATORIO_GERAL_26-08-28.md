---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-08-28)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-08-28**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Criação de uma interface web em **Streamlit** para configurar a co-simulação antes da execução.
- Implementação de menu interativo para seleção de parâmetros da simulação, incluindo a configuração do sistema.

### 📈 Evidências / resultados

- O menu interativo e sua interface web foram concluídos.
- O ambiente foi reportado como estável e totalmente integrado, utilizando Python, C++, Docker, ZeroMQ, PADE, OMNeT++ e Streamlit.
- A interface estabelece uma frente de interação com o usuário para a configuração prévia das execuções.

### ⚠️ Dificuldades / bloqueios

- Algumas configurações causam travamento e iniciam uma **co-simulação fantasma**.
- Os testes permanecem em andamento, portanto o comportamento da interface ainda requer validação sistemática.

### 🧩 Próximas ações para concluir

- Testar as configurações disponíveis e corrigir os cenários que produzem co-simulação fantasma.
- Incorporar gráficos à interface web.
- Registrar as atualizações da plataforma e seus gráficos no artigo.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Início da unificação funcional dos módulos **Mapa de Rede** e **Análise Elétrica** da plataforma ARGOS/OpenTES.
- Manutenção do fluxo de entrada com JSON da topologia e CSV de resultados, protegido por validação de integridade **SHA-256**.
- Sincronização entre o barramento selecionado no grafo, o Inspetor, a análise temporal e os indicadores de Qualidade de Energia.

### 📈 Progresso reportado

- Progresso atual: **95%**.
- Foram concluídas a integração entre Mapa de Rede e Análise Elétrica, a validação do vínculo JSON/CSV, a organização das grandezas por entidade elétrica e a integração dos cards de Qualidade de Energia.
- A plataforma agora diferencia tensões de barramentos, fluxos e correntes de linhas, e potências de equipamentos conectados.
- Foi implementada a potência aparente `S` por fase, calculada a partir dos pares correspondentes de potência ativa `P` e reativa `Q`.
- Os módulos modificados foram validados quanto à sintaxe e testados com arquivos CSV e JSON de exemplo.

### ⚠️ Dificuldades / bloqueios

- A associação correta entre medições e suas entidades elétricas exige tratamento cuidadoso para evitar que grandezas de linha ou equipamentos sejam atribuídas a barramentos.
- Há variações de nomenclatura, acentuação e codificação nas variáveis da co-simulação.
- A validação visual completa no Streamlit ainda está pendente.

### 🧩 Próximas ações para concluir

- Validar visualmente a interface integrada e a seleção de barramentos pelo grafo.
- Testar arquivos de co-simulação diversos e verificar as grandezas de barras, linhas e equipamentos.
- Refinar a sincronização entre o grafo, o Inspetor e a análise temporal.
- Avaliar a apresentação de valores de base, além de pu, e criar indicador da posição do nó selecionado.

### 📅 Prazo

- Data de entrega pretendida: **02/09/2026**.

---

## 3) 👨‍💻 Paulo Victor (TSRE)

### ✅ Tarefa principal

- Atualização do `pv_creator` e preparação da rede **IEEE Low Voltage Test Case** para uso na co-simulação.
- Melhorias na identificação de barras, na interpolação de dados e nas colunas CSV relacionadas aos elementos de geração fotovoltaica.
- Geração de arquivos CSV e JSON para a plataforma de visualização, contemplando a rede LVTestCase e a IEEE 13 barras.

### 📈 Resultados / entregas técnicas (destaques)

- Todas as atividades reportadas foram concluídas: implementação da IEEE 13 barras na interface gráfica, melhorias no `pv_creator`, integração da LVTestCase e geração de dados de visualização.
- Foram realizados testes unitários e atualização do container Docker, quando aplicável.
- A melhoria de interpolação e a identificação das barras nos elementos FV elevam a consistência dos dados encaminhados à co-simulação e à interface.

### ⚠️ Dificuldades / bloqueios

- O mini relatório não apontou dificuldades técnicas ou bloqueios explícitos.
- A validação preliminar dos resultados com o orientador permanece pendente.

### 🧩 Próximas ações para concluir

- Implementar notebook Python com cenários distintos de penetração fotovoltaica na rede LVTestCase para os EUs.

### 📅 Prazo

- Data de entrega pretendida: **04/09/2026**.

---

## 4) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Reprodução das Figuras 42 a 59 da tese de referência para validar a camada de mercado transativo na **MVLV75**.
- Correção de defeitos encontrados na fase de operação e adequação das figuras, tabelas e métricas ao formato da tese.
- Redução do CFP e avaliação do roteamento pela raiz na rede 6TiSCH.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **90%**.
- A negociação convergiu em **28 rodadas**; o mercado reduziu as violações de tensão de **337 para zero**, elevando a tensão mínima de **0,93946 para 0,97029 pu**.
- Em 95 janelas de operação, o Agente de Mercado interveio em **21**, e a comunicação atingiu **161,3 mensagens por janela**, ante 155 na tese, com **94%** das mensagens abaixo de 500 bytes.
- Foram corrigidos três defeitos da fase de operação: bloqueio do leilão após perda de resposta, ausência de propagação do estado de carga da bateria e corrupção progressiva do `omnetpp.ini`.
- Duas fontes de tráfego que não pertencem à arquitetura foram removidas; o CFP foi reduzido ao enviar somente os dados necessários e manter informações iniciais em cache.

### ⚠️ Dificuldades / bloqueios

- O roteamento pela raiz foi avaliado, mas ainda não foi implementado como opção de execução.
- A comparação por nó com a tese segue limitada pela atribuição divergente de curvas de carga nos dados publicados; por decisão de escopo, esse ponto foi abandonado.
- O trabalho identificou que resultados agregados podem ocultar defeitos, exigindo a manutenção da validação por figuras no formato de referência.

### 🧩 Próximas ações para concluir

- Migrar os testes do mercado para as redes próprias **BT16** e **BT38**, pois a MVLV75 cumpriu o papel de padrão de calibração.

### 📅 Prazo

- **Não informado.**

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Criaram uma interface Streamlit para configuração da co-simulação.
  - A correção das configurações que geram co-simulação fantasma e os testes da interface são a prioridade.
  - Progresso: **não informado**.

- **Luiz Alberto (TSDQ)**
  - Integraram Mapa de Rede, Análise Elétrica e Qualidade de Energia com validação SHA-256 e associação mais precisa das medições aos elementos da rede.
  - A validação visual completa e os testes com mais cenários permanecem pendentes.
  - Progresso: **95%**; prazo: **02/09/2026**.

- **Paulo Victor (TSRE)**
  - Concluiu melhorias do `pv_creator`, a integração da LVTestCase e a geração de dados para visualização.
  - O próximo marco é montar cenários de penetração FV para os EUs.
  - Prazo: **04/09/2026**.

- **Douglas Barros (TTESO/PADE)**
  - Reproduziu a série de figuras da tese, corrigiu defeitos de operação e consolidou o mercado MVLV75 com resultado elétrico aderente.
  - A frente seguirá para as redes BT16 e BT38, depois de a MVLV75 cumprir a função de calibração.
  - Progresso: **90%**.
