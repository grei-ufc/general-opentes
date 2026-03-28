---
name: "🧩 Issues sugeridas (a partir do relatório geral)"
about:
  "Lista de issues que podem ser abertas no repositório, derivadas do relatório
  consolidado de 2026-03-20."
title: "[OPENTES] Sugestão de Issues — 2026-03-20"
labels: planejamento, triagem, pesquisa, software
assignees: "[lucassm]"
---

## 📅 Data de referência

- **2026-03-20**

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

### Issue 1 — Validar resultados preliminares da co-simulação com o orientador e registrar decisão

**Descrição**

- Item pendente no checklist: "Resultados preliminares validados com o
  Orientador".
- Abrir issue para registrar:
  - data da reunião/validação;
  - quais critérios foram avaliados (latência medida, escalabilidade, fluxo de
    dados nos gráficos `simulacao-plot.png` e `plot-teste-escalabilidade.png`);
  - quais ajustes foram solicitados pelo orientador (se houver).

**Critérios de aceite**

- Registro da validação com resumo e decisão ("aprovado / ajustes necessários").
- Se houver ajustes, desdobrar em sub-issues com responsável e prazo.

**Responsáveis sugeridos**

- Laiza Edwigens Rocha Silva, Rafael Moura Sousa

**Prazo sugerido**

- **primeiro encontro disponível após 2026-03-20**

---

### Issue 2 — Documentar e publicar análise de escalabilidade da co-simulação MOSAIK↔OMNeT++

**Descrição**

- O teste de escalabilidade foi realizado com sucesso, mas os resultados
  precisam ser documentados formalmente para uso do time.
- Issue para:
  - descrever a metodologia do teste (número de nós, carga, métricas coletadas);
  - publicar o gráfico `plot-teste-escalabilidade.png` com contexto e
    interpretação;
  - identificar os gargalos observados e registrar recomendações para cenários
    mais complexos.

**Critérios de aceite**

- Seção de documentação ou README atualizado com resultados do teste de
  escalabilidade.
- Gráfico com legenda e análise textual disponível no repositório.

**Responsáveis sugeridos**

- Laiza Edwigens Rocha Silva, Rafael Moura Sousa

**Prazo sugerido**

- **até 2026-03-31**

---

### Issue 3 — Definir "Passo 2" do planejamento de conclusão do TSCC

**Descrição**

- O relatório deixou o "Passo 2" do planejamento em branco.
- Criar issue para completar o planejamento de entrega com ações concretas e
  verificáveis para a reta final da subequipe (ex.: limpeza de repositório,
  scripts de execução automatizada, guia de reprodutibilidade).

**Critérios de aceite**

- Planejamento completo com pelo menos 3 passos claros e verificáveis.
- Cada passo com definição de "done" e responsável.

**Responsáveis sugeridos**

- Laiza Edwigens Rocha Silva, Rafael Moura Sousa

**Prazo sugerido**

- **até 2026-03-27** (para guiar a próxima sprint)

---

## 2) TSDQ — Luiz Alberto

### Issue 4 — Corrigir plotagem de valores muito pequenos na interface de análise (exibição como linha reta)

**Descrição**

- Bloqueio reportado: valores muito pequenos são plotados como linha reta na
  interface gráfica.
- Issue para:
  - reproduzir o problema com um caso mínimo (entrada e saída esperada);
  - identificar a causa raiz (escala do eixo Y, threshold de exibição, formato
    numérico, etc.);
  - implementar e validar a correção na interface Streamlit/Python.

**Critérios de aceite**

- Valores muito pequenos plotados corretamente (não como linha reta).
- Caso mínimo reproduzível documentado junto com a correção.

**Responsáveis sugeridos**

- Luiz Alberto Silva Sales Marinho

**Prazo sugerido**

- **até 2026-03-27**

---

### Issue 5 — Implementar ilustração do sistema de distribuição na interface de análise

**Descrição**

- Próxima atividade declarada: adicionar diagrama/ilustração do sistema de
  distribuição para cada rede analisada.
- Issue para:
  - compreender como os códigos de co-simulação do OpenDSS representam/exportam
    o diagrama do sistema;
  - definir formato de exibição na interface (imagem estática, diagrama
    interativo, etc.);
  - implementar e validar a exibição do diagrama integrada à interface.

**Critérios de aceite**

- Interface exibe o diagrama do sistema correspondente ao dataset carregado.
- Diagrama visualmente consistente com o sistema analisado (ex.: IEEE-13 barras).

**Dependências**

- Compreensão dos códigos de co-simulação do OpenDSS (Passo 1 do planejamento).

**Responsáveis sugeridos**

- Luiz Alberto Silva Sales Marinho

**Prazo sugerido**

- **até 03/04/2026**

---

### Issue 6 — Garantir suporte ao `mapeamento.json` dinâmico para nomenclaturas ONS/BDGD (ANEEL)

**Descrição**

- A migração para `mapeamento.json` foi implementada, mas precisa ser validada
  contra casos reais com nomenclaturas complexas dos padrões ONS e BDGD (ANEEL).
- Issue para:
  - criar casos de teste com nomenclaturas complexas (espaços, acentos,
    variações de formatação);
  - validar que o Regex cobre os padrões documentados;
  - atualizar a documentação instrutiva embutida no JSON se necessário.

**Critérios de aceite**

- Conjunto de casos de teste cobrindo padrões ONS e BDGD (ANEEL).
- Todos os casos passando sem ajuste manual.
- Documentação do JSON atualizada e clara para novos membros do time.

