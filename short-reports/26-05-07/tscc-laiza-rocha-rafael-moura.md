---
name: "🚀 Relatório de Progresso"
about: "Implementações no ambiente de co-simulação - métricas probabilísticas, escalabilidade e congestionamentos com redução de largura de banda"
title: "[OPENTES - TSCC] "
labels: pesquisa, software, integração, concluído
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade

Este relatório documenta a expansão da infraestrutura de co-simulação para suportar cenários complexos de rede. Além da comunicação bidirecional básica, implementamos modelos estocásticos de perda de pacotes e jitter, validamos a escalabilidade da topologia em estrela com múltiplos agentes e simulamos o impacto da redução drástica de largura de banda (congestionamento) no comportamento de um sistema multiagente, no caso, com o PADE.

---

### 1. Métricas de Rede e Controle de Fluxo

Simulação de congestionamento: foi adicionado o parâmetro bandwidth_bps, configurável via .ned e .ini, o cálculo do atraso de transmissão passou a considerar transmission_delay = bits / bandwidth_bps
Confiabilidade da rede: foram implementadas métricas de perda de pacotes (packets_dropped) e jitter (current_jitter)

### 2. Inteligência dos Agentes e Topologias (PADE)

Topologia estrela: criação do pade_star.py, com um agente central responsável por coordenar múltiplos agentes periféricos, assim, o agente central continua enviando mensagens mesmo sem respostas, aumentando a tolerância a perdas.
Escalabilidade: testes realizados com Docker Compose em cenários de multíplos agentes.

---

## 🛠 Contexto Técnico
* **Linguagem/Ferramenta:** (X) Python | (X) C++ | (X) Docker | (X) ZeroMQ | (X) PADE
* **Repositório Principal**: [tscc-com-opentes](https://github.com/grei-ufc/tscc-com-opentes)
* **Status do Ambiente:** `Stable / Production-Ready for Scenarios`

## ✅ Checklist de Entrega

- [x] Implementação de largura de banda configurável no OMNeT++.
- [x] Criação de lógica de perda de pacotes (Packet Drop) e Jitter.
- [x] Script de plotagem atualizado para métricas de eficiência e jitter.

## 📈 Resultados / Dificuldades

* **Progresso atual:** 100% [██████████]
* **Resultados:** Conclusão das 3 issues; 1. Implementar métricas probabilísticas de jitter e perda de pacotes no OMNeT++ 2. Avaliar escalabilidade da topologia em estrela com mais agentes 3. Simular cenários de congestionamento com redução de largura de banda.
* **Dificuldades superadas:**

## 📅 Próximos Passos (Pesquisa)

* 

---
