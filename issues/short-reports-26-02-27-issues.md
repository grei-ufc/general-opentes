# Propostas de Issues — short-reports/26-02-27 (ref 033fe5d250073f12482c44796c8818fdf4cbee4a)

Este documento lista **propostas de issues** para abrir no repositório
`grei-ufc/general-opentes`, com o objetivo de acompanhar as atividades pendentes
descritas nos mini relatórios da pasta `short-reports/26-02-27`.

> Fonte: mini relatórios em `short-reports/26-02-27` (ref:
> `033fe5d250073f12482c44796c8818fdf4cbee4a`).

---

## Labels sugeridas (padronização)

Caso ainda não existam, sugere-se criar/reutilizar:

- Tipos: `type:epic`, `type:task`, `type:bug`, `type:doc`, `type:test`
- Áreas:
  - Infra: `area:docker`, `area:networking`
  - Co-simulação: `area:cosima`, `area:omnetpp`, `area:mosaik`
  - OpenDSS/visualização: `area:opendss`, `area:streamlit`,
    `area:data-pipeline`, `area:audit`
  - Pesquisa: `area:opender`, `area:standards`
  - PADE/logging: `area:pade`, `area:logging`
- Prioridade: `priority:high`, `priority:medium`, `priority:low`
- Status (opcional): `status:blocked`

---

## Milestones / sprints (sugestão)

- `Sprint 2026-03-06` (para itens com prazo citado em 06/03/2026 nos relatos)
- `Backlog (sem data)` (pesquisa, documentação e melhorias não críticas)

---

# Lista de issues propostas (copiar/colar)

## 1) [EPIC] Acompanhamento short-reports 26-02-27 (infra, ferramentas e migrações)

**Labels:** `type:epic`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

- Centralizar o acompanhamento das atividades registradas em
  `short-reports/26-02-27` (ref `033fe5d...`).
- Checklist:
  - [ ] Container OMNeT++ sobe e integra com MOSAIK/COSIMA
  - [ ] Comunicação entre containers validada em nível de aplicação
  - [ ] Pipeline OpenDSS exporta correntes e potências em formato padrão
  - [ ] Streamlit lê/visualiza novo formato e auditoria evoluída
  - [ ] OpenDER exemplos executados + mapeamento IEEE 1547-2018
  - [ ] PADE em Python 3.12 com logs CSV sem resíduos + testes

---

## OMNeT++ / COSIMA / MOSAIK (TSCC — Laiza Rocha)

### 2) Fix: container OMNeT++ não inicializa (revisar Dockerfile com base no COSIMA)

**Labels:** `type:bug`, `area:docker`, `area:omnetpp`, `area:cosima`,
`priority:high`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

#### Contexto

O container OMNeT++ não está inicializando corretamente no ambiente integrado
(MOSAIK + OMNeT++ + COSIMA).

#### Tarefas

- [ ] Revisar/reconstruir Dockerfile do OMNeT++ (baseado no Dockerfile do
      COSIMA)
- [ ] Garantir build reprodutível (comandos documentados)
- [ ] Validar `docker run`/`docker compose up` com logs limpos e serviço
      operacional

#### Critérios de aceite

- Container OMNeT++ sobe sem falhas.
- Passos de build/run documentados.
- Evidência: logs/prints/comandos para reproduzir.

---

### 3) Task: validar comunicação TCP MOSAIK ↔ OMNeT++ após estabilização do container

**Labels:** `type:task`, `area:networking`, `area:mosaik`, `area:omnetpp`,
`priority:high`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

#### Dependência

- Depende da issue: **“Fix: container OMNeT++ não inicializa (revisar Dockerfile
  com base no COSIMA)”**.

#### Tarefas

- [ ] Definir porta(s)/endpoints necessários
- [ ] Implementar teste mínimo (handshake + troca de mensagens)
- [ ] Documentar como rodar o teste localmente

#### Critérios de aceite

- Teste reproduzível demonstrando comunicação MOSAIK ↔ OMNeT++.

---

