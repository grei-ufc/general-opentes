---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Quantificar o impacto da perda de pacotes de comunicação sobre o controle
  Volt/Var distribuído no IEEE 13 Bus, por meio de uma varredura multi-semente
  de 0% a 100% de perda, e diagnosticar um artefato de inicialização da
  co-simulação encontrado durante a análise.
title: "[OpenTES / TTESO]: Sensibilidade do controle Volt/Var à perda de pacotes (multi-semente)"
labels: pesquisa, software
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

A semana de **15 a 19/06/2026** focou em **medir, com rigor estatístico, o
quanto a qualidade da comunicação afeta o controle distribuído**. Sobre o cenário
integrado já consolidado (Volt/Var nos 5 inversores PV, com a tensão trafegando
pela rede OMNeT++), foi executada uma **varredura de perda de pacotes de 0% a
100% em passos de 5%, com 20 sementes por nível**, agregando média e desvio.

Durante a análise, identificou-se um **artefato de inicialização** da
co-simulação que contamina o início de cada rodada — diagnosticado e localizado,
restando a correção como próxima etapa.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (x) Python | (x) Docker | (x) OpenDSS | (x) OMNeT++ | (x) PADE | (x) Mosaik
- **Repositório principal:** `https://github.com/grei-ufc/co-simulation-opentes`
- **Branch de trabalho:** `experimento-sensibilidade-perda`
- **Benchmark adotado:** IEEE 13 Bus (5 PVs, dados climáticos reais BR-PVGen)
- **Requisito associado:** Avaliar a robustez do controle distribuído à degradação da comunicação.

## ✅ Checklist de Entrega

- [x] Experimento de sensibilidade à perda (`run_loss_multiseed.sh`): 0–100% em passos de 5%
- [x] Repetição com **20 sementes por nível** (média ± desvio entre sementes)
- [x] Métrica de **frequência de sobretensão noturna** (anomalia intermitente → estatística)
- [x] Figura com paleta de alto contraste (`turbo`) para os 21 níveis
- [x] Documentação do experimento (`docs/EXPERIMENTO_PERDA.md`, `docs/RESULTADOS.md`)
- [x] Diagnóstico do **artefato de warm-up** (rede "congelada" nas ~2,5h iniciais)
- [ ] Correção do warm-up: instrumentar o `step` (achar a linha) + descartar/pré-aquecer (próxima etapa)

## 📊 Resultados / Dificuldades

- **Progresso atual:** 50%

![Progress](https://progress-bar.xyz/50/)

### ✅ Resultados da Semana

| Módulo/Atividade | Status | Observação |
|------------------|--------|------------|
| **Varredura de perda 0–100% (passo 5%, 20 sementes)** | ✅ | 383 rodadas; saídas em `output/sensibilidade_perda_multiseed/` |
| **Análise multi-semente** | ✅ | barras de erro + frequência de sobretensão por nível |
| **Achado: ponto de quebra** | ✅ | controle confiável **só com 0% de perda** |
| **Achado: degradação** | ✅ | a partir de **~5%**, benefício médio ~0 (indistinguível de zero) |
| **Achado: risco** | ✅ | **sobretensão noturna** intermitente em ~20–45% das rodadas (5–95%) |
| **Artefato de inicialização** | ⚠️ | rede congelada no ponto de carga base nas ~2,5h iniciais |
| **Diagnóstico do artefato** | ✅ | **OpenDSS correto**; causa na camada Mosaik↔OpenDSS |

### 🧠 Atividades Desenvolvidas na Semana

1. **Script `run_loss_multiseed.sh`**: varia `drop_probability` e `seed-0-mt` no `omnetpp.ini` (restaurando ao fim), resumível, cobrindo 0–100% em passos de 5%, 20 sementes por nível.
2. **Métricas robustas** (`plot_loss_multiseed.py`): para cada nível, média ± desvio do *lift* de tensão, do reativo injetado e da entrega; e a **frequência de sobretensão noturna** entre as sementes.
3. **Conclusão estatística:** o controle só é **confiável com comunicação perfeita**. Com **qualquer perda (≥5%)** o benefício médio cai para ~0 com variância maior que a média (estatisticamente indistinguível de zero); em **100%** o controle fica inerte (= baseline).
4. **Caracterização da sobretensão:** o reativo "preso" em valor desatualizado (dado velho) sobre-injeta e leva a barra crítica a **> 1,0 pu de madrugada** em parte das sementes — risco presente em toda a faixa de perda.
5. **Diagnóstico do artefato de warm-up:** verificado que o **modelo elétrico (OpenDSS) está correto** (a rede, dirigida fora do Mosaik, responde desde o passo 0); o congelamento aparece **também no cenário isolado**, logo é da **orquestração Mosaik↔OpenDSS**, não do acoplamento de comunicação.
6. **Documentação** do experimento e dos achados em `docs/EXPERIMENTO_PERDA.md` e `docs/RESULTADOS.md`.

### ⚠️ Dificuldades Enfrentadas

- **Métrica frágil com poucas sementes:** com 1 semente o resultado sugeria um "limiar abrupto" que se mostrou **ruído**; só com 20 sementes a leitura ficou honesta (benefício ~0 a partir de 5%).
- **Artefato de inicialização (warm-up):** nas ~2,5h iniciais a rede fica presa no ponto de carga base e a tensão não responde, contaminando o começo de cada rodada e a métrica de *lift*. **A correção será feita posteriormente.**

## 🗓 Prazo Estimado

- Correção do artefato e reprocessamento das métricas: **próxima semana**.

## 📋 Planejamento para conclusão da entrega

### ✅ Concluído nesta semana

- [x] Varredura completa de perda (0–100%, passo 5%, 20 sementes)
- [x] Métricas multi-semente + frequência de sobretensão
- [x] Diagnóstico (não a correção) do artefato de warm-up

### 📝 Próximos passos

- Passo 1. **Instrumentar o `step`** do simulador de grid para apontar a linha exata do warm-up na camada Mosaik↔OpenDSS [opção (a)].
- Passo 2. **Descartar/pré-aquecer** as ~3h iniciais nas métricas e figuras e reprocessar o experimento.
- Passo 3. Revisar a métrica de benefício (ex.: tempo fora da faixa de tensão) para medir melhor o efeito do controle.

## 📝 Observações Técnicas

O experimento reforça, com respaldo estatístico, a tese do projeto: **não basta o
controlador agir — ele precisa de informação a tempo e confiável**. Comunicação
degradada não entrega um "meio-controle"; torna o Volt/Var **imprevisível e
potencialmente perigoso** (sobretensão) antes de simplesmente pará-lo.

O ponto em aberto mais relevante é o **artefato de inicialização** da
co-simulação: já localizado (camada Mosaik↔OpenDSS, com o modelo elétrico
validado como correto), pendente de correção.

## 🎯 Conclusão

A semana quantificou, de forma estatisticamente robusta (20 sementes por nível),
**até que ponto o controle Volt/Var distribuído resiste à perda de comunicação** —
e a resposta é dura: praticamente só com **0% de perda**. Em paralelo, o estudo
revelou e localizou um **artefato de inicialização** da co-simulação, cuja
correção é a primeira tarefa da próxima etapa.
