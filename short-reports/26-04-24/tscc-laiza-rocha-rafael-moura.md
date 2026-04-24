
---

name: "🚀 Relatório de Progresso"
about: Avanços na Integração OMNeT++ e Mosaik via ZeroMQ para Co-simulação
title: "[OPENTES - TSCC] Integração e Roteamento de Mensagens FIPA-ACL via OMNeT++ e Mosaik"
labels: pesquisa, software, integração
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade

O presente relatório detalha os avanços cruciais na consolidação do ambiente Dockerizado de co-simulação (Mosaik + PADE + OMNeT++). O foco esteve na resolução de gargalos de rede entre os contentores, na adaptação do C++ para o tráfego de Strings (JSON/FIPA-ACL) e na estabilização da topologia do Mosaik para capturar comunicações e exportar a telemetria corretamente.

---

### 1. Integração OMNeT++ / Mosaik (Via ZeroMQ)
*Foco: Infraestrutura de transporte, lógica de atraso de rede e estabilidade do Docker.*

* **Transporte de Strings JSON (FIPA-ACL):** O `MosaikBridge.cc` foi reescrito para analisar corretamente atributos do tipo string vindos do Mosaik. O código C++ agora varre todas as fontes conectadas à porta `val_in` para garantir que a mensagem real do agente seja capturada, ignorando pacotes vazios.
* **Emulação de Nuvem e Atraso (Self-Message):** O `NetworkNode.cc` foi atualizado para emular o tráfego real sem a necessidade de múltiplos nós. O nó calcula o tamanho da string FIPA-ACL, gera um pacote dinâmico e agenda a sua própria entrega no futuro (`scheduleAt`) para simular os 15ms de latência da rede, expondo a mensagem na porta `val_out` em seguida.
* **Desbloqueio de Variáveis em Runtime:** Resolvido o bloqueio de segurança do OMNeT++ que impedia o Mosaik de injetar dados em tempo de execução. O ficheiro `NetworkNode.ned` foi corrigido com a sintaxe exata da tag `@mutable` (`string val_in @mutable = default("");`), permitindo a comunicação contínua no modelo de lock-step.

### 2. Estabilização da Arquitetura Mosaik e Docker
*Foco: Resolução de dependências cíclicas e comunicação entre contentores.*

* **Correção do Host e Volumes Docker:** A inicialização do PADE foi reconfigurada para expor a interface no IP `0.0.0.0` (rompendo a barreira do `localhost`), permitindo a conexão do Mosaik. O mapeamento de volumes foi alterado para mapeamento de pasta (`./pade_agents:/app/agents`), estabilizando o build e evitando a criação de "pastas fantasma" pelo Docker.
* **Arquitetura de Telemetria Linear (Collector):** Para evitar o erro crítico de dependência cíclica do Mosaik (`ScenarioError: Your scenario contains cycles`) e a complexidade instável da flag `time_shifted`, a arquitetura do orquestrador (`first.py`) foi redesenhada. Os agentes injetam dados na rede OMNeT++, que por sua vez entrega os resultados de latência e a mensagem final diretamente ao **Collector**, gerando um ficheiro `.csv` de forma linear e estável.

---

## 🛠 Contexto Técnico
* **Linguagem/Ferramenta:** (X) Python | (X) C++ | (X) Docker | (X) ZeroMQ | (X) PADE
* **Repositório Principal**: [tscc-com-opentes](https://github.com/grei-ufc/tscc-com-opentes)
* **Ambiente:** `development`

## ✅ Checklist de Entrega

- [X] Correção do Host do PADE para `0.0.0.0` e portas na rede Docker.
- [X] Transição para mapeamento de volumes via diretório no `docker-compose.yml`.
- [X] Adaptação do `NetworkNode.ned` com a flag `@mutable` correta.
- [X] Leitura de arrays de strings simuladas no `MosaikBridge.cc`.
- [X] Implementação de delay de rede via *Self-Message* no C++.
- [X] Reestruturação do `first.py` para roteamento linear Mosaik -> OMNeT++ -> Collector.
- [ ] Validação final dos dados gerados no ficheiro `simulacao_rede.csv`.
- [ ] Implementação de lógica de resposta FIPA-ACL bidirecional entre os Agentes.

## 📈 Resultados / Dificuldades

* **Progresso atual:** 95% [█████████-]
* **Resultados:** A infraestrutura interoperacional em C++ via ZeroMQ no Docker foi totalmente superada. O Mosaik compila o cenário linear com sucesso, o OMNeT++ processa os delays temporalmente corretos de forma interna e o sistema transita do instante inicial até à conclusão da simulação sem crashes.
* **Dificuldades superadas:** 1. Criação de pastas em vez de ficheiros pelo volume do Docker. 
  2. Rigidez do C++ do OMNeT++ com strings e variáveis não-mutáveis em tempo de execução. 
  3. Erros de restrição de grafos direcionados no Mosaik ao tentar rotas circulares.

## 📅 Prazo Estimado 

* Data de entrega pretendida: 01/05/2026

## 📋 Planejamento para conclusão da entrega

* **Passo 1.** Executar a infraestrutura para gerar os logs completos.
* **Passo 2.** Analisar o ficheiro CSV gerado pelo Collector para confirmar se o payload FIPA-ACL e as latências (15ms) foram registados com sucesso a cada passo da simulação.
* **Passo 3.** Desenvolver a lógica no PADE para que o Agente B processe a mensagem recebida e envie uma resposta, testando a bidirecionalidade através do Mosaik.

---
