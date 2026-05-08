---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[PESQUISA]: "
labels: pesquisa, software
assignees: "[Paulo Victor Pereira Lima]"
---

## 📌 Descrição da Atividade

> Correção de inconsistências na implementação da simulação com a utilização de inversores inteligentes na rede IEEE 13 barras.
> Segunda parte do desenvolvimento de script para automatização do tratamento dos dados e criação dos geradores FV para
> utilização no simulador da rede elétrica implementada: criando dicionário para geração dos arquivos automaticamente com base
> na rede simulada.
> Execução da cossimulação do sistema IEEE 123 barras com containers.
> Estudo do OpenDER interface.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X)OpenDSS | (X) Mosaik
- **Repositório no GitHub**: `https://github.com/grei-ufc/tsre-der-opentes`
- **Branch de Trabalho:** `paulo-victor`
- **Requisito Associado:** [BR-PVGen](https://www.kaggle.com/datasets/tecsci/brazilian-pv-dataset)

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings).
- [x] Testes unitários realizados.
- [x] Container Docker atualizado (se aplicável).
- [x] Resultados preliminares validados com o Orientador.

## 📈 Resultados / Dificuldades

- **Progresso atual:**

Tarefa | Progresso
|----------|----------|
| Execução da cossimulação do sistema IEEE 123 barras com containers.| ![Progress](https://progress-bar.xyz/100/)  |
| Estudo do OpenDER interface. | ![Progress](https://progress-bar.xyz/20/)  |
| Implementação da cossimulação com inversores inteligentes no sistema IEEE 13 barras | ![Progress](https://progress-bar.xyz/100/)  | 
| Desenvolvimento da primeira parte do script para tratamento dos dados e criação dos geradores FV  | ![Progress](https://progress-bar.xyz/100/)   | 
| Desenvolvimento da segunda parte do script para tratamento dos dados e criação dos geradores FV  | ![Progress](https://progress-bar.xyz/90/)   | 

**Comparativo dos resultados da barra monitorada 680 no sistema IEEE 13 barras - OpenDSS puro vs Cossimulação (com e sem Volt-Var):** 

*Comparação gráfica:*

<img width="2489" height="1475" alt="ieee13barras_output" src="https://github.com/user-attachments/assets/aab4129e-6601-4862-b1e9-677f8a7f99b9" />

*Comparação quantitativa:*

| RELATÓRIO DE ERROS: OPENDSS vs CO‑SIMULAÇÃO (SEM VOLT‑VAR) |         |          |             |             |
|-------------------------------------------------------------------|---------|----------|-------------|-------------|
| Grandeza Analisada                                                | RMSE    | MAE      | Desv.Padrão | Erro Médio  |
| Tensão Barra 680 - Fase A [pu]                                    | 0.001824| 0.000570 | 0.001737    | -0.000568   |
| Tensão Barra 680 - Fase B [pu]                                    | 0.000071| 0.000022 | 0.000069    | 0.000015    |
| Tensão Barra 680 - Fase C [pu]                                    | 0.003281| 0.001025 | 0.003123    | -0.001022   |
| Potência Ativa Barra 680 - Fase A [kW]                            | 10.691607| 3.412425| 10.202496   | -3.252841   |
| Potência Ativa Barra 680 - Fase B [kW]                            | 10.693687| 3.357367| 10.186423   | -3.309384   |
| Potência Ativa Barra 680 - Fase C [kW]                            | 10.691686| 3.398085| 10.197921   | -3.267362   |
| Potência Reativa Barra 680 - Fase A [kvar]                        | 0.300689| 0.174147| 0.246475    | 0.172843    |
| Potência Reativa Barra 680 - Fase B [kvar]                        | 0.316751| 0.183530| 0.259596    | 0.182140    |
| Potência Reativa Barra 680 - Fase C [kvar]                        | 0.328306| 0.190285| 0.268912    | 0.189003    |

> 🔍 Interpretação das métricas:
> - RMSE (Root Mean Square Error): penaliza erros grandes (sensível a outliers).
> - MAE (Mean Absolute Error): magnitude média do erro (mesma unidade da grandeza).
> - Desvio Padrão dos Erros: mede a dispersão dos erros em torno do erro médio.
>  * Desvio pequeno → erros consistentes, pouca variabilidade.
>  * Desvio grande → erros variam muito ao longo do tempo.
> - Erro Médio: indica viés sistemático (positivo = superestimativa, negativo = subestimativa).

## 📅 Prazo Estimado

- Data de entrega pretendida: 15/05/2026

## 📋 Planejamento para conclusão da entrega
- Comentar, adicionar descrição das funções e organização em um arquivo .py do código de geração dos PVs.
- Rodar o sistema IEEE 13 barras em containers.
