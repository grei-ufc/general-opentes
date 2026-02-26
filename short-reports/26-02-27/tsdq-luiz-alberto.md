---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[OPENTES - TSDQ Desenvolvimento de Ferramenta de Análise em Python e Implementação de Interface]: "
labels: pesquisa, software
assignees: "[Luiz Alberto Silva Sales Marinho]"
---

## 📌 Descrição da Atividade

Atualização de scripts em Python (utilizando Streamlit e Pandas) para leitura e visualização das corrente e potências de uma simulação extraídos do OpenDSS. A atividade incluiu a reposição das funções originais da antiga plataforma para diagnosticar e auditar divergências de tensão encontradas na rede.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x ) OpenDSS
- **Repositório no GitHub**: `[endereço do repositório de trabalho no GitHub](https://github.com/grei-ufc/tsdq-dataview-opentes)`
- **Branch de Trabalho:** `(https://github.com/grei-ufc/tsdq-dataview-opentes/branches)`
- **Requisito Associado:** (Link para o artigo ou especificação técnica)

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings).
- [ ] Testes unitários realizados.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [x] Criação de ferramenta de auditoria de dados (Comparador Universal).

## 📈 Resultados / Dificuldades

- **Progresso atual:** 83%
  
![Progress](https://progress-bar.xyz/83/)
- **Bloqueios:** Atualmente os modos dos monitores são apenas para visualizar tensão e corrente, é necessário implementar monitores para os modos de potências. Além disso, a extração dos resultados do script dss é feita pelo Google Colab gerando varios arquivos CVS que distoam da formatação de entrada. É necessário aprender como gerar os arquivos CSV no formato de entrada da interface, formato esse que é padrão de qualquer co-simulação.

## 📅 Prazo Estimado

- Data de entrega pretendida: 06/03/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Efetuar a análise das correntes das barras monitoradas.
- Passo 2. Implementar novos monitores para potências.
- Passo 3. Efetuar a extração no formato padrão de saída de uma co-simulação.
- Passo 4. Reorganizar a estrutura da interface.
