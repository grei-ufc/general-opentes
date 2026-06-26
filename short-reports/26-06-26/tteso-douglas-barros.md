---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Corrigir os dois artefatos de simulação diagnosticados na semana anterior
  (congelamento do solve e off-by-one nos loadshapes), re-rodar e re-analisar de
  forma honesta o experimento de perda, confirmar o ciclo diário em 48h, avaliar
  a eficiência do controle Volt/Var e suas alternativas, e limpar o repositório.
title: "[OpenTES / TTESO]: Correção dos artefatos, re-análise honesta do Volt/Var e limpeza do código"
labels: pesquisa, software
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

A semana de **22 a 26/06/2026** **fechou o ciclo aberto na anterior**: os dois
**artefatos de simulação** que contaminavam o experimento de perda foram
**corrigidos**; o experimento foi **re-executado e re-analisado de forma honesta**;
o **ciclo diário foi confirmado em um estudo de 48h**; a **eficiência do controle
Volt/Var** foi avaliada (junto de suas alternativas); e o repositório foi **limpo**
para conter apenas o essencial da integração dos três simuladores
(PADE + OMNeT++ + OpenDSS via Mosaik).

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (x) Python | (x) Docker | (x) OpenDSS | (x) OMNeT++ | (x) PADE | (x) Mosaik
- **Repositório principal:** `https://github.com/grei-ufc/co-simulation-opentes`
- **Branch de trabalho:** `experimento-sensibilidade-perda`
- **Benchmark adotado:** IEEE 13 Bus (5 PVs, dados climáticos reais BR-PVGen)

## ✅ Checklist de Entrega

- [x] Correção do **congelamento do solve** (`set_pvsystem_pq`): *dither* de ±1 var → o solve volta a re-resolver
- [x] Achado + correção do **off-by-one nos LoadShapes** (pico espúrio de ~1,02 pu no fim do dia)
- [x] **Re-execução** do experimento de perda + estudo de **48h**, já com os dois fixes
- [x] **Retratação** das conclusões antigas (ponto de quebra ~5% / não-confiável / sobretensão = artefatos)
- [x] **Estudo de 48h** confirma que o ciclo diário se repete (dia 2 ≡ dia 1)
- [x] **Análise da eficiência do Volt/Var** (R/X do caminho, *headroom* de reativo, alternativas)

## 📊 Resultados / Dificuldades

- **Progresso atual:** 100%

