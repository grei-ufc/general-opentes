---
name: "🚀 Relatório de Progresso"
about: "revisão bibliográfica"
title: "[OPENTES - TSCC]"
labels: pesquisa, software, integração, progresso
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade

Revisão bibliográfica, com separação de artigos envolvendo o cosima e feita a revisão efetiva em 1 dos artigos, o 'cosima-mango: Investigating Multi-Agent System robustness through integrated communication simulation', mais focada na comparação entre os frameworks de Sistemas Multiagentes (SMA) PADE e Mango, com ênfase em suas arquiteturas, aderência ao padrão FIPA e capacidades de integração para co-simulação de redes de comunicação e sistemas de potência (utilizando ferramentas como Mosaik e OMNeT++).

Em paralelo, avançamos no desenvolvimento prático da plataforma `tscc-com-opentes`, estabelecendo a integração cibernético-física definitiva entre a inteligência multiagente e a física de redes.

* **Linguagem/Ferramenta:** (x) Python | (x) C++ | (x) Docker | (x) ZeroMQ | (x) PADE | (x) OMNeT++
* **Repositório Principal:** tscc-com-opentes
* **Status do Ambiente:** Estável / Totalmente Integrado

## ✅ Checklist de Entrega

* [x] Revisão bibliográfica iniciada.
* [x] Migração da arquitetura OMNeT++ centralizada ("Supernó") para nós independentes e descentralizados.
* [x] Implementação de Filas de Buffer (`cPacketQueue`) no C++ para lidar com rajadas de rede (Bursts).
* [x] Integração completa do padrão FIPA-ACL (leitura da matriz de `receivers` no C++).
* [x] Escalonamento automático da simulação testado para 50+ agentes via variáveis de ambiente Docker.
* [x] Implementação de atrasos de rede estocásticos (Jitter Real) simulando ruído Wireless (4G/5G).

## 📈 Resultados / Dificuldades

### **Resultados Alcançados (Pesquisa):**

* Comparativo Estrutural (PADE vs. Mango): Identificou-se que o PADE é altamente especializado em smart grids, com infraestrutura FIPA/AMS nativa, comunicação baseada em Twisted, integração pronta com o simulador Mosaik (API 3.0+) e sistema de logging nativo em CSV. O Mango, por sua vez, é mais genérico, construído sobre asyncio e permite maior liberdade, mas exige que o usuário implemente o orquestrador de tempo e os wrappers de comunicação.
* Link da validação comparativa por IA: [https://claude.ai/share/b4c34101-3eb4-4a2d-83cc-b6faf208cc2f](https://claude.ai/share/b4c34101-3eb4-4a2d-83cc-b6faf208cc2f)

### **Resultados Alcançados (Software):**

* **Ecossistema Escalável:** A plataforma agora é capaz de instanciar dezenas de agentes PADE dinamicamente, gerando os respectivos clones físicos no OMNeT++ (via `.ned` gerado on-the-fly pelo Mosaik).
* **Física de Rede Realista:** Os agentes agora se comunicam através de perfis físicos de cabo heterogêneos (Wired, 5G, 4G, IoT), com o OMNeT++ aplicando restrições de Packet Error Rate (Drop) e Latência individualmente.
* **Telemetria de Alta Resolução:** Geração de dashboards analíticos detalhando Tamanho de Payload, Jitter por Origem, Latência Resolvida e Confiabilidade Global.

### **Dificuldades Identificadas & Solucionadas (Debugging Concluído):**

* **Gargalo Físico (Channel Busy):** O OMNeT++ bloqueava envios simultâneos (Bursts) devido ao estrangulamento do canal físico. *Solução:* Criação de filas de memória reais no C++ (`cPacketQueue`) e agendamento assíncrono de envios via alarmes temporais.
* **Falso Jitter & Routing:** O OMNeT++ misturava os tempos de chegada de diferentes cabos. *Solução:* Criação de uma tabela Hash (`std::map`) no C++ para isolar a latência histórica por origem e rotear mensagens FIPA corretamente lendo a tag JSON `"receivers"`.
* **Descoberta Dinâmica de Nós:** O OMNeT++ exigia nomes hardcoded para novos agentes. *Solução:* Programação do C++ para extrair a própria identidade nativamente (`getName()`), suportando escalonamento infinito.

## 📅 Próximos Passos

* **Visualização:** Refatorar e melhorar os gráficos de plotagem da telemetria (Painéis do Dashboard) para tornar a interpretação de dados massivos mais limpa e de fácil entendimento geral.
* **Mapeamento Espacial:** Implementar o posicionamento geográfico dos agentes em um plano cartesiano bidimensional, permitindo correlacionar a distância física com a latência ou o comportamento de rede.
* **Redação:** Terminar a revisão dos demais artigos listados e finalizar a escrita do artigo principal.

---
