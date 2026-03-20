---
name: "🚀 Relatório de Progresso "
about:
  Avanços do time de co-simulação e simulação de comunicação
title: "[OPENTES - TSCC] Desenvolvimento de aplicação de simulação e co-simulação em ambientes conteinerizados"
labels: pesquisa, software
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---
## 📌 Descrição da Atividade

Após a implementação da co-simulação entre MOSAIK (Python) e OMNeT++ (C++) em containers Docker separados, com comunicação via ZeroMQ e orquestração via Docker Compose, alguns adicionais necessários foram implementados:
### Novos Incrementos da Semana

**1. Medição de Latência e Tamanho de Pacote:**

Foram adicionadas funcionalidades para medir o tempo de envio e o tamanho dos pacotes na comunicação entre os nós. Com isso, agora é possível extrair dados de latência da simulação, permitindo uma análise mais detalhada do desempenho da rede.

**2. Teste de Escalabilidade:**

Foi realizado um teste de escalabilidade, representado em um gráfico, no arquivo `plot-teste-escalabilidade.png`, onde aumentamos progressivamente o número de nós na simulação para submeter a aplicação a uma carga de estresse. O objetivo foi observar o comportamento do sistema em termos de consumo de recursos e tempo de processamento, visando identificar possíveis gargalos e garantir a robustez da solução para cenários mais complexos.

**3. Geração de Gráficos:**

Implementamos uma função para gerar um gráfico (`simulacao-plot.png`) que plota a quantidade de pacotes enviados pelo `node_0` e recebidos pelo `node_1` ao longo do tempo. O gráfico auxilia na visualização do fluxo de dados e na validação do comportamento esperado da simulação.



## 🛠 Contexto Técnico
- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X) Outra: C++ (OMNeTpp/INET)
- **Repositório no GitHub**: https://github.com/grei-ufc/tscc-com-opentes
- **Branch de Trabalho:** https://github.com/grei-ufc/tscc-com-opentes/tree/integration
- **Requisito Associado:** (Link para o artigo ou especificação técnica)

## ✅ Checklist de Entrega

- [X] Código documentado (Docstrings).
- [X] Testes unitários realizados.
- [X] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [X] Outros itens que não foram listados acima: Implementação de medição de latência e geração de gráficos para análise de desempenho; Teste de escalabilidade com aumento do número de nós.

## 📈 Resultados / Dificuldades

- **Progresso atual:** 100% [████████] → 100%

- **Bloqueios:** Nenhum bloqueio significativo foi identificado durante.

## 📅 Prazo Estimado 

- Data de entrega pretendida: xx/03/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Validar os resultados preliminares com o orientador.
- Passo 2.