**Responsáveis sugeridos**

- Luiz Alberto Silva Sales Marinho

**Prazo sugerido**

- **até 2026-03-27**

---

## 3) TSRE — Paulo Victor

### Issue 7 — Integrar dados fotovoltaicos reais (BR-PVGen / LEA-UFC) nas simulações

**Descrição**

- Os dados do BR-PVGen (UFJF/Kaggle) foram identificados e o contato com o LEA
  (UFC) está em andamento.
- Issue para:
  - documentar o formato e estrutura dos dados do BR-PVGen;
  - definir pipeline de ingestão dos dados nas simulações (pré-processamento,
    conversão de unidades, frequência temporal);
  - executar simulação com dados reais e registrar resultados comparativos.

**Critérios de aceite**

- Pipeline de ingestão de dados reais funcionando e documentado.
- Pelo menos uma simulação executada com dados reais do BR-PVGen.
- Resultado comparativo com dados sintéticos registrado (se aplicável).

**Responsáveis sugeridos**

- Paulo Victor Pereira Lima

**Prazo sugerido**

- **até 2026-03-27**

---

### Issue 8 — Consolidar dados fotovoltaicos do LEA (UFC) e definir estratégia de uso nas simulações

**Descrição**

- Contato em andamento com membro do LEA (UFC) para obtenção de dados
  adicionais.
- Issue para rastrear:
  - status do contato com o LEA;
  - formato e disponibilidade dos dados fornecidos;
  - definição de como esses dados se complementam com o BR-PVGen;
  - decisão sobre qual base de dados priorizar para as simulações.

**Critérios de aceite**

- Status do contato com LEA registrado (obtido / não disponível / em andamento).
- Decisão documentada sobre a estratégia de uso dos dados.

**Responsáveis sugeridos**

- Paulo Victor Pereira Lima

**Prazo sugerido**

- **a definir** (dependente da resposta do LEA)

---

### Issue 9 — Executar análise do sistema 13 barras (OpenDSS + Mosaik) com e sem geração FV

**Descrição**

- Próximo passo indicado no relatório da semana anterior: analisar o sistema de
  13 barras com e sem FV para verificar divergências.
- Issue para:
  - definir métricas de comparação (tensões, correntes, potências, perdas);
  - executar os dois cenários (com FV / sem FV) usando os dados reais obtidos;
  - registrar divergências encontradas e hipóteses explicativas.

**Critérios de aceite**

- Execução dos dois cenários documentada.
- Relatório comparativo com divergências e conclusões preliminares.

**Dependências**

- Issue 7 (dados reais integrados às simulações).

**Responsáveis sugeridos**

- Paulo Victor Pereira Lima

**Prazo sugerido**

- **até 03/04/2026**

---

## 4) TTESO / PADE — Douglas Barros

### Issue 10 — Empacotar e publicar Release v2.2.6 do PADE (tag + PR na `/pade2026`)

**Descrição**

- Único próximo passo declarado: empacotar a release v2.2.6 e realizar o Pull
  Request na branch principal.
- Issue para acompanhar o checklist de release:
  - geração de tag `v2.2.6`;
  - atualização do `CHANGELOG` ou notas de release;
  - verificação do `setup.py` (dependências: pandas, matplotlib, numpy);
  - criação e aprovação do PR na branch `/pade2026`;
  - publicação da release no GitHub.

**Critérios de aceite**

- Tag `v2.2.6` publicada no repositório `grei-ufc/pade`.
- PR mergeado na branch `/pade2026` (ou principal, conforme processo do
  projeto).
- Release notes disponíveis no GitHub com descrição dos principais entregáveis
  da atualização para Python 3.12.11.

**Responsáveis sugeridos**

- Douglas Barros

**Prazo sugerido**

- **até 2026-03-27** (a release estava prevista para 2026-03-20)

---

### Issue 11 — Validar funcionamento pós-release: regressão dos exemplos base e integrações

**Descrição**

- Após o empacotamento da v2.2.6, é necessário garantir que nenhuma regressão
  foi introduzida.
- Issue para:
  - rodar os exemplos base (`agent_example_1` a `agent_example_6`) na versão
    empacotada;
  - validar scripts de integração (Mosaik, IEEE-13);
  - confirmar que `pade show-logs` e `pade export-logs` funcionam corretamente;
  - registrar evidências (outputs de terminal ou logs CSV).

**Critérios de aceite**

- Todos os exemplos base executando sem erros na versão v2.2.6.
- Integrações (Mosaik, IEEE-13) validadas.
- Evidências registradas na issue ou linkadas.

**Dependências**

- Issue 10 (release publicada).

**Responsáveis sugeridos**

- Douglas Barros

**Prazo sugerido**

- **até 2026-03-31**

---

## ✅ Resumo rápido (tópicos)

- **TSCC (Laiza/Rafael):** validar resultados com orientador; documentar análise
  de escalabilidade; completar Passo 2 do planejamento.
- **TSDQ (Luiz):** corrigir plotagem de valores pequenos; implementar diagrama
  do sistema na interface; validar `mapeamento.json` com padrões ONS/BDGD.
- **TSRE (Paulo):** integrar dados reais BR-PVGen/LEA às simulações; executar
  análise comparativa do sistema 13 barras com e sem FV.
- **PADE (Douglas):** empacotar e publicar release v2.2.6 com PR na
  `/pade2026`; validar regressão dos exemplos e integrações pós-release.
