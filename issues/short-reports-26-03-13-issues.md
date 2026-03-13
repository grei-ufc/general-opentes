---
name: "🧩 Issues sugeridas (a partir do relatório geral)"
about:
  "Lista de issues que podem ser abertas no repositório, derivadas do relatório
  consolidado de 2026-03-13."
title: "[OPENTES] Sugestão de Issues — 2026-03-13"
labels: planejamento, triagem, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-03-13**

## 🎯 Objetivo

Registrar uma lista de **issues sugeridas** para abertura no repositório
`grei-ufc/general-opentes`, com base no relatório consolidado do dia, visando:

- rastreabilidade do que falta para concluir entregas,
- reduzir bloqueios,
- deixar próximos passos explícitos e acionáveis.

> Observação: algumas tarefas acontecem em repositórios específicos (ex.:
> `tscc-com-opentes`, `tsdq-dataview-opentes`, `tsre-der-opentes`, `pade`).
> Mesmo assim, estas issues podem viver no repositório geral para **gestão** (e
> conter links para issues/PRs nos repositórios de execução).

---

## 1) TSCC — Laiza & Rafael

### Issue 1 — Documentar (Docstrings) e padronizar documentação do pipeline MOSAIK↔OMNeT (ZMQ/Docker)

**Descrição**

- O mini relatório marca “Código documentado (Docstrings)” como pendente.
- Criar uma issue para:
  - identificar módulos principais a documentar;
  - incluir exemplos mínimos de execução (comandos docker-compose);
  - documentar portas e variáveis de ambiente relevantes (ex.: porta ZMQ
    **5555**);
  - descrever formato e significado do `results.csv`.

**Critérios de aceite**

- Checklist de docstrings concluído e revisado.
- Passo-a-passo de execução reproduzível incluído (no repo de trabalho e/ou
  linkado aqui).

**Responsáveis sugeridos**

- Laiza Edwigens Rocha Silva, Rafael Moura Sousa

**Prazo sugerido**

- **até 2026-03-20** (o relatório só informa “03/2026” sem dia)

---

### Issue 2 — Validar resultados preliminares da co-simulação com orientador e registrar decisão

**Descrição**

- Há item pendente: “Resultados preliminares validados com o Orientador”.
- Abrir issue para registrar:
  - data da reunião/validação;
  - quais critérios foram usados (ex.: coerência do `data_out`, consistência da
    criação dinâmica de nós);
  - próximos ajustes exigidos pelo orientador (se houver).

**Critérios de aceite**

- Registro da validação (resumo e decisão “aprovado / ajustes necessários”).
- Se houver ajustes, desdobrar em sub-issues.

**Prazo sugerido**

- **até 2026-03-20** (ou o primeiro dia útil após a reunião)

---

### Issue 3 — Definir e registrar “Planejamento para conclusão” do TSCC (Passo 1 / Passo 2)

**Descrição**

- O relatório contém o bloco de planejamento vazio.
- Criar issue para transformar o planejamento em passos concretos (ex.:
  documentação, validação, limpeza de repositório, scripts de execução).

**Critérios de aceite**

- Plano com 3–7 passos claros e verificáveis (cada passo com “done definition”).
- Se possível, link para milestones/PRs.

**Prazo sugerido**

- **até 2026-03-17** (rápida, para guiar a reta final)

---

## 2) TSDQ — Luiz Alberto

### Issue 4 — Implementar/viabilizar análise de potências na simulação de referência (pré-requisito para interface)

**Descrição**

- Bloqueio explícito: a simulação de referência não possui análise de potências
  para ser consumida pela interface.
- Issue para:
  - identificar onde a potência deve ser calculada (OpenDSS / pós-processamento
    / export);
  - definir formato de dados esperado pela ferramenta (colunas, unidades,
    timestamps);
  - mapear a origem do dado e como será validado.

**Critérios de aceite**

- Dados de potência disponíveis (cálculo e export funcionando).
- Interface consegue consumir/exibir o dado (mesmo que em modo inicial).

**Dependências**

- Simulação de referência / modelo que deve fornecer potências.

**Prazo sugerido**

- **até 2026-03-20** (mesmo prazo indicado no mini relatório)

---

### Issue 5 — Auditoria: confirmar correção do “problema visual” (perda de dados) com caso reproduzível

**Descrição**

