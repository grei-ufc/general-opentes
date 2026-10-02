---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-09-25)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-09-25**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👩‍💻👨‍💻 Laiza Edwigens Rocha Silva & Rafael dos Santos Moura (TSCC)

### ✅ Tarefa principal

- Evolução da interface web da co-simulação em **Streamlit**.
  - Separação entre a configuração e os resultados da co-simulação em abas distintas.
  - Realocação dos gráficos pós-execução para a aba **Resultados**.
  - Melhoria da caracterização visual dos agentes e do terminal integrado.

### 📈 Evidências / resultados

- O menu interativo e a interface web seguem concluídos.
- Foram adicionados ícones SVG com as cores do projeto, renderização dinâmica de gráficos e limpeza/atualização da visualização.
- A interface agora oferece caracterização individual dos agentes, terminal compactável e melhor distribuição dos gráficos.
- A organização em abas tornou o fluxo de configuração e leitura dos resultados mais limpo.

### ⚠️ Dificuldades / bloqueios

- Os testes da interface permanecem em andamento.
- A distribuição final dos gráficos após a co-simulação ainda necessita de ajustes.

### 🧩 Próximas ações para concluir

- Executar testes da interface e das atualizações implementadas.
- Refinar a realocação dos gráficos ao término da co-simulação.
- Incorporar os gráficos e as atualizações da plataforma ao artigo científico.

### 📅 Prazo

- **Não informado.**

---

## 2) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Revisão e consolidação da documentação do repositório **`grei-ufc/co-simulation-opentes`** em uma plataforma **MkDocs** com Material for MkDocs.
- Atualização dos documentos existentes com validação contra o código e as execuções armazenadas, antes de sua publicação no novo site.

### 📈 Resultados / entregas técnicas (destaques)

- O site MkDocs foi montado com Material for MkDocs e compila sem avisos no modo `--strict`.
- Foram revisados `README.md`, `docs/GUIA.md`, `docs/INTEGRACAO.md`, `docs/RESULTADOS.md` e `docs/MERCADO.md`.
- A documentação ganhou páginas de capa, instalação e execução, cenários e experimentos, além de navegação organizada em quatro seções.
- A identidade visual do GREI foi aplicada com paleta, tipografia, marca e favicon; o site também passou a oferecer busca, temas claro e escuro, diagramas Mermaid e conteúdo específico para Docker e `uv`.
- A revisão corrigiu quatro afirmações desatualizadas, incluindo valores do cenário IEEE 13, o valor padrão de `MARKET_V_BACKOFF`, a definição do caso principal de mercado e a referência ao registro de execução válido.

### ⚠️ Dificuldades / bloqueios

- A documentação anterior continha divergências em relação ao código e às execuções atuais, exigindo validação de cada número antes da publicação.
- Ainda faltam páginas dedicadas para explicar internamente cada simulador, em especial o `comm-opentes` em C++.
- A publicação do site e o commit no repositório remoto permanecem pendentes.

### 🧩 Próximas ações para concluir

- Escrever o resumo para o SNPTEE.
- Elaborar o relatório final do Time TTESO.

### 📅 Prazo

- **Não informado.**

---

## 3) 👨‍💻 Paulo Victor (TSRE / EVs)

### ✅ Tarefa principal

- Migração da modelagem de veículos elétricos da injeção estática de potência para um modelo físico de baterias com o motor **Caldera ICM**.
- Elaboração da proposta matemática para inferir o estado de carga inicial das sessões e início da refatoração do orquestrador `pipeline_ev.py`.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **15%**.
- Foi versionada a infraestrutura assíncrona de co-simulação OpenDSS/Mosaik e criada a branch isolada `feature/caldera-icm-integration`.
- A proposta matemática e estrutural da integração foi documentada, e o README foi atualizado com a nova topologia de contêineres.
- A metodologia definida substitui a carga retangular pelo comportamento eletroquímico do Caldera, incluindo o efeito de *tapering*.
- Foi estabelecido um método híbrido para estimar o SoC inicial, combinando retrocálculo a partir da energia entregue com inferência estocástica em sessões de carregamento rápido.
- O planejamento inclui costura temporal de micro-sessões para preservar o estado da bateria entre conexões próximas.

### ⚠️ Dificuldades / bloqueios

- A telemetria bruta não contém o SoC inicial exigido pelo Caldera, exigindo inferência matemática e tratamento específico para sessões incompletas.
- A refatoração do `pipeline_ev.py`, a adaptação do Dockerfile com CMake/pybind11 e a construção do wrapper Mosaik ainda estão pendentes.

### 🧩 Próximas ações para concluir

- Concluir as regras de vizinhança e o cálculo de `t_idle` para gerar a tabela de sessões limpa.
- Ajustar o ambiente Docker para compilação nativa da biblioteca C++ do Caldera.
- Desenvolver o wrapper Mosaik e orquestrar os veículos físicos no cenário OpenDSS.

### 📅 Prazo

- Data de entrega pretendida: **30/09/2026**.

---

## ✅ Resumo final (tópicos)

- **Laiza & Rafael (TSCC)**
  - Evoluíram a interface Streamlit, separando configuração e resultados e aprimorando a visualização de agentes, terminal e gráficos.
  - Os testes e a organização final dos gráficos permanecem como etapas pendentes.
  - Progresso: **não informado**.

- **Douglas Barros (TTESO/PADE)**
  - Consolidou e revisou a documentação técnica em um site MkDocs consistente com o código e as execuções atuais.
  - A publicação do site e a documentação interna por simulador ainda precisam ser concluídas.
  - Progresso: **não informado**.

- **Paulo Victor (TSRE / EVs)**
  - Iniciou a migração para o modelo físico Caldera ICM, estruturando a inferência de SoC e a preservação temporal do estado das baterias.
  - A implementação do pipeline, do ambiente C++ e do wrapper Mosaik constitui a próxima etapa.
  - Progresso: **15%**; prazo: **30/09/2026**.
