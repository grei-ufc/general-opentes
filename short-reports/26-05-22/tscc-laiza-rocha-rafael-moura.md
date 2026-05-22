---
name: "🚀 Relatório de Progresso"
about: "Parâmetros de Rede Wireless"
title: "[OPENTES - TSCC] Evolução da Telemetria e Interface de Usuário"
labels: pesquisa, software, integração, progresso
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade
Esta semana o foco foi um estudo teórico na modelação de canais de comunicação sem fios (5G e Wi-Fi) e dos parâmetros do OMNeT++ para a futura injeção de perfis reais de conectividade wireless.
### O saldo do estudo de Parâmetros: 
Realizámos um levantamento teórico sobre o comportamento e a atuação de redes 5G e Wi-Fi, focando-se em métricas restritivas como velocidade de transmissão, perfis de latência e taxas de perda de pacotes, e uma análise na configuração e topologia de rede no arquivo Network.ned (onde reside o submodule MosaikBridge) e as parametrizações no omnetpp.ini. Identificámos que as simulações atuais de degradação de canal (como a largura de banda de 50000.0 bps, drop_probability = 0.15 e jitter_mean = 0.05 no node_0) estão centralizadas e prontas para alterações dos parâmetros e adicionais deles correspondentes aos perfis de 5G e Wi-Fi.
## 🛠 Contexto Técnico
* **Linguagem/Ferramenta:** (X) Python | (X) C++ | (X) Docker | (X) ZeroMQ | (X) PADE
* **Repositório Principal:** tscc-com-opentes
* **Status do Ambiente:** In Transition / Menu under debugging

## ✅ Checklist de Entrega
- [x] Estudo teórico e mapeamento dos parâmetros de perda, jitter e largura de banda para perfis 5G/Wi-Fi no OMNeTpp.

## 📈 Resultados / Dificuldades
* **Progresso atual:** 90% [█████████░]
* **Resultados:** O mapeamento do omnetpp.ini confirmou que a arquitetura suporta a injeção dos novos parâmetros sem necessidade de refatoração estrutural brutal.
* **Dificuldades identificadas (Ainda não funcional):**
  * Abstração Sem Fios: Embora a teoria indique que basta alterar os parâmetros existentes em omnetpp.ini e Network.ned, o desafio será calibrar empiricamente as taxas de perda (drop_probability) e atraso caótico (jitter_mean) para simular fielmente a instabilidade de uma ligação 5G vs Wi-Fi.
## 📅 Próximos Passos (Pesquisa)
* Aplicação Prática de Redes: Alterar os parâmetros de rede no omnetpp.ini e estender as propriedades dos nós em Network.ned para injetar e testar os perfis validados de velocidade e perda do 5G e Wi-Fi.
