---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[PESQUISA]: "
labels: pesquisa, software
assignees: "[Nome do(a) estudante ou estudantes envolvido(a)s]"
---

## 📌 Descrição da Atividade

> Implementação da simulação com a utilização de inversores inteligentes na rede IEEE 13 barras, com a simulação rodando.
> Primeira parte do desenvolvimento de script para automatização do tratamento dos dados e criação dos geradores FV para
> utilização no simulador da rede elétrica: já tratando adequadamente os dados, e criando os arquivos csv e dss.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | ( ) Docker | (X)OpenDSS
- **Repositório no GitHub**: `https://github.com/grei-ufc/tsre-der-opentes`
- **Branch de Trabalho:** `paulo-victor`
- **Requisito Associado:** [BR-PVGen](https://www.kaggle.com/datasets/tecsci/brazilian-pv-dataset)

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings).
- [ ] Testes unitários realizados.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [ ] Outros itens que não foram listados acima.

## 📈 Resultados / Dificuldades

- **Progresso atual:**

Tarefa | Progresso
|----------|----------|
| Implementação dos inversores inteligentes no sistema IEEE 13 barras | ![Progress](https://progress-bar.xyz/90/)  | 
| Desenvolvimento da primeira parte do script para tratamento dos dados e criação dos geradores FV  | ![Progress](https://progress-bar.xyz/95/)   | 

- **Bloqueios:** Erro na implementação do scenário mosaik com o sistema IEEE 13 barras e inversores inteligentes que está causando diferenças em comparação ao OpenDSS puro.

## 📅 Prazo Estimado

- Data de entrega pretendida: 01/05/2026

## 📋 Planejamento para conclusão da entrega

- Adicionar comentários e descrições no código atual de criação dos PVs e definir diretório padrão para salvamento dos arquivos.
- Analisar junto ao Luis Felipe se o que está ocasionando o erro na implementação do sistema IEEE 13 barras é proveniente de algum erro na minha implementação e então corrigi-lo.
- Implementar a segunda parte do script para criação dos geradores PV, com geração randomizada.
