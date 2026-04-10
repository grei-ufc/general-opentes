---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "Implementação do simulador, estudo das simulações com inversores inteligentes e discussões sobre a utilização de dados"
labels: pesquisa, software
assignees: "[Nome do(a) estudante ou estudantes envolvido(a)s]"
---

## 📌 Descrição da Atividade

> Implementação de geradores FV na rede IEEE 123 barras e comparação entre os resultados da Co-simulação e a simulação com OpenDSS puro,
> resultando na identificação e correção de um erro nos códigos de coleta dos dados de tensão referentes a linhas monofásicas. Elaboração
> de resultados da implementação dos simuladores FV, registrados na issue #11. Discussão de alinhamento acerca da utilização dos dados
> fotovoltaicos reais obtidos do LEA/UFC e do BR-PVGen/UFJF. Estudo da simulação com inversores inteligentes no sistema IEEE 123 barras
> com uso do OpenDER.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | ( ) Docker | (X) OpenDSS
- **Repositório no GitHub**: `https://github.com/grei-ufc/tsre-der-opentes`
- **Branch de Trabalho:** `paulo-victor`
- **Requisito Associado:** -

## ✅ Checklist de Entrega

- [X] Código documentado (Docstrings).
- [X] Testes unitários realizados.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [ ] Outros itens que não foram listados acima.

## 📈 Resultados / Dificuldades

- **Progresso atual:** ![Progress](https://progress-bar.xyz/60/)
- **Bloqueios:** -

## 📅 Prazo Estimado

- Data de entrega pretendida: 17/04/2026

## 📋 Planejamento para conclusão da entrega

- Decisão consolidada acerca da implementação dos dados reais para geração FV e elaboração de pipeline de ingestão de dados reais.
- Implementação de algorítmo para conversão de arquivos de irradiância de CSV para .dss para cada gerador fV de forma automatizada.
- Implementação da rede IEEE 13 barras utilizando o novo simulador e os inversores inteligentes.
