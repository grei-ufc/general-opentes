---

name: "🚀 Relatório de Progresso"
about: Avanços segregados entre Integração OMNeT++ e Evolução PADE/Mosaik (Tese)
title: "[OPENTES - TSCC] Desenvolvimento de aplicações de co-simulação e suporte a frameworks de agentes"
labels: pesquisa, software, integração
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade

O presente relatório detalha os avanços em duas frentes distintas de pesquisa: o desenvolvimento da infraestrutura de comunicação **OMNeT++/Mosaik** e o suporte à evolução do framework **PADE** dentro do ecossistema de co-simulação vinculado à tese da Profa. Janaína.

---

### 1. Integração OMNeT++ / Mosaik (Via ZeroMQ)
*Foco: Infraestrutura de transporte e lógica de atraso de rede.*

* **Organização do Repositório:** O repositório `tscc-com-opentes` foi reestruturado. A branch `main` agora reflete o estado estável da integração via ZeroMQ.
* **Documentação e README.md:** Atualização completa do arquivo de documentação com o passo-a-passo para build dos containers e execução do cenário, garantindo a reprodutibilidade da integração.
* **Broker como Oráculo de Rede:** O Broker foi configurado para atuar apenas como repassador: ele intercepta a mensagem, consulta o OMNeT++ sobre o tempo de tráfego (baseado no tamanho do pacote) e retém a entrega até que o tempo simulado coincida com o atraso calculado.

### 2. Evolução PADE / Mosaik (Suporte à Tese)
*Foco: Otimização da interface de comunicação e eliminação de instabilidades.*

* **O Problema (sim-warning):** Inicialmente, o Mosaik tratava os pacotes de comunicação, isso gerava warnings constantes de dados ausentes, como se um agente estivesse inativo e criava o risco real de perda de pacotes caso as mensagens chegassem fora do ciclo fixo de leitura da Interface.
* **A Solução (sim-withoutwarning.png):** A arquitetura foi reconfigurada para o **modo hybrid**. Os sinais de comunicação foram explicitamente classificados como eventos discretos (*non-persistent*).
* **Mecanismo de Gatilho:** A Interface passou a usar esses eventos como gatilhos (**trigger**) para despertar instantaneamente sob demanda. O resultado foi a eliminação completa dos warnings e a garantia de zero perda de dados.
* **Arquitetura atualizada:** Atualização completa do ambiente para **Mosaik 3.6.0**, **PADE** e **Python 3.10.20**.

---

## 🛠 Contexto Técnico
* **Linguagem/Ferramenta:** (X) Python | (X) C++ | (X) Docker | (X) ZeroMQ | (X) PADE
* **Repositório Principal**: [tscc-com-opentes](https://github.com/grei-ufc/tscc-com-opentes)
* **Branch de Trabalho:** `main` (Integração OMNeT/Mosaik)

## ✅ Checklist de Entrega

- [X] Branch `main` atualizada e organizada.
- [X] **README.md com guia de integração via ZeroMQ finalizado.**
- [X] Migração para Modo Hybrid (Trigger) no projeto PADE/Mosaik.
- [X] Classificação de pacotes como eventos discretos (*non-persistent*).
- [X] Eliminação de warnings de dados ausentes (`fpp_msk`, `feq_msk`).
- [ ] Validação dos resultados de latência com o orientador.

## 📈 Resultados / Dificuldades

* **Progresso atual:** 100% [████████] → 100%
* **Resultados:** A mudança para o modo híbrido/trigger no PADE resolveu o gargalo de performance e confiabilidade. Paralelamente, a `main` do repositório de integração agora serve como base sólida e documentada para o transporte via ZeroMQ.
* **Bloqueios:** Nenhum bloqueio identificado.

## 📅 Prazo Estimado 

* Data de entrega pretendida: 17/04/2026

## 📋 Planejamento para conclusão da entrega

* Passo 1. Validar se o Broker está segurando corretamente as mensagens conforme o tempo do OMNeT++.
* Passo 2. Realizar testes de carga na interface híbrida com maior volume de mensagens.
* Passo 3. Revisão final da documentação de integração.

---