### 4) Docs: guia de setup/troubleshooting do container OMNeT++ (COSIMA + MOSAIK)

**Labels:** `type:doc`, `area:docker`, `area:omnetpp`, `area:cosima`,
`priority:medium`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Documentar dependências e comandos (build/run)
- [ ] Descrever variáveis/portas/rede
- [ ] Adicionar troubleshooting de erros comuns

#### Critérios de aceite

- README/MD curto que permita reproduzir o setup.

---

## Comunicação entre containers (TSCC — Rafael Moura)

### 5) Task: implementar troca de mensagens entre 2 containers (nível aplicação)

**Labels:** `type:task`, `area:docker`, `area:networking`, `priority:high`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

#### Contexto

A rede entre containers já foi validada (DNS/hostname e conectividade). Falta
validar a camada de aplicação (envio/recebimento de mensagens).

#### Tarefas

- [ ] Implementar exemplo mínimo (cliente/servidor) no padrão do repo
- [ ] Logging suficiente para depuração
- [ ] Instruções de execução via `docker compose`

#### Critérios de aceite

- Demonstração reproduzível de envio/recebimento de mensagens entre containers.

---

### 6) Chore: padronizar docker-compose (services/ports/network/hostnames) para ambiente de teste

**Labels:** `type:task`, `area:docker`, `area:networking`, `priority:medium`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Garantir nomes de serviços consistentes
- [ ] Documentar portas e endpoints
- [ ] Evitar configurações específicas de host (host-specific)

#### Critérios de aceite

- `docker compose up` sobe o ambiente e os serviços se resolvem por nome.

---

### 7) Docs: troubleshooting de permissões Docker daemon (/var/run/docker.sock)

**Labels:** `type:doc`, `area:docker`, `priority:low`  
**Milestone:** `Backlog (sem data)`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Explicar erro típico de permissão no Docker daemon
- [ ] Recomendações (grupo docker, sudo, implicações de segurança)
- [ ] Alternativas quando aplicável

#### Critérios de aceite

- Documento curto e objetivo com passos de correção e referências internas do
  projeto.

---

## OpenDSS + Streamlit/Pandas (TSDQ — Luiz Alberto)

### 8) Task: adicionar monitores de potência no pipeline OpenDSS (além de tensão/corrente)

**Labels:** `type:task`, `area:opendss`, `area:data-pipeline`, `priority:high`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Implementar/exportar medições de potência (P/Q) via monitores
- [ ] Definir schema/colunas/unidades
- [ ] Adicionar exemplo mínimo de simulação + saída

#### Critérios de aceite

- Dados de potência exportados e validados (ex.: colunas e unidades definidas).

---

### 9) Fix: exportação OpenDSS gerando múltiplos CSVs em formato incompatível — normalizar para formato padrão

**Labels:** `type:bug`, `area:opendss`, `area:data-pipeline`, `priority:high`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

#### Problema

A extração atual (ex.: via Colab) gera múltiplos CSVs e o formato não
corresponde ao esperado de entrada no fluxo (ex.: co-simulação).

#### Tarefas

- [ ] Definir “formato padrão” de entrada (schema)
- [ ] Implementar export que produza arquivos no schema esperado
- [ ] Validar com um dataset real

#### Critérios de aceite

- Pipeline gera dados no formato padrão, prontos para consumo no restante do
  fluxo.

---

### 10) Task: adaptar Streamlit para consumir novo formato (corrente + potência) com validação de schema

**Labels:** `type:task`, `area:streamlit`, `area:opendss`, `priority:medium`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Leitura robusta do formato padrão (incluindo validação de colunas
      obrigatórias)
- [ ] Atualizar visualizações/plots para corrente e potência
- [ ] Documentar como rodar a aplicação e qual dataset de exemplo usar

#### Critérios de aceite

- App abre e exibe os dados corretamente sem ajustes manuais.

---

### 11) Enhancement: evoluir “Comparador Universal” com tolerâncias e relatório de divergências

