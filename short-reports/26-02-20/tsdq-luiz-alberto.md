---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[OPENTES - TSDQ Desenvolvimento de Ferramenta de Análise em Python e Diagnóstico de Divergência no OpenDSS]: "
labels: pesquisa, software
assignees: "[Luiz Alberto Silva Sales Marinho]"
---

## 📌 Descrição da Atividade

Desenvolvimento de scripts em Python (utilizando Streamlit e Pandas) para leitura automatizada, visualização e comparação cruzada de resultados de simulação extraídos do OpenDSS. A atividade incluiu a criação de um "Comparador Universal" para diagnosticar e auditar divergências de tensão encontradas na rede IEEE 34 Barras após a inserção de elementos do tipo Monitor.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x )
  Outra: OpenDSS
- **Repositório no GitHub**: `[endereço do repositório de trabalho no GitHub](https://github.com/grei-ufc/tsdq-dataview-opentes)`
- **Branch de Trabalho:** `(https://github.com/grei-ufc/tsdq-dataview-opentes/branches)`
- **Requisito Associado:** (Link para o artigo ou especificação técnica)

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings).
- [x] Testes unitários realizados.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [x] Criação de ferramenta de auditoria de dados (Comparador Universal).

## 📈 Resultados / Dificuldades

- **Progresso atual:** 80% [----------] 100%
- **Bloqueios:** Observou-se que os dados extraídos das simulações estão divergentes em relação aos resultados de referência obtidos pelo Luis Felipe. A única alteração realizada no script original do OpenDSS foi a adição dos monitores para a coleta dos dados, o que, de forma inesperada, causou alterações nos resultados de tensão da rede.

## 📅 Prazo Estimado

- Data de entrega pretendida: 27/02/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Definir junto à orientação o critério do Caso Base, assumir o arquivo novo como válido ou não.
- Passo 2. Consolidar as funcionalidades do visualizador principal (layout_2.py), especialmente a aba de visualização 3D do perfil de tensão.
- Passo 3. Limpar os códigos de teste (comparador.py e scripts brutos) e subir a versão final limpa para o repositório principal no GitHub.
