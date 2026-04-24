---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos
  passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-04-24)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-04-24**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Conclusão da fase de integração da infraestrutura de **co-simulação
  bidirecional OMNeT++/Mosaik/PADE**, com foco em sincronismo temporal e
  precisão científica da comunicação.
  - Evolução do `NetworkNode.cc` para cálculo dinâmico de latência com base em
    **largura de banda** e **tamanho do pacote**.
  - Implementação de proteção contra sobrescrita por entradas vazias no
    `MosaikBridge.cc`.
  - Refatoração da inicialização para leitura correta dos inputs já no `step 0`.
  - Remoção de atrasos em wall-clock nos agentes PADE e consolidação do fluxo
    bidirecional contínuo.
  - Automação da geração de gráficos de desempenho ao final das execuções.

### 📈 Evidências / resultados

- Progresso atual: **100%**.
- Comunicação bidirecional em lock-step validada com sucesso.
- Latências variáveis e matematicamente rastreáveis comprovadas em função do
  payload.
- Geração automatizada de evidências visuais para suporte à tese.
- Ambiente descrito como **estável / pronto para cenários de pesquisa**.

### ⚠️ Dificuldades / bloqueios

- **Nenhum bloqueio ativo.**
- Dificuldades já superadas:
  - dessincronização entre o tempo real do Python e o tempo discreto do Mosaik;
  - perda de mensagens no instante inicial (`t=0`);
  - ruído externo de port-scanning confundido com falha da aplicação.

### 🧩 Próximas ações para concluir

- Simular cenários de congestionamento reduzindo a largura de banda no C++.
- Testar a escalabilidade com mais agentes na topologia em estrela.
- Implementar métricas de **jitter** e **perda de pacotes** com base
  probabilística no OMNeT++.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Desenvolvimento e correção do sistema de visualização de grandezas elétricas
  no dashboard.
  - Correção da conversão de unidades (**MW -> W** e **MVAr -> var**).
  - Implementação de autoescala consistente baseada em ordem de grandeza.
  - Ajuste do cálculo da escala global para usar valor máximo em vez de média.
  - Proposta de parser mais robusto orientado ao nome/sufixo das colunas
    (`_mw`, `_mvar`, `_pu`).
  - Elaboração de manual de padronização de nomes de colunas para compatibilidade
    com regex.

### 📈 Progresso reportado

- Progresso atual: **75%**.
- Resultados principais:
  - eliminação de erros de unidade na visualização;
  - melhoria da robustez do parser;
  - maior confiabilidade na leitura de dados do OpenDSS;
  - melhor alinhamento entre nomenclatura das colunas e interpretação física.

### ⚠️ Dificuldades / bloqueios

- Inconsistência entre unidade nominal e valor numérico interpretado.
- Dependência inicial de apenas uma curva para definição da escala global.
- Problemas de indentação e organização lógica no código Python.
- Interpretação inadequada da unidade a partir do rótulo, em vez do sufixo da
  coluna.

### 🧩 Próximas ações para concluir

- Melhorar a interface gráfica (**UX**) do dashboard.
- Generalizar o parser para novas grandezas elétricas.
- Implementar suporte expandido de unidades no parser.
- Refinar a consistência geral da interface.

### 📅 Prazo

- Data de entrega pretendida: **01/05/2026**.

---

## 3) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Atualização local do **PADE 3.0**, modernização do ambiente Docker e início da
  trilha prática com **OpenDSS via `py-dss-interface`**.
  - Sincronização do repositório com a `master` oficial.
  - Migração do Docker para fluxo com **`pyproject.toml` + `uv` + Python 3.12**.
  - Validação prática do PADE em container.
  - Abertura de Pull Request para a `master` oficial.
  - Reorganização de uma trilha progressiva de exemplos locais com
    `py-dss-interface`.
  - Validação e correção dos exemplos iniciais 00 a 05.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **30%**.

| Módulo/Atividade | Status | Observação |
|---|---|---|
| **PADE 3.0 local** | ✅ Atualizado | Repositório alinhado à `master` oficial |
| **Docker do PADE** | ✅ Modernizado | Fluxo legado removido; ambiente ajustado a `uv` e Python 3.12 |
| **Validação em container** | ✅ Concluída | CLI, runtime e exemplos executados com sucesso |
| **PR para a `master` oficial** | 🟡 Aberto | Aguardando aprovação |
| **Trilha `py-dss-interface`** | ✅ Iniciada | Estrutura didática montada do exemplo 00 ao 05 |
| **Exemplos iniciais OpenDSS** | ✅ Validados | Casos 00 a 05 analisados e corrigidos |

