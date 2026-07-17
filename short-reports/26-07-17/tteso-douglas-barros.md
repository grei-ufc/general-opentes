---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Faxina técnica do repositório: remoção de código morto e de tudo que não é do
  IEEE 13, unificação dos scripts de execução em um único run.sh e documentação
  dos dois caminhos de instalação (Docker e uv).
title: "[OpenTES / TTESO]: Faxina do repositório, unificação da execução e documentação"
labels: software, manutenção
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

Semana dedicada à **manutenção do repositório**, motivada por uma preocupação de
usabilidade: *quem abrir o projeto no GitHub consegue entendê-lo e executá-lo?*
O trabalho foi de **remoção** (código morto e material alheio ao IEEE 13),
**unificação** (4 scripts de execução → 1) e **documentação**.

## 🛠 Contexto Técnico

- **Repositório:** `grei-ufc/co-simulation-opentes` — branch `experimento-sensibilidade-perda`
- **Ferramentas:** Docker Compose, `uv`, Bash, Git

## ✅ Checklist de Entrega

- [x] Auditoria do `grid-opentes`: mapeamento de cada arquivo e do que a cadeia viva de fato carrega
- [x] Remoção de **código morto** (inclusive dois arquivos **quebrados**)
- [x] Remoção de tudo **fora do IEEE 13** (123 Barras, SimBench) e das dependências órfãs
- [x] **Unificação da execução**: 4 scripts → `./run.sh <comando>` com `--help`
- [x] Correção de um **race** de inicialização no cenário `ieee13`
- [x] README com os **dois caminhos de instalação** (Docker e `uv`) e todos os comandos

## 📊 Resultados / Dificuldades

- **Progresso atual:** 100%

![Progress](https://progress-bar.xyz/100/)

**3 commits, 35+ arquivos, ~4.300 linhas a menos.** Os destaques:

- **Execução unificada.** Os 4 scripts (`run_opentes`, `run_48h`, `run_loss_sweep`,
  `run_loss_multiseed`) duplicavam a mesma lógica — o `cleanup()` era **idêntico
  byte a byte nos 4**. Viraram um `./run.sh` com 6 comandos e `--help`, sem perder
  nenhum comportamento. Um fix num lugar agora vale para todos.
- **Faxina.** Saíram a pasta órfã de *loadshapes* (as curvas vivas estão inline em
  outro arquivo), o notebook e o guia do 123 Barras, as dependências `simbench`,
  `mosaik-pandapower` e `ipython`, e dois arquivos **quebrados** (`main.py` e um
  `docker-compose.yml` que subiam módulos já removidos). Os *locks* caíram de
  **86→53** e **56→37** pacotes.
- **Dois bugs encontrados.** (i) O cenário `ieee13` tinha um *race*: o Mosaik
  conectava antes dos simuladores estarem ouvindo. (ii) O `csv_sim_pandas.py`
  dependia do `mosaik-api` só **transitivamente** — a dependência agora é explícita.

## 📝 Observações Técnicas

- Não houve observações extras.

## 🚀 Próximos passos

- Retomar a redação do artigo (revisão do texto pelos autores).
- Iniciar finalmente estudo de sistema transativo para implementação.

## 🎯 Conclusão

Semana sem avanço científico, mas com o repositório **substancialmente mais
enxuto e legível**: um único comando de execução, documentação que responde
"como instalo e como rodo?", e dois bugs a menos.
