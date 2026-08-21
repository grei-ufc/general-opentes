---
name: "🚀 Relatório de Progresso"
about: ""
title: "[OPENTES - TSCC]"
labels: pesquisa, software, integração, progresso
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade

Continuidade da redação do artigo, em paralelo, anaçamos nos itens anteriormente postados como 'próximos passos';
Mapeamento espacial dos agentes e refatoração dos painéis de visualização.

* **Linguagem/Ferramenta:** (x) Python | (x) C++ | (x) Docker | (x) ZeroMQ | (x) PADE | (x) OMNeT++
* **Repositório Principal:** tscc-com-opentes
* **Status do Ambiente:** Estável / Totalmente Integrado

## ✅ Checklist de Entrega

* [x] Implementação do posicionamento geográfico dos agentes em grid bidimensional (1000x1000m), com o nó central fixo no centro e periféricos distribuídos aleatoriamente.
* [x] Cálculo de atraso de propagação e probabilidade de descarte por atenuação em função da distância euclidiana entre nós (`AgentNode.cc`), correlacionando geolocalização e comportamento de rede.
* [x] Geração automática do arquivo de posições (`posicoes.json`), compartilhado entre o gerador de cenário (Mosaik) e os scripts de análise.
* [x] Refatoração completa do dashboard de telemetria: painel de latência com faixa de variação (min/max), boxplot de distribuição de jitter por tecnologia, tabela comparativa de desempenho por perfil de rede (Cabeada/5G/4G/IoT) e heatmap geoespacial de latência.
* [x] Geração de visão "Geral" e visões individuais por tecnologia de rede (5 painéis exportados por execução).
* [x] Documentação e revisão técnica linha a linha de toda a base de código (`mosaik-dir`, `omnet-dir`, `pade-dir`), como preparação para a redação do artigo.
* [ ] Redação do artigo científico — em andamento.

## 📈 Resultados / Dificuldades

### **Resultados Alcançados (Pesquisa):**
* **Correlação Espacial:** A distância física entre agente central e periféricos agora influencia diretamente a latência simulada e a taxa de descarte, permitindo análises do tipo "quanto mais longe, pior a troca".
* **Dashboards Comparativos:** Os painéis agora isolam e comparam as 4 tecnologias de rede simultaneamente (visão geral) e individualmente (visão focada por tecnologia), incluindo métricas de percentil 95 de latência, além da média — mais robusta a outliers do que a média isolada.


### **Resultados Alcançados (Software):**

* **Ecossistema Escalável:** A plataforma agora é capaz de instanciar dezenas de agentes PADE dinamicamente, gerando os respectivos clones físicos no OMNeT++ (via `.ned` gerado on-the-fly pelo Mosaik).
* **Física de Rede Realista:** Os agentes agora se comunicam através de perfis físicos de cabo heterogêneos (Wired, 5G, 4G, IoT), com o OMNeT++ aplicando restrições de Packet Error Rate (Drop) e Latência individualmente.
* **Telemetria de Alta Resolução:** Geração de dashboards analíticos detalhando Tamanho de Payload, Jitter por Origem, Latência Resolvida e Confiabilidade Global.

### **Dificuldades Identificadas & Solucionadas (Debugging Concluído):**

*

## 📅 Próximos Passos
* **Generalização de Topologia:** Atualmente a plataforma simula exclusivamente topologia estrela (1 nó central + N periféricos, sempre a 1 salto). Planeja-se generalizar a geração de cenário (`star.py`) para aceitar diferentes formatos de rede (ex.: malha, anel, árvore hierárquica), avaliando o impacto de diferentes padrões de dependência causal entre os simuladores sobre o mecanismo de sincronização, além de comparar o comportamento da física de rede sob topologias distintas.
---
