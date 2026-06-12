---
name: "🚀 Relatório de Progresso"
about: "Parâmetros de Rede Wireless e Heterogeneidade"
title: "[OPENTES - TSCC] Evolução da Telemetria, Protocolo FIPA e Rede Heterogênea"
labels: pesquisa, software, integração, progresso
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade
Refatoração completa da camada de comunicação entre agentes PADE na co-simulação `tscc-com-opentes`. O ecossistema foi migrado para uma arquitetura de **Lock-in Arquitetural**, substituindo o tráfego manual de dicionários Python brutos pelo uso estrito de protocolos FIPA nativos (`ACLMessage`) gerenciados pelos motores cognitivos do PADE (`send()` e `react()`). 

Além disso, a atividade engloba a estabilização do canal de comunicação contra perdas por concorrência temporal e o início da transição do modelo de rede física no OMNeT++ para uma topologia estrela elástica e **heterogênea**, delegando o cálculo de atrasos e descartes aos canais físicos reais (`DatarateChannel`) do simulador de rede.

## 🛠 Contexto Técnico
* **Linguagem/Ferramenta:** (X) Python | (X) C++ | (X) Docker | (X) ZeroMQ | (X) PADE | (X) OMNeT++
* **Repositório Principal:** tscc-com-opentes
* **Status do Ambiente:** In Transition / Under debugging (Ajuste de sincronismo no Docker)

## ✅ Checklist de Entrega
- [x] Identificação e eliminação de métodos proprietários que substituíam o protocolo FIPA.
- [x] Alinhamento dos métodos FIPA com a referência acadêmica validada (tese da profa. Janaína Almada).
- [x] Implementação do mecanismo de "Lock-in" interceptando o método `send()` do PADE e roteando via Mosaik.
- [x] Criação de buffers/filas de mensagens baseados no delimitador lógico `|||` no envio e recebimento, **eliminando completamente o risco de sobrescrita de informações** em alta densidade de tráfego.
- [x] Migração estrutural do arquivo `.ned` para uma topologia elástica parametrizável usando matrizes de portas (`in[parent.numPerifericos]`).
- [ ] Conclusão do mapeamento de métricas individuais por link (Jitter, Banda e Perda) via `omnetpp.ini` (Rede Heterogênea).

## 📈 Resultados / Dificuldades

### **Resultados Alcançados:**
* **Comunicação FIPA Pura:** Os agentes agora operam 100% sob o padrão FIPA-ACL (utilizando máquinas de estado nativas como `FipaRequestProtocol`). O OMNeT++ e o Mosaik agem de forma invisível abaixo da aplicação.
* **Fila Anti-Sobrescrita Concluída:** O problema crítico de perda de pacotes causados pelo avanço de passos do Mosaik (onde um dado novo apagava o anterior antes da virada de ciclo) foi resolvido. O `MosaikSim` atua como demultiplexador fatiando strings enfileiradas com `|||`, e a classe do Agente acumula requisições de forma robusta no envio.
* **Simplificação do Código C++:** O nó de rede (`NetworkNode.cc`) foi limpo de rotinas matemáticas manuais complexas, convertendo-se em um gateway de roteamento puro que despacha pacotes diretamente para os canais físicos do OMNeT++.

### **Dificuldades Identificadas (Em Debugging):**
* **Condição de Corrida no Docker (*Race Condition*):** Ao remover os agendamentos internos do C++ para permitir que o OMNeT++ funcione de forma heterogênea guiado pelos canais, o executável do OMNeT++ passou a processar sua linha do tempo virtual de forma instantânea em microssegundos reais. Como o container do Mosaik Master demora alguns segundos para inicializar e instalar pacotes Python (como o `matplotlib`), o OMNeT++ atinge o seu limite (`sim-time-limit`) e encerra o container antes que o orquestrador Mosaik consiga abrir o socket de conexão ZMQ.

## 📅 Próximos Passos (Pesquisa)
* Implementar a rotina de retenção por *sleep* real (`usleep`) ou sincronia bloqueante no ciclo `keep_alive` do `NetworkNode.cc` para impedir a finalização prematura do OMNeT++ no Docker.
* Validar a flexibilidade do framework chaveando cenários heterogêneos de 2 agentes (P2P), 10 agentes e 50 agentes no `omnetpp.ini` usando o mesmo binário compilado.
* Consolidar os testes de leilões e telemetria do *openTES* sob canais de rede degradados de forma independente.
