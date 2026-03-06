## Relatório geral (resumo) — Pasta `short-reports/26-02-27`

A pasta reúne **5 mini relatórios** com atividades técnicas em andamento,
majoritariamente em **Python** e **Docker**, ligadas ao ecossistema OpenTES e
ferramentas associadas. No geral, os trabalhos se dividem em:

(i) **infraestrutura/containerização e comunicação entre containers**,

(ii) **ferramentas de análise/visualização de dados de simulação**, e

(iii) **estudo/atualização de frameworks e modelos**.

A maior parte das entregas aponta prazo para **06/03/2026**.

### 1) TSCC — Laiza Rocha: container OMNeT++ (MOSAIK + OMNeT++ + COSIMA)

- **Objetivo:** diagnosticar e corrigir falha de **inicialização do container
  OMNeT++** no contexto do ambiente MOSAIK + OMNeT + COSIMA.
- **Abordagem atual:** **reconstrução do Dockerfile do OMNeT++** tomando como
  referência o Dockerfile do COSIMA e realizando testes localmente antes de
  subir para a branch.
- **Status:** ~**65%**, com **bloqueio** na identificação da causa raiz
  (suspeita de incompatibilidades/ausências no Dockerfile atual).
- **Próximos passos:** finalizar Dockerfile, rebuild e validar subida do
  container, checar rede/portas e avançar para **comunicação TCP MOSAIK ↔
  OMNeT++**.
- **Prazo pretendido:** **06/03/2026**.

### 2) TSCC — Rafael Moura: comunicação entre containers (infraestrutura de rede)

- **Objetivo:** configurar **infraestrutura de comunicação entre dois containers
  Docker** usando o projeto OpenTES.
- **Entregue/validado:** containers rodando simultaneamente, **rede
  compartilhada**, **DNS/hostname** funcionando e conectividade básica
  (ping/porta).
- **Pendente:** a **camada de aplicação** (envio/recebimento de mensagens e
  teste bidirecional) **ainda não foi implementada/validada**.
- **Status:** ~**80%** (rede pronta; aplicação pendente).
- **Dificuldades:** permissões do Docker daemon (`/var/run/docker.sock`) e
  ajustes de configuração de rede/host/porta.
- **Prazo pretendido:** **28/02/2026** (report indica “dentro do cronograma”).

### 3) TSDQ — Luiz Alberto: ferramenta em Python (Streamlit/Pandas) para OpenDSS

- **Objetivo:** atualizar scripts **Python (Streamlit + Pandas)** para
  leitura/visualização de **correntes e potências** de simulações extraídas do
  **OpenDSS** e recuperar/organizar funções da plataforma anterior.
- **Entregue/feito:** documentação em código; criada ferramenta de auditoria de
  dados (**“Comparador Universal”**); base de visualização em andamento.
- **Bloqueios:** monitores ainda focados em tensão/corrente — precisa
  implementar **monitores para potência**; além disso, há problema de
  **formato** na extração (gera vários CSVs no Colab que não batem com o formato
  de entrada esperado). Precisa gerar CSV no **formato padrão** de entrada
  (compatível com co-simulação).
- **Status:** ~**83%**.
- **Prazo pretendido:** **06/03/2026**.

### 4) TSRE — Paulo Victor: estudo do OpenDER (EPRI) e IEEE 1547-2018

- **Objetivo:** devido à ausência de demandas práticas na semana, foi realizado
  **estudo do OpenDER** (modelo de recursos energéticos distribuídos da EPRI),
  com base na **IEEE 1547-2018**.
- **Resultados:** leitura/levantamento inicial da documentação, entendimento de
  que o modelo é **Python**, **modular**, e cobre aspectos de FV e baterias.
- **Pendente:** finalizar leitura e **executar exemplos** disponíveis.
- **Status:** ~**45%**.
- **Prazo pretendido:** **06/03/2026**.

### 5) TTESO — Douglas Barros: atualização do PADE para Python 3.12.11 + logging CSV

- **Objetivo:** migrar o **PADE** de Python **3.8 → 3.12.11**, removendo
  dependências obsoletas (ex.: Flask/SQLAlchemy/Alchimia) e implementando **novo
  sistema de logging em CSV**.
- **Entregue/feito:** atualização documentada (ex.: método `react()`), testes
  com script **ping-pong** (53 ciclos), correções de bug (duplicidade de IDs),
  melhorias utilitárias (`format_message_content`), correção no Sniffer (import
  `reactor`), e testes de comandos de logs (`show-logs`, `export-logs`).
- **Bloqueio atual:** ainda aparecem **erros/“resíduos” hexadecimais** no
  `events.csv` gerado pelo sniffer; faltam testes formais com cenários reais e
  documentação final (incluindo caracteres especiais/conteúdos complexos).
- **Status:** ~**75%**.
- **Prazo pretendido:** **06/03/2026** (ajustado; antes era 02/03/2026).

---

## Síntese

- **Infraestrutura/containers:** há um eixo forte em **Docker e ambiente
  distribuído**:
  - Um trabalho está focado em **fazer o container OMNeT++ subir de forma
    estável** (Laiza), e outro em **garantir conectividade entre containers**
    (Rafael) — porém ainda falta o passo decisivo de **mensageria em nível de
    aplicação**.
- **Ferramentas e engenharia de software em Python:** duas frentes relevantes:
  - **Interface/visualização e auditoria de dados** (TSDQ com Streamlit/Pandas +
    OpenDSS), com gargalo de padronização de CSV/saídas.
  - **Manutenção/migração de framework (PADE)** para versão moderna do Python +
    **logging estruturado**, com pendência de limpeza/robustez do sniffer e
    validações mais realistas.
- **Pesquisa/estudo:** uma frente (TSRE) está em etapa de **estudo e
  experimentação inicial** do OpenDER, devendo avançar com execução prática dos
  exemplos.

