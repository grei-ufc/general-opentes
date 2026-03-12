---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[OPENTES - TSDQ Desenvolvimento de Ferramenta de Análise em Python e Compreensão de código]: "
labels: pesquisa, software
assignees: "[Luiz Alberto Silva Sales Marinho]"
---

## 📌 Descrição da Atividade

Foi verificado que as perdas de dados nas saídas das simulações foi um problema apenas no visual. Além disso foi implementado a leitura das correntes e ângulos de corrente, como também uma análise de potência de geradores, irradiância solar e potência PV, caso haja na simulação. Em paralelo a isso, foi feito um estudo para saber como é realizado a co-simulação para compreender o motivo de divergências entre saídas de uma mesma simulação. 

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x ) OpenDSS | ( x ) Excel | ( x ) PowerBI
- **Repositório no GitHub**: `[endereço do repositório de trabalho no GitHub](https://github.com/grei-ufc/tsdq-dataview-opentes)`
- **Branch de Trabalho:** `(https://github.com/grei-ufc/tsdq-dataview-opentes/branches)`
- **Requisito Associado:** (Link para o artigo ou especificação técnica)

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings).
- [x] Testes unitários realizados.
- [x] Estudo de obtenção de dados a partir de uma co-simulação.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.

## 📈 Resultados / Dificuldades

- **Progresso atual:** 100%
  
![Progress](https://progress-bar.xyz/75/)
- **Bloqueios:** Atualmente, a simulação utilizada como referência ainda não possui uma análise das potências para poder ser analisada na interface. 

## 📎Próxima(s) Atividade(s)

Para auxiliar o time TSRE fui orianteado a iniciar um estudo a respeito do OpenDER para compreender sua função, como também realizar uma busca nos códigos fontes para identificar as divergências ocasionadas entre as análises do Simulador (OpenDSS, PV e Mosaik) e do OpenDSS.

## 📅 Prazo Estimado

- Data de entrega pretendida: 20/03/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Compreensão dos códigos utilizados para a co-simulação.
- Passo 2. Realizar a comparação entre os resultados entre o simulador e o OpenDSS.

