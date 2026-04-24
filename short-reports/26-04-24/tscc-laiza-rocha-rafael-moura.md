---
name: "🚀 Relatório de Progresso - Finalização da Integração"
about: Conclusão da Co-simulação Bidirecional OMNeT++, Mosaik e PADE
title: "[OPENTES - TSCC] Conclusão: Comunicação Bidirecional em Lock-step com Física de Rede Dinâmica"
labels: pesquisa, software, integração, concluído
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade

Este relatório marca a conclusão da fase de integração da infraestrutura de co-simulação. Superamos o desafio da comunicação unidirecional, estabelecendo um ciclo completo de "Ping-Pong" entre agentes PADE, mediado pelo motor C++ do OMNeT++. A principal evolução reside na transição de atrasos fixos para um **modelo matemático de latência baseado em largura de banda e tamanho de pacote**, validando a precisão científica do ambiente.

---

### 1. Física de Rede e Sincronismo C++ (OMNeT++)
*Foco: Precisão matemática da latência e integridade das mensagens.*

* **Cálculo Dinâmico de Latência:** O `NetworkNode.cc` foi evoluído para calcular a latência total como: `Atraso de Propagação (10ms) + Atraso de Transmissão (Bits / Largura de Banda)`. Isso resultou em latências variáveis (ex: 28,08ms para 113 bytes vs. 26,16ms para 101 bytes), provando a sensibilidade do simulador ao payload.
* **Proteção de Sobrescrita (MosaikBridge):** Implementada uma trava lógica no `MosaikBridge.cc` para ignorar strings vazias vindas do Mosaik em passos ociosos. Isso impediu que mensagens legítimas em processamento no OMNeT++ fossem apagadas por "cabos vazios" em instantes subsequentes.
* **Injeção em Tempo Inicial (t=0):** Refatoração da função `initialize()` na ponte C++ para ler os inputs do Mosaik logo no comando de `step 0`, garantindo que a primeira mensagem do Agente A não fosse descartada no arranque.

### 2. Inteligência dos Agentes e Sincronismo Temporal (PADE)
*Foco: Alinhamento entre o tempo simulado (Mosaik) e o tempo real (Python).*

* **Remoção de Atrasos de "Wall-Clock":** Eliminamos o uso de `reactor.callLater` (tempo real) nos agentes. A lógica de resposta agora é instantânea no nível do código Python, permitindo que o Mosaik capture a reação do Agente B dentro do mesmo ciclo de simulação, respeitando os "ticks" do relógio central.
* **Loop Bidirecional Infinito:** Implementada lógica de reciprocidade na função `receber_mensagem_da_rede`. O Agente A agora reage às respostas do Agente B, criando um fluxo contínuo de tráfego que satura a rede até o fim do tempo de simulação (`until=20`).

### 3. Visualização Automática e Telemetria
*Foco: Extração de evidências para a tese.*

* **Dashboard de Performance:** O script `plot_results.py` foi automatizado via Docker Compose. Agora, ao fim de cada execução, o sistema gera automaticamente um gráfico de dois painéis correlacionando o **Tamanho do Pacote** com a **Latência Calculada**, fornecendo prova visual da integração.

---

## 🛠 Contexto Técnico
* **Linguagem/Ferramenta:** (X) Python | (X) C++ | (X) Docker | (X) ZeroMQ | (X) PADE
* **Repositório Principal**: [tscc-com-opentes](https://github.com/grei-ufc/tscc-com-opentes)
* **Status do Ambiente:** `Stable / Production-Ready for Scenarios`

## ✅ Checklist de Entrega

- [x] Correção do Host do PADE e mapeamento de volumes estável.
- [x] Implementação de latência dinâmica (Propagação + Transmissão) no C++.
- [x] Sincronização de resposta dos agentes com o tempo do Mosaik.
- [x] Implementação de conexões `time_shifted` bidirecionais no `first.py`.
- [x] Automação da geração de gráficos de desempenho (`grafico_trafego.png`).
- [x] Validação da integridade de pacotes FIPA-ACL em 20 passos de simulação.

## 📈 Resultados / Dificuldades

* **Progresso atual:** 100% (Fase de Integração Base) [██████████]
* **Resultados:** Sucesso absoluto na troca de mensagens entre contentores isolados. O sistema provou ser determinístico: mensagens de tamanhos diferentes resultam em latências matematicamente calculáveis e repetíveis. O log final confirmou o processamento de 20 pacotes com sucesso.
* **Dificuldades superadas:** 1. Dessincronização entre o relógio do Python (Twisted) e o relógio discreto do Mosaik. 2. Perda de mensagens no `t=0` por falta de leitura na inicialização do C++. 3. Interferência de port-scanning externo (TLS Handshakes) confundida com erro de aplicação.

## 📅 Próximos Passos (Pesquisa)

* Simular cenários de congestionamento (reduzindo a largura de banda no C++).
* Testar a escalabilidade com o aumento do número de agentes na topologia em estrela.
* Implementar métricas de jitter e perda de pacotes baseadas em probabilidades estocásticas no OMNeT++.

---
