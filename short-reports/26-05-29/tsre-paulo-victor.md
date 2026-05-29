---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[PESQUISA]: Co-simulação Dinâmica e Geração Automatizada de PVs - IEEE 13 Barras"
labels: pesquisa, software
assignees: "[Paulo Victor Pereira Lima]"
---

## 📌 Descrição da Atividade

> Integração de dados climáticos reais (Irradiância e Temperatura) com o script de automação da criação e conexão
> dos geradores fotovoltaicos no cenário de co-simulação para o sistema IEEE 13 barras.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X) OpenDSS
- **Repositório no GitHub**: `https://github.com/grei-ufc/tsre-der-opentes`
- **Branch de Trabalho:** `paulo-victor`
- **Requisito Associado:** [BR-PVGen](https://www.kaggle.com/datasets/tecsci/brazilian-pv-dataset)

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings e modularização).
- [x] Testes unitários realizados.
- [x] Container Docker atualizado.
- [ ] Resultados preliminares validados com o Orientador.

## 📈 Resultados / Dificuldades

- **Progresso atual:**

Tarefa | Progresso
|----------|----------|
| Automatização da geração de PVs com dados reais e estruturação de diretórios no sistema IEEE 13 barras | ![Progress](https://progress-bar.xyz/100/) |
| Implementação de melhorias no script para tratamento dinâmico de dados climáticos | ![Progress](https://progress-bar.xyz/98/) | 

- **Principais Avanços:**
  - **Diretório Padrão Estruturado:** Organização do diretório de saida de dados (`data/13Bus`) para garantir a compatibilidade do script com o cenário mosaik.
  - **Geração Automatizada e Dados Reais:** Conexão dos dados climáticos aos painéis físicos de forma automatizada. O algoritmo foi robustecido com a inclusão de verificações estruturais e tratamento de exceções (validações de chaves e tipos de dados), garantindo maior resiliência contra falhas de entrada e consistência na leitura dos perfis climáticos.
- **Bloqueios / Dificuldades:** - Sem bloqueios críticos no código. Apenas ajustes finos necessários para otimizar as chamadas de volume e rede de simulação dentro do ambiente de contêineres Docker.

## 📅 Prazo Estimado

- Data de entrega pretendida: 5/06/2026

## 📋 Planejamento para conclusão da entrega

- Implementar ajustes na simulação via docker. 
- Concluir a implementação de melhorias no script para tratamento dos dados e criação dos geradores FV.
- Adequar colunas dos arquivos CSV para o padrão definido pelo Beto.