- Foi concluído que “perda de dados” era apenas visual.
- Abrir issue para consolidar:
  - um caso mínimo reproduzível (entrada/saída esperada);
  - prints/descrição do bug anterior;
  - validação de que não há perda real no pipeline
    (arquivos/export/transformações).

**Critérios de aceite**

- Caso reproduzível documentado.
- Evidência clara de correção e ausência de regressão.

**Prazo sugerido**

- **até 2026-03-18**

---

### Issue 6 — Estudo OpenDER (TSDQ↔TSRE): identificar pontos de divergência no código e registrar achados

**Descrição**

- Luiz foi orientado a estudar OpenDER e procurar divergências no código-fonte.
- Issue para registrar:
  - quais exemplos do OpenDER foram analisados;
  - quais divergências/ajustes foram encontrados;
  - recomendações para integração/uso no contexto OPENTES.

**Critérios de aceite**

- Documento curto (bullet points) com achados e recomendações.
- Links para arquivos/trechos relevantes (ou issues nos repositórios de
  execução).

**Prazo sugerido**

- **até 2026-03-20**

---

## 3) TSRE — Paulo Victor

### Issue 7 — Completar estudo dos exemplos OpenDER e registrar “guia de execução” para o time

**Descrição**

- Próximo passo do Paulo: rodar e estudar demais exemplos OpenDER.
- Criar issue para:
  - listar exemplos pendentes e status (rodou/não rodou);
  - registrar instruções de execução e dependências;
  - documentar resultados esperados.

**Critérios de aceite**

- Lista de exemplos concluída.
- Guia rápido de execução (pré-requisitos e comandos) validado.

**Prazo sugerido**

- **até 2026-03-20**

---

### Issue 8 — Validação cruzada: sistema 13 barras (OpenDSS + mosaik) com e sem FV para divergências

**Descrição**

- Próximo passo: análise do sistema 13 barras com/sem geração FV.
- Issue para:
  - definir quais métricas comparar (tensões, correntes, potências, perdas,
    etc.);
  - definir tolerâncias e como registrar divergências;
  - gerar relatório final com conclusões.

**Critérios de aceite**

- Execução dos dois cenários (com FV / sem FV).
- Relatório comparativo com divergências e hipóteses/correções.

**Prazo sugerido**

- **até 2026-03-20**

---

## 4) TTESO / PADE — Douglas Barros

### Issue 9 — Desbloqueio IEC-61850: obter/validar dependência `mygrid` e executar `agent_example_iec_61850_1.py`

**Descrição**

- Bloqueio explícito: validação IEC-61850 depende de `mygrid`.
- Criar issue para:
  - identificar quem fornece `mygrid` e onde será disponibilizado;
  - registrar instruções de instalação/versão compatível;
  - rodar o exemplo IEC-61850 e registrar evidências.

**Critérios de aceite**

- `mygrid` disponível e instalável.
- Exemplo IEC-61850 executa com sucesso e evidências anexadas (logs, outputs).

**Prazo sugerido**

- **a definir** (depende da entrega do `mygrid`); sugerir acompanhamento diário
  após 2026-03-13.

---

### Issue 10 — Fechar pendências finais da release PADE v2.2.6 (issues + checklist de release)

**Descrição**

- Douglas cita: fechar 2 issues pendentes, empacotar release v2.2.6, aprovar PR
  na branch `/pade2026`.
- Issue no repositório geral para acompanhar a “reta final”:
  - links das 2 issues no repositório do PADE;
  - checklist do que falta para release (tag, changelog, testes mínimos, build);
  - status da aprovação/merge do PR.

**Critérios de aceite**

- 2 issues fechadas (linkadas).
- Release v2.2.6 publicada (ou PR mergeado conforme processo do projeto).

**Prazo sugerido**

- **2026-03-13** (prazo original), mas provavelmente **replanejar** conforme
  disponibilidade do `mygrid`.

---

## ✅ Resumo rápido (tópicos)

- TSCC (Laiza/Rafael): documentação (docstrings), validação com orientador e
  planejamento final com passos objetivos.
- TSDQ (Luiz): destravar análise de potências; documentar correção do “bug
  visual”; estudo OpenDER com achados.
- TSRE (Paulo): finalizar estudo OpenDER e validação cruzada do sistema 13
  barras com/sem FV.
- PADE (Douglas): destravar `mygrid` e validar IEC-61850; fechar pendências e
  checklist de release v2.2.6.
