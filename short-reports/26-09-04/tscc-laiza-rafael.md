---
## name: "🚀 Relatório de Progresso"
about: "CONFIGURAÇÃO DA CO-SIMULAÇÃO + PÁGINA WEB"
title: "[OPENTES - TSCC]"
labels: pesquisa, software, integração, progresso
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"

## 📌 Descrição da Atividade

Nesta etapa, o foco central foi a refatoração profunda da topologia em Anel (Ring), que antes operava de forma engessada (fixada em 4 agentes), para suportar **escalabilidade dinâmica plena**, nivelando-a à flexibilidade já existente na topologia Estrela. Para viabilizar esse avanço, foi implementada uma nova arquitetura matemática nos scripts de configuração. Simultaneamente, os motores de geração de gráficos (`plot_results_anel.py` e `plot_results_malha.py`) receberam atualizações críticas para suportar a visualização massiva de dados sem poluição visual.

* **Linguagem/Ferramenta:** (X) Python | (X) C++ | (X) Docker | (X) ZeroMQ | (X) PADE | (X) OMNeT++ | (X) Streamlit
* **Repositório Principal:** tscc-com-opentes/development
* **Status do Ambiente:** Estável / Totalmente Integrado

## ✅ Checklist de Entrega

* [X] Escalabilidade dinâmica da topologia Anel (suporte para *N* periféricos).
* [X] Implementação de trigonometria e aritmética modular para roteamento circular dinâmico.
* [X] Atualização do painel executivo `plot_results_anel.py` (agrupamento por redes e renderização gráfica avançada).
* [X] Atualização do painel executivo `plot_results_malha.py`.

## 📈 Resultados / Dificuldades

* A visualização em larga escala exigiu a transição do acompanhamento "por agente" para o acompanhamento "por tipo de rede", a fim de manter a legibilidade dos dashboards.

### **Resultados Alcançados (Software e Pesquisa):**

* **Elasticidade Matemática:** O `mosaik_anel.py` e o `pade_anel.py` agora calculam posições geográficas em tempo de execução usando trigonometria ($seno$ e $cosseno$) e definem o roteamento de cabos P2P usando aritmética modular (operador `%`), permitindo que a rede de Anel escale para centenas de nós instantaneamente via variável do Docker.
* **Painéis Avançados:** O dashboard do Anel agora mapeia os nós dinamicamente no espaço geométrico e plota os enlaces coloridos conforme a tecnologia (Cabeada, 5G, 4G, 2G, Wireless), consolidando a performance na tabela resumo por tipo de enlace. A topologia Malha também teve sua inteligência de plotagem aprimorada.

## 📅 Próximos Passos

* **Imagens no Dashboard:** Inclusão de imagens representativas da topologia (Estrela, Malha ou Anel) diretamente no menu de entrada do Streamlit para melhor UX.
* **Validação Universal:** Executar testes de validação para comprovar o sucesso e a estabilidade de todas as topologias parametrizadas e iniciadas exclusivamente a partir da interface web.
* **Estresse Físico de Memória RAM:** Adicionar mecanismos para estressar a memória da rede, forçando o OMNeT++ a processar latência e gargalos baseados no **tamanho (payload)** das mensagens, e não apenas na contagem de pacotes.
* **Fragmentação Realista (MTU):** Implementar lógica para que mensagens que excedam o limite máximo de transmissão sejam divididas fisicamente em várias partes. Caso ocorra a perda de um único pacote (fragmento) no meio físico, o simulador deverá invalidar e descartar a mensagem inteira na camada de aplicação.
