# Relatório geral (resumo) — Pasta `short-reports/26-02-27`

A pasta reúne **5 mini relatórios** com atividades técnicas em andamento,
majoritariamente em **Python** e **Docker**, ligadas ao ecossistema OpenTES e
ferramentas associadas. No geral, os trabalhos se dividem em:

(i) **infraestrutura/containerização e comunicação entre containers**,

(ii) **ferramentas de análise/visualização de dados de simulação**, e

(iii) **estudo/atualização de frameworks e modelos**.

A maior parte das entregas aponta prazo para **06/03/2026**.

## Resumo dos relatórios produzidos pelos desenvolvedores

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

### 5) TTESO — Douglas Barros: atualização do PADE para Python 3.12 + logging CSV

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

## Síntese dos mini relatórios da semana

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

## Proposições de Issues

Segue proposição (gerada por IA) de novas issues a serem abertas no repositório
com base nos short-reports de 27-02-26:

A seguir estão **possíveis issues** (sugestões) para abrir no repositório
**`grei-ufc/general-opentes`**, de forma a acompanhar o que ficou em aberto nos
mini relatórios da pasta `short-reports/26-02-27` (ref `033fe5d...`).

---

### Épico (opcional) para centralizar

1. **[EPIC] Acompanhamento short-reports 26-02-27 (integrações, ferramentas e
   migrações)**
   - **Descrição:** issue guarda-chuva com links para as issues abaixo;
     checklist de entregas; status semanal.

---

### TSCC — Laiza Rocha (OMNeT++/COSIMA/MOSAik)

1. **Corrigir Dockerfile / inicialização do container OMNeT++ (COSIMA +
   MOSAIK)**
   - **Aceite:** build sem erros; container sobe; logs limpos; documentação
     mínima do motivo do problema e solução.
2. **Validar comunicação TCP MOSAIK ↔ OMNeT++ (após container estável)**
   - **Aceite:** teste de conectividade e troca de mensagens (ex.: handshake +
     envio/recebimento) reproduzível via script.
3. **Documentar setup do OMNeT++ container (dependências, build, execução)**
   - **Aceite:** README curto com comandos `docker build/run`, variáveis e
     troubleshooting.

---

### TSCC — Rafael Moura (rede entre containers + aplicação)

1. **Implementar troca de mensagens entre dois containers (nível aplicação)**
   - **Aceite:** exemplo mínimo cliente/servidor (TCP/UDP/HTTP—o que o projeto
     usar) com logs e instruções para reproduzir.
2. **Padronizar configuração de rede/hosts/ports nos containers (docker
   compose)**
   - **Aceite:** `docker compose up` sobe tudo; serviços se resolvem por nome;
     portas documentadas.
3. **Guia de troubleshooting: permissões no Docker daemon
   (/var/run/docker.sock)**
   - **Aceite:** doc com causas comuns, correções recomendadas e impacto de
     segurança.

---

### TSDQ — Luiz Alberto (OpenDSS + Streamlit/Pandas)

1. **Adicionar monitores de potência no pipeline OpenDSS (além de
   tensão/corrente)**
   - **Aceite:** dados de potência exportados; colunas/unidades definidas;
     exemplo de simulação incluído.
2. **Corrigir/normalizar exportação de CSV do OpenDSS para formato padrão de
   entrada**
   - **Aceite:** export gera **um** conjunto de CSVs (ou um CSV) no formato
     esperado; compatível com o fluxo de co-simulação.
3. **Ajustar ferramenta Streamlit para ler o novo formato (correntes +
   potências)**

- **Aceite:** app carrega sem gambiarras; valida schema; plots/tabelas corretos.

1. **Evoluir “Comparador Universal” (auditoria) com validações e relatórios**

- **Aceite:** compara datasets com tolerâncias, aponta divergências e exporta
  relatório (CSV/JSON/HTML).

---

### TSRE — Paulo Victor (OpenDER / IEEE 1547)

1. **Executar exemplos do OpenDER e registrar resultados (passo a passo)**

- **Aceite:** ambiente criado; exemplos rodam; outputs salvos; notas do que
  funciona/não funciona.

1. **Mapear requisitos IEEE 1547-2018 relevantes para os casos do projeto**

- **Aceite:** lista curta (itens aplicáveis) + como seriam
  parametrizados/testados no OpenDER.

---

### TTESO — Douglas Barros (PADE Python 3.12 + logs)

1. **Investigar e corrigir resíduos/bytes hex no `events.csv` do Sniffer**

- **Aceite:** `events.csv` sem lixo; encoding definido; testes cobrindo
  mensagens com caracteres especiais/binary payload.

1. **Adicionar testes automatizados para logging (show-logs/export-logs)**

- **Aceite:** testes que validam geração, filtros e export; pipeline CI (se
  existir) passando.

1. **Documentar migração do PADE para Python 3.12.11 e mudanças incompatíveis**

- **Aceite:** notas de migração + checklist para outros devs; dependências
  removidas e substituições.

1. **Testar PADE em cenário mais realista (multiagentes + carga)**

- **Aceite:** script/benchmark simples; métricas (tempo, tamanho de logs,
  estabilidade); resultados registrados.