**Labels:** `type:task`, `area:audit`, `area:data-pipeline`, `priority:medium`  
**Milestone:** `Backlog (sem data)`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Comparação com tolerâncias configuráveis
- [ ] Agrupamentos por métrica/tempo/barras
- [ ] Exportar relatório de divergências (CSV/JSON/HTML)

#### Critérios de aceite

- Relatório gerado automaticamente apontando divergências de forma
  interpretável.

---

## OpenDER / IEEE (TSRE — Paulo Victor)

### 12) Task: executar exemplos do OpenDER (EPRI) e registrar passo a passo + resultados

**Labels:** `type:task`, `area:opender`, `priority:medium`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Preparar ambiente (dependências/versões)
- [ ] Rodar exemplos principais
- [ ] Registrar outputs e problemas encontrados
- [ ] Indicar caminhos para reproduzir (comandos)

#### Critérios de aceite

- Documento “como rodar” + evidências de execução (logs/outputs).

---

### 13) Research: mapear requisitos IEEE 1547-2018 relevantes e como testar/parametrizar no OpenDER

**Labels:** `type:task`, `area:standards`, `area:opender`, `priority:low`  
**Milestone:** `Backlog (sem data)`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Listar requisitos relevantes ao contexto do projeto
- [ ] Explicar como se traduzem em parâmetros/testes no OpenDER
- [ ] Registrar limitações/hipóteses

#### Critérios de aceite

- Mapeamento objetivo e reutilizável em atividades futuras.

---

## PADE (Python 3.12) + Logging CSV (TTESO — Douglas Barros)

### 14) Fix: remover resíduos/bytes hexadecimais do events.csv gerado pelo Sniffer (PADE)

**Labels:** `type:bug`, `area:pade`, `area:logging`, `priority:high`  
**Milestone:** `Sprint 2026-03-06`

**Descrição (colar na issue):**

#### Problema

O `events.csv` contém “resíduos”/bytes hex que prejudicam leitura e auditoria.

#### Tarefas

- [ ] Identificar origem (encoding, serialização, payload binário etc.)
- [ ] Definir estratégia (sanitização, escaping, base64 para payload quando
      necessário, encoding UTF-8)
- [ ] Garantir compatibilidade com caracteres especiais

#### Critérios de aceite

- CSV consistente e legível; ferramentas comuns (pandas/excel) conseguem abrir
  sem quebra.

---

### 15) Tests: adicionar testes automatizados para show-logs/export-logs e geração do events.csv

**Labels:** `type:test`, `area:pade`, `area:logging`, `priority:medium`  
**Milestone:** `Backlog (sem data)`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Testes de comandos/CLI (`show-logs`, `export-logs`)
- [ ] Testes com mensagens contendo caracteres especiais
- [ ] Testes de export/import do CSV

#### Critérios de aceite

- Suite de testes cobrindo logging e evitando regressões.

---

### 16) Docs: documentar migração do PADE para Python 3.12.11 (mudanças e compatibilidade)

**Labels:** `type:doc`, `area:pade`, `priority:low`  
**Milestone:** `Backlog (sem data)`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Lista de mudanças (dependências removidas, APIs alteradas)
- [ ] Passos para setup local
- [ ] Notas de compatibilidade e troubleshooting

#### Critérios de aceite

- Documento curto que habilite outros devs a repetir a migração/instalação.

---

### 17) Task: validar PADE em cenário realista (multiagentes + carga) e registrar métricas

**Labels:** `type:task`, `area:pade`, `priority:medium`  
**Milestone:** `Backlog (sem data)`

**Descrição (colar na issue):**

#### Tarefas

- [ ] Criar cenário/benchmark simples (multiagentes)
- [ ] Capturar métricas (tempo, volume de logs, estabilidade)
- [ ] Registrar resultados e limitações

#### Critérios de aceite

- Cenário reproduzível + resultados documentados.

---

## Notas finais

- Recomenda-se linkar todas as issues à issue épico (via checklist/links).
- Onde houver dependência clara (ex.: comunicação MOSAIK↔OMNeT depende do
  container OMNeT subir), incluir referência explícita nas issues.
