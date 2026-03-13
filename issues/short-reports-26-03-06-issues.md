Segue a **lista sugerida de issues** (títulos + descrição curta + prazo), pronta
para eu criar assim que você confirmar o repo:

1. **[TSCC] Estabilizar co-simulação conteinerizada (Mosaik ↔ COSIMA ↔
   OMNeT++)**

- **Responsáveis:** Laiza Edwigens Rocha Silva, Rafael Moura Sousa
- **Descrição:** Investigar falha no `CommunicationSimulator`/COSIMA (log com
  “Killed”) e garantir execução estável do fluxo Mosaik→COSIMA→OMNeT++.
- **Critérios de aceite:** execução do exemplo fim-a-fim sem encerramento do
  processo; documentação do procedimento para rodar.
- **Prazo alvo:** **2026-03-13**
- **Labels sugeridos:** `pesquisa`, `software`, `docker`, `cosimulation`, `tscc`

1. **[TSCC] Padronizar orquestração Docker (docker-compose na raiz) e
   documentação de execução**

- **Responsáveis:** Laiza, Rafael
- **Descrição:** Consolidar `docker-compose.yml` na raiz e documentar
  comandos/variáveis/portas, evitando conflitos entre serviços.
- **Critérios de aceite:** README/guia de execução atualizado; compose
  reproduzível em máquina limpa.
- **Prazo alvo:** **2026-03-13**
- **Labels:** `docker`, `documentacao`, `tscc`

1. **[TSDQ] Diagnosticar perda de dados em CSV (Excel vs geração/extração)**

- **Responsável:** Luiz Alberto
- **Descrição:** Verificar se perdas no Excel são de importação/visualização
  (encoding, separador, limite de linhas, etc.) ou do pipeline de geração do CSV
  na co-simulação.
- **Critérios de aceite:** relatório curto com causa raiz + evidências
  (comparação Excel vs pandas) + recomendação.
- **Prazo alvo:** **2026-03-13**
- **Labels:** `python`, `dados`, `tsdq`, `debug`

1. **[TSDQ] Adaptar interface para nova leitura/ingestão de dados (incl.
   monitoramento de corrente)**

- **Responsável:** Luiz Alberto
- **Descrição:** Ajustar parsing/estrutura de entrada da interface e adicionar
  monitoramentos de corrente (escopo inicial).
- **Critérios de aceite:** funcionalidade implementada + exemplo de
  entrada/saída + testes básicos.
- **Prazo alvo:** **2026-03-13** (ou “a definir” se preferir separar do
  diagnóstico)
- **Labels:** `python`, `opendss`, `feature`, `tsdq`

1. **[TSRE] Resolver execução de notebooks (.ipynb) no VSCode para exemplos do
   OpenDER**

- **Responsável:** Paulo Victor
- **Descrição:** Ajustar ambiente (kernel/venv/dependências) para rodar exemplos
  do OpenDER em notebook no VSCode.
- **Critérios de aceite:** pelo menos 1 notebook do OpenDER executando do início
  ao fim com instruções reproduzíveis.
- **Prazo alvo:** **2026-03-13**
- **Labels:** `python`, `opender`, `tsre`, `dev-env`

1. **[TSRE] Desbloquear fluxo de versionamento (git push) no repositório TSRE**

- **Responsável:** Paulo Victor
- **Descrição:** Diagnosticar e corrigir falha de
  autenticação/permissão/chaves/remote para permitir push no GitHub.
- **Critérios de aceite:** push realizado e documentado (passos e
  pré-requisitos).
- **Prazo alvo:** **2026-03-13**
- **Labels:** `git`, `infra`, `tsre`

1. **[TSRE] Evoluir dashboard Streamlit para comparação de simuladores FV
   (OpenDSS vs simulador próprio)**

- **Responsável:** Paulo Victor
- **Descrição:** Expandir visualização interativa e padronizar métricas/gráficos
  para comparação de resultados de simulação.
- **Critérios de aceite:** dashboard com filtros básicos + plots principais +
  dataset de exemplo.
- **Prazo alvo:** **2026-03-13**
- **Labels:** `streamlit`, `python`, `visualizacao`, `tsre`

1. **[PADE] Adaptar exemplos `tests/v1` para Python 3.12.11 (pade2026)**

- **Responsável:** Douglas Barros
- **Descrição:** Migrar e validar exemplos legados em `tests/v1` (ex.:
  `test_agent.py`, `script_2.py`, etc.) mantendo compatibilidade com 3.12.11.
- **Critérios de aceite:** exemplos executando com logs gerados + notas no
  changelog.
- **Prazo alvo:** **2026-03-12**
- **Labels:** `python`, `pade`, `refactor`, `tteso`

1. **[PADE] Investigar/corrigir resíduos hexadecimais no sniffer (`events.csv`)
   e validar encoding**

- **Responsável:** Douglas Barros
- **Descrição:** Determinar origem dos resíduos e garantir CSVs consistentes
  (encoding e caracteres especiais).
- **Critérios de aceite:** reprodução do problema + correção/mitigação + testes
  com caracteres especiais.
- **Prazo alvo:** **2026-03-12** (ou a definir, se for pós-RC)
- **Labels:** `bug`, `logging`, `csv`, `pade`

1. **[PADE] Preparar Release Candidate do PADE para Python 3.12.11**

- **Responsável:** Douglas Barros
- **Descrição:** Consolidar mudanças, revisar documentação/CHANGELOG e preparar
  RC (tag/nota de release conforme padrão do repo).
- **Critérios de aceite:** checklist de release concluído + instruções de
  instalação/teste.
- **Prazo alvo:** **2026-03-12**
- **Labels:** `release`, `python`, `pade`

Diga apenas: **“Crie as issues em owner/repo”** (ex.:
`grei-ufc/general-opentes`) e, se quiser, confirme também:

- se devo usar **milestone** “Entrega 2026-03-13” (e outra “Entrega 2026-03-12”
  para PADE), e
- se os responsáveis devem ser **assignees** (preciso que eles existam no GitHub
  e tenham permissão no repo).
