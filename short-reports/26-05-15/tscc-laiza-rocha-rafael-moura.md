---
name: "🚀 Relatório de Progresso"
about: "Atualização da resolução da telemetria (Multiplexagem) e início da implementação da CLI da Plataforma"
title: "[OPENTES - TSCC] Evolução da Telemetria e Interface de Usuário"
labels: pesquisa, software, integração, progresso
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade
Esta semana o foco foi a integridade dos dados simulados e a usabilidade da ferramenta para terceiros. Corrigimos um erro crítico de amostragem (Aliasing) que ocultava dados de pacotes simultâneos e iniciamos a transição para um ambiente de "Infraestrutura como Serviço", onde o usuário pode escolher a aplicação via menu, eliminando a necessidade de editar manualmente o arquivo `docker-compose.yml`.

### 1. Telemetria de Alta Resolução (Fim do Aliasing)
* **Multiplexagem de Métricas (C++):** Alteramos os módulos `NetworkNode.cc` e `MosaikBridge.cc` para que as métricas de rede (latência, jitter, tamanho do pacote) deixem de ser variáveis simples (sobrescritas pelo último valor). Agora, o OMNeT++ gera strings multiplexadas separadas por `|||`.
* **Fidelidade Visual (Python):** Os scripts `plot_results.py` e `plot_results_star.py` foram atualizados para desempacotar esses arrays de dados. Isso garante que mensagens de diferentes tamanhos que chegam no mesmo "step" do Mosaik sejam plotadas individualmente, acabando com a sobreposição errônea de informações no dashboard.

### 2. Interface de Comando da Plataforma (CLI)
* **`plataforma.py`:** Iniciamos a implementação de um script orquestrador em Python que serve como interface para o pesquisador.
* **Abstração do Docker:** O objetivo é que o usuário não precise lidar com comandos complexos de terminal. O script gerencia o reinício da rede física (OMNeT++), a limpeza da camada lógica (PADE) e o acionamento do maestro (Mosaik) automaticamente conforme a opção escolhida.

## 🛠 Contexto Técnico
* **Linguagem/Ferramenta:** (X) Python | (X) C++ | (X) Docker | (X) ZeroMQ | (X) PADE
* **Repositório Principal:** tscc-com-opentes
* **Status do Ambiente:** In Transition / Menu under debugging

## ✅ Checklist de Entrega
- [x] Implementação de strings multiplexadas para telemetria no C++ (High Resolution).
- [x] Atualização dos scripts de plotagem para suporte a múltiplos pontos por "step".
- [x] Protótipo do menu interativo `plataforma.py` (Cenários 1, 2 e 3).

## 📈 Resultados / Dificuldades
* **Progresso atual:** 90% [█████████░]
* **Resultados:** Gráficos agora são 100% fiéis à física do simulador, mostrando a nuvem de pontos real das respostas dos periféricos.
* **Dificuldades identificadas (Ainda não funcional):**
  * **Conectividade de Portas:** Ao rodar os scripts via exec do Docker, a porta 5678 (Mosaik) e 8000 (AMS) apresentaram falhas de abertura por problemas de temporização e escopo do bloco `__main__`.
  * **Sintaxe do PADE:** Identificamos que o comando `start-runtime-detailed` causava falhas no arranque; a correção para a sintaxe oficial e flags de porta está em andamento.
  * **Ambiente Isolado:** Erros de "ModuleNotFoundError" no container do Mosaik revelaram que as dependências (`matplotlib`) precisam ser garantidas no modo de execução ociosa.

## 📅 Próximos Passos (Pesquisa)
* Estabilizar a inicialização do motor PADE via CLI, garantindo que o socket abra corretamente.
* Finalizar a blindagem do container `mosaik_master` para suportar as bibliotecas gráficas em qualquer cenário.