![Progress](https://progress-bar.xyz/90/)

### ✔ Resultados da Semana

| Módulo/Atividade | Status | Observação |
|------------------|--------|------------|
| **Correção do solve (`set_pvsystem_pq`)** | ✅ | a madrugada "descongela" já no passo 2 (era ~passo 31); controle ativo desde o início |
| **Correção do off-by-one (LoadShapes)** | ✅ | `npts` ajustado para casar com os valores; some o pico de ~1,02 pu no fim do dia |
| **Re-análise honesta da perda** | ✅ | o controle **regula** (~7–11% do desvio de tensão); **0 violações ANEEL** em toda a faixa |
| **Retratação** | ✅ | "ponto de quebra ~5% / não-confiável / sobretensão noturna" eram **artefatos dos dois bugs** |
| **Estudo de 48h** | ✅ | o ciclo **fecha**: a tensão da barra 652 no dia 2 é idêntica à do dia 1 |
| **Eficiência do Volt/Var** | ✅ | reativo é **efetivo** na 652 (R/X do caminho ≈ 0,76, X-dominante); limite é o **ganho conservador** |

### 🧠 Atividades Desenvolvidas na Semana

1. **Correção do congelamento do solve.** A causa-raiz localizada na semana anterior
   (`set_pvsystem_pq`, em `opendss_wrapper.py`) foi corrigida. Em modo *snapshot*, o
   OpenDSS reaproveita a tensão do passo anterior quando o `Edit PVSystem` repete
   exatamente os mesmos valores (típico da madrugada, com P solar = 0 e Q estável),
   "congelando" a rede por ~2,5 h. A solução foi um **dither imperceptível no reativo
   (±0,001 kvar = ±1 var, alternando a cada passo)**, que faz o comando nunca ser
   idêntico e força o re-solve — sem efeito físico.
2. **Correção do off-by-one nos LoadShapes.** O estudo de 48h revelou um pico de
   ~1,02 pu no último ponto de cada dia, presente até no *baseline*. As curvas
   `LoadShape1–8` declaravam `npts=144` mas traziam 143 (ou 145) valores; o OpenDSS
   preenchia o ponto faltante com 0,0 (carga zero às 23:50) → sobretensão momentânea.
   Cada curva passou a ter exatamente `npts` valores.
3. **Re-execução e re-análise honesta.** Com os dois fixes, o perfil diário ficou
   **fisicamente coerente** e o controle **regula a tensão e é seguro em toda a faixa
   de perda** (sem violação ANEEL). Constatou-se que a métrica "lift da média" é
   **enganosa** (premia injeção de reativo, não regulação); a métrica honesta é a
   **redução do desvio-padrão da tensão** (~7–11% em todos os níveis). Neste estudo
   de caso, a perda **não degrada fortemente** o benefício, porque a tensão muda
   devagar (passos de 5 min) e o último Q válido "segurado" ainda regula.
4. **Estudo de 48h.** Em horizonte de 2 dias (mesma irradiância), o ciclo **fecha** —
   o dia 2 repete o dia 1 —, confirmando a coerência temporal após o fix do solve.
5. **Análise da eficiência do Volt/Var.** Avaliou-se se o reativo é a melhor escolha
   na barra crítica (652): a tensão ali depende da impedância **acumulada** da
   subestação até a barra, dominada pela linha-tronco longa (632→671), cujo **R/X do
   caminho ≈ 0,76 (X-dominante)** — ou seja, **o reativo é efetivo** (não é o caso de
   "reativo fraco" sugerido por olhar só a linha-ponta). O limite atual de eficiência
   é o **ganho conservador (5% do kVA)**, que deixa **grande folga de reativo sem uso
   à noite**. Alternativas com mais autoridade: **regulador de tap** (já existe na
   subestação, hoje travado para isolar o estudo), **mais reativo** (ganho maior, a
   verificar estabilidade) ou **bateria** (potência ativa).


### ⚠️ Dificuldades Enfrentadas

- **Quirk do OpenDSS em *snapshot*:** o congelamento só foi resolvido após entender
  que o solve reaproveita a tensão quando o `Edit PVSystem` repete; forçar o re-solve
  por outros meios (rebuild Y, `mode=snap`, solve duplo) não funcionou — o *dither*
  de ±1 var resolveu.
- **Métrica frágil:** o "lift da média" mistura suporte e regulação e pode enganar;
  migrou-se para a redução do desvio-padrão (e tempo fora de faixa) como métrica de
  *quanto o controle regula*.

## 🚀 Planejamento para conclusão da entrega

### ✅ Concluído nesta semana

- [x] Correção dos dois artefatos (solve + loadshape)
- [x] Re-execução do experimento + estudo de 48h + re-análise honesta
- [x] Análise da eficiência do Volt/Var e suas alternativas
- [x] Limpeza do repositório (só o essencial da integração)

### 📌 Próximos passos

- Passo 1. Iniciar estudos de sistemas transativos para aplicação no nosso simulador. Sugestão que achei melhor: IEEE4Bus

## 📝 Observações Técnicas

As inconsistências apontadas pelo professor (tensão constante na madrugada; início ≠
fim do dia; dependência estranha da perda) eram, na raiz, **dois bugs de simulação —
não falhas do controle**: o **congelamento do solve** (`set_pvsystem_pq`) e o
**off-by-one nos LoadShapes**. Corrigidos, a física ficou coerente (ciclo de 48h
fecha, sem violação ANEEL) e as **conclusões dramáticas anteriores foram retratadas**.
Quanto à eficiência, o **Volt/Var é uma escolha adequada** para a barra 652 (o reativo
regula bem ali); o que limita sua atuação hoje é o **ganho conservador**, e não a
física — o que abre espaço para aumentá-lo (verificando estabilidade) ou para
alternativas com autoridade de potência ativa.

## 🎯 Conclusão

A semana **fechou o ciclo aberto na anterior**: corrigiu os artefatos diagnosticados,
tornou a leitura do experimento de perda **honesta e fisicamente coerente** (ciclo de
48h fecha, controle regula ~7–11% do desvio, sem violação ANEEL), avaliou a
**eficiência do Volt/Var** (adequado; limitado pelo ganho, não pela física) e deixou
o **código enxuto**, só com o essencial da integração dos três simuladores.
