---
name: "📌 Relatório Geral (Consolidado)"
about:
  "Consolidação dos mini relatórios do dia, com tarefas, dificuldades e próximos passos."
title: "[OPENTES] Relatório Geral — Consolidado (2026-09-04)"
labels: relatorio, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-09-04**

## 🎯 Objetivo

Consolidar os pontos mais importantes dos mini relatórios, destacando:

- O que cada desenvolvedor está fazendo (tarefas).
- Quais dificuldades/bloqueios foram encontrados.
- Quais ações serão feitas para concluir.
- Prazos associados (quando informados).

---

## 1) 👨‍💻 Luiz Alberto Silva Sales Marinho (TSDQ)

### ✅ Tarefas principais

- Consolidação da unificação entre **Mapa de Rede** e **Análise Elétrica** da plataforma ARGOS/OpenTES.
- Implementação de uma alternativa interativa de visualização topológica com **D3/JavaScript**, preservando o Agraph como opção.
- Integração do nó selecionado no D3 ao estado do Streamlit, permitindo alimentar o Inspetor e a análise elétrica.

### 📈 Progresso reportado

- Progresso atual: **97%**.
- Foi mantida a validação de integridade entre JSON e CSV por SHA-256, com o script independente `scripts/aplicar_hash_topologia.py`.
- O Mapa de Rede foi reorganizado e o Inspetor passou a apresentar cards específicos para tensões, ângulos, correntes, potências e equipamentos conectados.
- As medições foram organizadas por barramentos, linhas e equipamentos; os dados de PVPanel, Inverter e PVSystem foram associados explicitamente aos respectivos barramentos.
- A visualização D3 oferece modos de tensão em três fases, por fase, mínimo, máximo, média e spread, além de reprodução temporal local no navegador.
- Foi criado o SavePoint 2 para preservar o estado estável anterior às alterações mais extensas de visualização.

### ⚠️ Dificuldades / bloqueios

- A incorporação inicial do D3 por `components.html` não retornava o nó selecionado ao Streamlit, exigindo a criação de um componente próprio.
- Foi necessário impedir que tensões `0.0` fossem tratadas como ausência de medição.
- A pequena variação de tensão do caso IEEE123 testado mantém a maior parte dos nós visualmente na faixa verde, limitando a avaliação das cores durante a reprodução temporal.
- Persistem ajustes de inicialização do Streamlit no ambiente UV e a validação completa com diferentes cenários de co-simulação.

### 🧩 Próximas ações para concluir

- Testar o componente D3 com diferentes resultados de co-simulação.
- Refinar a interação entre grafo, Inspetor e análise temporal.
- Expandir a associação automática para outros equipamentos e avaliar cenários com maior variação de tensão.
- Documentar a arquitetura e o fluxo de utilização da interface integrada.

### 📅 Prazo

- Data de entrega pretendida: **09/09/2026**.

---

## 2) 👨‍💻 Douglas Barros (TTESO / PADE)

### ✅ Tarefa principal

- Porte da camada de mercado transativo para a **IEEE 13 barras** e adequação da arquitetura de agentes a uma rede com apenas um transformador de distribuição.
- Validação do circuito contra o perfil de tensão publicado e geração programática do caso de mercado a partir do circuito compilado.

### 📈 Resultados / entregas técnicas (destaques)

- Progresso atual: **92%**.
- O circuito IEEE 13 reproduziu o perfil de referência com erro médio de **0,00044 pu** e máximo de **0,00134 pu** em 33 medições de fase.
- Foi corrigido o PVSystem trifásico indevidamente conectado a uma barra bifásica; anteriormente, **37%** da potência do PV1 era injetada em uma fase sem condução.
- A negociação de mercado convergiu em **75 rodadas** e reduziu as leituras fora da ANSI Range A de **446 para 174**, com tensão entre **0,92302 e 1,08413 pu** no caso negociado.
- A arquitetura foi explicitamente reinterpretada: um Concentrador na cabeceira do alimentador, dez prosumidores nas barras com carga ou geração, um DSO e um Agente de Mercado.
- Foram adaptadas 18 figuras para a IEEE 13 e medido o dimensionamento de armazenamento necessário para tornar o caso factível.

### ⚠️ Dificuldades / bloqueios

- A negociação distribuída melhora as tensões, mas não elimina todas as violações, diferentemente do caso centralizado.
- As causas medidas são a avaliação por fase, a interação entre regulador e mercado e a diferença entre demanda realizada e programada.
- O sequenciamento do regulador na fase de operação ainda não foi implementado.
- A adaptação da arquitetura da tese para uma rede de um transformador altera o significado da restrição de carregamento e da definição de prosumidor; essa mudança foi documentada como reinterpretação, não como reprodução literal.

### 🧩 Próximas ações para concluir

- Migrar para as redes próprias **BT16** e **BT38**, deixando a MVLV75 como referência de calibração.

### 📅 Prazo

- **Não informado.**

---

## ✅ Resumo final (tópicos)

- **Luiz Alberto (TSDQ)**
  - Consolidou a interface integrada da ARGOS e adicionou a visualização D3 com seleção bidirecional de barramentos e reprodução temporal.
  - A validação da interface com cenários mais diversos é o principal passo pendente.
  - Progresso: **97%**; prazo: **09/09/2026**.

- **Douglas Barros (TTESO/PADE)**
  - Portou o mercado transativo para a IEEE 13, validou o circuito e tornou explícitas as adaptações necessárias à arquitetura de agentes.
  - A principal pendência técnica é o sequenciamento do regulador durante a operação; a próxima etapa informada é a migração para BT16 e BT38.
  - Progresso: **92%**.
