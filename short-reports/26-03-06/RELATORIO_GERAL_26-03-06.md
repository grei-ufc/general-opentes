# Relatório Geral — Consolidação de Mini Relatórios (curtos) — 26/03/06

Data de referência dos mini relatórios: **06/03/2026**  
Foco: **tarefas em andamento**, **dificuldades/bloqueios**, **ações para
conclusão** e **prazos**.

---

## 1) Laiza Edwigens Rocha Silva & Rafael Moura Sousa — TSCC

**Tema:** Aplicação de simulação e **co-simulação em ambientes conteinerizados**
(Mosaik + COSIMA + OMNeT++/INET)

### O que está sendo feito (tarefas)

- Adoção da abordagem de co-simulação proposta por Rafael Moura:
  - Uso do **container do projeto COSIMA** integrado ao fluxo da aplicação.
- Ajustes de orquestração:
  - **Reorganização do `docker-compose.yml` para a raiz** do projeto para
    facilitar a subida e o gerenciamento dos serviços.
- Testes de comunicação entre containers:
  - Verificação do fluxo **Mosaik → COSIMA → OMNeT++**.

### Dificuldades / Bloqueios

- Problema na execução da co-simulação envolvendo o **CommunicationSimulator**:
  - Log indica falha/instabilidade na conexão com OMNeT++ (inicialmente
    “failed”, depois “successful”), seguida por um **“Killed”** durante a
    simulação.
  - Sinal de que algo no processo do COSIMA/CommunicationSimulator pode estar
    sendo encerrado (ex.: crash, OOM killer, conflito de porta/serviço, ou erro
    interno do simulador).

### Ações para concluir

- **Finalizar o exemplo garantindo comunicação estável** entre os containers
  (Mosaik↔COSIMA↔OMNeT++).
- Após estabilização do exemplo:
  - Reaproveitar a base e **aplicar em diferentes cenários de simulação**.

### Prazo ligado à entrega

- **13/03/2026** (data pretendida de entrega informada no mini relatório).

---

## 2) Luiz Alberto Silva Sales Marinho — TSDQ

**Tema:** Ferramenta de análise em **Python** + implementação/integração de
**interface** (dados de co-simulação)

### O que está sendo feito (tarefas)

- Entendimento do pipeline de dados da interface:
  - **Compreender dados de entrada** (como são gerados e como localizar esses
    elementos no código).
- Evolução funcional planejada:
  - **Incluir monitoramentos de corrente** e posteriormente outras análises.
- Ferramentas e ecossistema usados:
  - Python, OpenDSS, Excel, PowerBI.

### Dificuldades / Bloqueios

- Perda de dados ao analisar arquivos **.CSV no Excel** provenientes da
  co-simulação:
  - O problema ainda não está confirmado se é **real (na geração)** ou **apenas
    visualização/importação** no Excel.

### Ações para concluir

- Verificar se a perda é apenas de visualização:
  - Validar o CSV com outros leitores (ex.: pandas/Python, LibreOffice,
    importação com parâmetros corretos, checar separador/encoding/linhas
    truncadas).
- **Adaptar a interface** para uma “nova leitura” (provavelmente ajustes de
  parsing/importação/estrutura dos dados).

### Prazo ligado à entrega

- **13/03/2026** (data pretendida de entrega informada no mini relatório).

---

## 3) Paulo Victor Pereira Lima — TSRE

**Tema:** Estudo/integração do **OpenDER (EPRI)** + melhoria de visualização de
dados com **Streamlit** para comparação de simuladores FV

### O que está sendo feito (tarefas)

- Continuidade do estudo do **OpenDER**:
  - Leitura do material técnico (diagramas/equações) e início da análise dos
    exemplos do repositório.
- Desenvolvimento de ferramenta de visualização:
  - Script com **Streamlit** para apresentar dados de simulação de forma mais
    flexível e interativa.
- Objetivo de análise:
  - Melhorar a comparação entre **simulador FV desenvolvido** e **simulador FV
    do OpenDSS**.

### Dificuldades / Bloqueios

- Problemas para rodar exemplos **Python em notebooks (.ipynb)** no VSCode.
- Problemas para realizar **git push** para o repositório no GitHub (bloqueio
  operacional de versionamento/entrega).

### Ações para concluir

- Rodar e estudar os exemplos do OpenDER (resolver execução de notebooks).
- Analisar e corrigir inconsistências nos dados:
  - Especialmente no **sistema 13 barras** usando OpenDSS, visando melhorar a
    confiabilidade da comparação.

### Prazo ligado à entrega

- **13/03/2026** (data pretendida de entrega informada no mini relatório).

---

## 4) Douglas Barros — TTESO

**Tema:** Atualização do framework **PADE** de Python 3.8 para **Python
3.12.11**, com validação/adaptação de exemplos legados

### O que está sendo feito (tarefas)

- Atualização e estabilização do core do PADE:
  - Correções em componentes centrais (AMS, métodos de mensagem, logs,
    propagação de tabela de agentes).
- Adaptação de exemplos legados (concluídos nesta etapa):
  - 6 exemplos com protocolos FIPA e comportamentos variados (HelloWorld,
    TimedBehaviour, Request, ContractNet, Subscribe, Subscribe+Threads).
- Estruturação e documentação:
  - Criação de CHANGELOG por exemplo, organização por pastas, e logging CSV para
    observabilidade.

### Dificuldades / Bloqueios

- Bugs no core que impactavam múltiplos exemplos (já tratados):
  - Notificação/tabela de agentes no AMS não propagava corretamente.
  - Uso de `copy()` inexistente em ACLMessage causando crash.
- Pendência técnica ainda em aberto:
  - Sniffer não populando `messages.csv` (registrado como “comportamento
    esperado”, mas fica como ponto de atenção dependendo do objetivo do
    logging).
- Itens futuros/desafios:
  - Resíduos hexadecimais em `events.csv` e tratamento de caracteres especiais
    em logs.

### Ações para concluir

- Próximas etapas planejadas:
  1. Adaptar exemplos em `tests/v1` (ex.: `test_agent.py`, `script_2.py`, etc.).
  2. Adaptar exemplos com integrações (Mosaik, IEC 61850, Power Systems).
  3. Investigar/corrigir resíduos hexadecimais no sniffer (`events.csv`).
  4. Validar encoding/caracteres especiais no logging CSV.
  5. Finalizar documentação de issue de validação do sistema de logging.
  6. Preparar **release candidate** para Python 3.12.11.

### Prazo ligado à entrega

- **12/03/2026** (data pretendida de entrega informada no mini relatório).

---

# Resumo Executivo (por pessoa / entrega)

- **Laiza & Rafael (TSCC):** estabilizar co-simulação conteinerizada
  (Mosaik↔COSIMA↔OMNeT++), com erro crítico no CommunicationSimulator (processo
  “Killed”). **Prazo: 13/03/2026**.
- **Luiz Alberto (TSDQ):** entender e ajustar ingestão de dados da interface e
  incluir monitoramentos; bloqueio de perdas no CSV via Excel. **Prazo:
  13/03/2026**.
- **Paulo Victor (TSRE):** estudar OpenDER e melhorar visualização com Streamlit
  para comparar simuladores; bloqueios com notebooks no VSCode e git push.
  **Prazo: 13/03/2026**.
- **Douglas Barros (TTESO):** atualizar PADE para Python 3.12.11, core corrigido
  e 6 exemplos adaptados; próximos passos: tests/v1, integrações e qualidade do
  logging. **Prazo: 12/03/2026**.