### ⚠️ Dificuldades / bloqueios

- Necessidade de separar resíduos do fluxo Docker legado de funcionalidades
  ainda válidas do PADE.
- Ajustes na documentação para refletir corretamente a ativação da `venv`.
- Limitação prática do backend `Linux-C++` do `py-dss-interface` no uso de
  `export monitor`, exigindo solução controlada via Python.

### 🧩 Próximas ações para concluir

- Acompanhar a aprovação do Pull Request do PADE.
- Consolidar conclusões curtas para cada exemplo estudado.
- Iniciar um caso mínimo de integração entre lógica de decisão e OpenDSS.
- Avançar na preparação do estudo aplicado de sistema transativo.
- Conciliar OpenDSS, PADE e OMNeT++ como objetivo central da próxima etapa.

### 📅 Prazo

- Término estimado dos estudos de OpenDSS e OMNeT++: **08/05/2026**.

---

## 4) 👨‍💻 Paulo Victor Pereira Lima (TSRE)

### ✅ Tarefas principais

- Avanço da simulação com **inversores inteligentes na rede IEEE 13 barras**.
- Desenvolvimento da primeira parte do script para automatização do tratamento
  de dados e criação de geradores fotovoltaicos.
- Geração funcional de arquivos **CSV** e **DSS** a partir do tratamento dos
  dados do **BR-PVGen**.

### 📈 Progresso reportado

| Frente de trabalho | Progresso |
|---|---|
| Implementação da simulação com inversores inteligentes na IEEE 13 barras | **90%** |
| Primeira parte do script de tratamento dos dados e criação dos geradores FV | **95%** |

- A simulação já está rodando, e o tratamento dos dados foi estruturado de forma
  adequada para geração de arquivos de apoio ao simulador.

### ⚠️ Dificuldades / bloqueios

- Erro na implementação do cenário em **mosaik** com o sistema IEEE 13 barras e
  inversores inteligentes, causando diferenças em relação ao **OpenDSS puro**.

### 🧩 Próximas ações para concluir

- Adicionar comentários e descrições ao código atual de criação dos PVs.
- Definir diretório padrão para salvamento dos arquivos gerados.
- Investigar, junto ao Luis Felipe, a origem do erro na implementação do sistema
  IEEE 13 barras e corrigi-lo.
- Implementar a segunda parte do script, com geração randomizada dos geradores
  PV.

### 📅 Prazo

- Data de entrega pretendida: **01/05/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Concluíram a fase-base da integração bidirecional **OMNeT++/Mosaik/PADE**.
  - Validaram latência dinâmica baseada em pacote e largura de banda, além da
    geração automática de gráficos de desempenho.
  - Estão sem bloqueios ativos e avançam agora para cenários de congestionamento
    e escalabilidade.
  - Progresso: **100%**.

- **Luiz Alberto (TSDQ)**
  - Corrigiu e fortaleceu o dashboard de visualização elétrica, com destaque para
    conversão de unidades, autoescala e parser baseado em sufixos de colunas.
  - Ainda enfrenta ajustes estruturais ligados à interpretação de unidades e
    generalização da interface.
  - Próximos focos: UX e ampliação do parser.
  - Prazo: **01/05/2026** — progresso em **75%**.

- **Douglas Barros (TTESO/PADE)**
  - Modernizou o ambiente do **PADE 3.0**, validou o fluxo em container e abriu
    PR para a `master` oficial.
  - Também iniciou e organizou a trilha prática de estudos com
    **`py-dss-interface`**, já com exemplos iniciais validados.
  - Próximos focos: integração mínima com OpenDSS e consolidação da base para a
    etapa aplicada.
  - Prazo: **08/05/2026** — progresso geral **30%**.

- **Paulo Victor (TSRE)**
  - Avançou fortemente na simulação com inversores inteligentes na IEEE 13
    barras e na primeira etapa do script de geração dos geradores FV.
  - O principal bloqueio está na divergência entre o cenário em **mosaik** e o
    comportamento observado no **OpenDSS puro**.
  - Próximos focos: corrigir esse erro, documentar melhor o código e implementar
    a geração randomizada dos PVs.
  - Prazo: **01/05/2026** — progresso de **90%** e **95%** nas duas frentes
    principais.
