---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[PESQUISA]: "
labels: pesquisa, software
assignees: "Paulo Victor"
---

## 📌 Descrição da Atividade

> Preparação de rede real do bdgd para implementação na co-simulação

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | ( ) Docker | (X) BDGD | (X) OpenDSS | (X) QGIS
- **Repositório no GitHub**: `github.com/grei-ufc/tsre-der-opentes.git`
- **Branch de Trabalho:** `tsre-der-opentes/paulo-victor`
- **Requisito Associado:** `https://github.com/PauloRadatz/bdgd2opendss`

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings).
- [ ] Testes unitários realizados.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [ ] Outros itens que não foram listados acima.

## 📈 Resultados / Dificuldades

- **Progresso atual:** ![Progress](https://progress-bar.xyz/60/)

1. Rede escolhida: Um dos alimentadores da subestação da Aldeota (ADT), região com grande densidade de cargas e forte
  desenvolvimento econômico (região mais propícia a receber um maior número de carregadores veículares).
  
2. Importação e análise da rede elétrica da Enel CE do BDGD (filtragem a partir da subestação):

 <img width="1439" height="852" alt="image" src="https://github.com/user-attachments/assets/7a38466b-ab81-4602-b69e-498a5d880cd1" />


3. Conversão para o OpenDSS com o bdgd2opendss e plotagem dos 14 alimentadores da subestação ADT:

 <img width="3869" height="2336" alt="Alimentadores_ADT" src="https://github.com/user-attachments/assets/ac2db4d6-262a-4ac0-9fe8-4712c840d68b" />

4. Análise dos alimentadores:

 <img width="3600" height="3000" alt="grafico_barras_cargas_alimentadores" src="https://github.com/user-attachments/assets/cb3c2b6b-b346-46ac-bd84-20c7513fb562" />

Alimentador escolhido: 

<img width="782" height="797" alt="Captura de tela 2026-08-20 142544" src="https://github.com/user-attachments/assets/bac37819-df5e-41e1-a9b7-4812a2eee169" />


## 📅 Prazo Estimado

- Data de entrega pretendida: 28/08/2026

## 📋 Planejamento para conclusão da entrega

- Filtrar arquivos de simulação gerados.
- Integrar scripts na co-simulação.
- Integrar rede IEEE LV na co-simulação (Para os EUs).
<img width="694" height="419" alt="image" src="https://github.com/user-attachments/assets/757ad510-0f76-4754-bacc-f1bbdec5f821" />
