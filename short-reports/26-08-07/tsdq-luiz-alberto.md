---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[OPENTES - TSDQ]: Artigo CBA 2026 — indicadores de VTRP"
assignees: "[Luiz Alberto Silva Sales Marinho]"
---

## 📌 Descrição da Atividade

Revisão técnica e editorial do artigo “Ferramenta para Apuração Automática de
Indicadores de Tensão em Regime Permanente: Uma Análise Comparativa entre
Normas Nacionais e Internacionais”, considerando os pareceres recebidos na
submissão 5399 do CBA 2026.

O trabalho realizado até o momento concentrou-se na substituição do Cenário 2
por um conjunto de dados mais dinâmico, contendo subtensões e sobretensões, na
atualização dos resultados normativos associados a esse cenário e na revisão
das referências conforme o modelo oficial da conferência.

- **Linguagem/Ferramenta:** (x) Python | ( ) Julia | ( ) Docker | ( ) OpenDSS | ( ) Excel | ( ) PowerBI | (x) LaTeX | (x) VSCode
- **Repositório no GitHub:** https://github.com/grei-ufc/CBA-2026-Quality-Analysis
- **Branch de Trabalho:** a confirmar
- **Requisito Associado:** atendimento aos pareceres da submissão 5399 do CBA 2026

## ✅ Checklist de Entrega

- [x] Formatação das referências aproximada ao modelo oficial da SBA/CBA.
- [x] Novo Cenário 2 processado com 1.429 intervalos de medição.
- [x] Cenário com subtensões e sobretensões incorporado à análise.
- [x] Ocorrência simultânea de componentes $DRP_{sub}$ e $DRP_{sob}$ identificada na Fase B.
- [x] Imagens de perfil de tensão, histograma e percentis do Cenário 2 atualizadas.
- [x] Tabela AS 61000.3.100 do Cenário 2 atualizada.
- [x] Resultados textuais da EN 50160 e ANSI C84.1 atualizados.
- [x] Discussão crítica reformulada para distinguir os dois cenários.
- [x] Referências às Tabelas 4 e 5 corrigidas na análise australiana.
- [ ] Inserir tabela comparativa consolidada por cenário, fase e norma.
- [ ] Inserir no artigo o link público de acesso ao código-fonte da ferramenta.
- [ ] Documentar a origem dos dados: local, período, analisador, concessionária e natureza dos cenários.
- [ ] Ampliar a bibliografia com estudos recentes de 2024–2025, especialmente sobre digitalização da regulação.
- [ ] Acrescentar referências complementares sobre as normas analisadas.
- [ ] Revisar a qualidade editorial e o formato final das figuras.
- [ ] Revisar siglas, repetições e pequenos problemas de redação remanescentes.
- [ ] Realizar validação final com o orientador.

## 📈 Resultados / Dificuldades

- **Principais resultados:**

  - O novo Cenário 2 contém 1.429 registros válidos por fase e apresenta maior variabilidade que o cenário anterior.
  - As fases A e B apresentam subtensão, enquanto a Fase C apresenta sobretensão.
  - A Fase B contém simultaneamente $DRP_{sub}=17,7747\%$ e $DRP_{sob}=0,0700\%$, atendendo à solicitação de um cenário com perturbações de naturezas opostas.
  - Pelo PRODIST, todas as fases do Cenário 2 apresentam alguma não conformidade.
  - Pela AS 61000.3.100, o percentil $P_1$ identifica subtensão nas fases A e B, e o percentil $P_{99}$ identifica sobretensão na Fase C.
  - Pela EN 50160, as três fases permanecem conformes, com 95,31%, 95,17% e 97,55%, evidenciando menor sensibilidade para o perfil analisado.
  - Pela ANSI C84.1, todas as fases violam os Ranges A e B segundo o critério implementado na ferramenta.
  - A nova análise fortalece a hipótese de que os índices agregados DRP e DRC não são suficientes para identificar a natureza física das transgressões.
  - O artigo permanece dentro do limite de quatro a oito páginas informado pelos avaliadores.

- **Dificuldades encontradas:**


- **Progresso atual:** 70%

![Progress](https://progress-bar.xyz/70/)

## 📎 Próxima(s) Atividade(s)

1. Elaborar e inserir a tabela comparativa consolidada com os resultados das quatro normas por fase e cenário.
2. Inserir o endereço público definitivo do código-fonte e verificar se o repositório contém instruções de execução e dependências.
3. Documentar a procedência e as características das campanhas de medição.
4. Selecionar e validar referências recentes de 2024–2025 sem inserir informações bibliográficas não verificadas.
5. Revisar as figuras para publicação, preferencialmente em formato vetorial ou com exportação em alta resolução.
6. Corrigir as pendências editoriais e esclarecer os critérios metodológicos da ANSI e do PRODIST.
7. Submeter a versão consolidada à validação do orientador.

## 📅 Prazo Estimado

- Data de entrega pretendida: a confirmar com o orientador.

## 📋 Planejamento para conclusão da entrega

- **Etapa 1 — Consolidação técnica:** conferir os resultados das quatro normas e produzir a tabela-síntese.
- **Etapa 2 — Reprodutibilidade:** inserir o link do código e documentar dados, dependências e procedimento de execução.
- **Etapa 3 — Fundamentação:** ampliar e conferir a bibliografia recente e as referências normativas.
- **Etapa 4 — Revisão editorial:** revisar texto, siglas, figuras, tabelas, referências cruzadas e paginação.
- **Etapa 5 — Validação:** compilar a versão final, conferir ausência de avisos críticos e encaminhar ao orientador.
