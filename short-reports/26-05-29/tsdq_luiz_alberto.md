---
name: "Relatorio de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avancos em algoritmos, correcoes ou
  novas implementacoes.
title: "[OPENTES - TSDQ]: Desenvolvimento da interface de análise elétrica e comunicação"
assignees: "[Luiz Alberto Silva Sales Marinho]"
---

## Descricao da Atividade

Durante a semana de 25/05/2026 a 29/05/2026, foram realizadas atividades voltadas ao desenvolvimento e refinamento da interface Streamlit do projeto `tsdq-dataview-opentes`, com foco na visualizacao de indicadores de qualidade de energia elétrica, correcao de exibicoes graficas e criacao da página de análise de comunicação proveniente da co-simulacao.

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( ) OpenDSS | ( ) Excel | ( ) PowerBI | ( ) LaTeX | ( x ) VSCode | ( x ) Streamlit | ( x ) Plotly | ( x ) Pandas
- **Repositorio no GitHub:** https://github.com/grei-ufc/tsdq-dataview-opentes
- **Branch de Trabalho:** `refactor/modularizacao-streamlit`
- **Requisito Associado:** Evolucao da interface de visualizacao de dados do OpenTES/TSDQ para análise elétrica, QEE e comunicação.

## Checklist de Entrega

- [x] Implementacao inicial dos cards de qualidade de energia elétrica.
- [x] Correcao das verificacoes de potencia nos cards.
- [x] Ajustes nos cards de tensao, corrente, potencia ativa, potencia reativa, potencia FV, gerador, fator de potencia e frequencia.
- [x] Correcao da plotagem de gráficos da interface de análise elétrica.
- [x] Correcao parcial do algoritmo de escalas e autoescala de unidades.
- [x] Protecoes adicionadas para evitar quebra da interface quando dados esperados nao forem identificados.
- [x] Inclusao da página de comunicação na interface Streamlit.
- [x] Suporte para leitura do arquivo `results.csv` de comunicação.
- [x] Validação minima das colunas obrigatorias do arquivo de comunicação.
- [x] Processamento temporal dos dados de comunicação por origem.
- [x] Desempacotamento de mensagens FIPA-ACL serializadas.
- [x] Calculo de KPIs de comunicação: pacotes enviados, recebidos, dropados, taxa de drop, mensagens, agentes, latência media e jitter medio.
- [x] Criacao de gráficos de latência, jitter, tamanho de mensagens e confiabilidade global da rede.
- [ ] Testes unitarios automatizados realizados.
- [ ] Validação completa dos resultados com o orientador.
- [ ] Container Docker atualizado, se aplicavel.

## Resultados / Dificuldades

- **Principais Resultados:**

  - A interface passou a apresentar um painel de QEE mais completo, com cards organizados para indicadores elétricos globais e para a barra monitorada.
  - Foram adicionados indicadores temporais de tensao, incluindo valor minimo, maximo, medio e desvio padrao em pu.
  - A selecao da tensao de referencia foi incorporada para permitir que o usuario escolha o elemento monitorado na análise de QEE.
  - Foram corrigidas inconsistencias de exibicao relacionadas a unidades e escalas em grandezas eletricas.
  - A página de comunicação foi adicionada ao fluxo da aplicacao, permitindo carregar o `results.csv` e analisar dados de co-simulacao.
  - A interface de comunicação passou a apresentar KPIs resumidos e visualizacoes interativas com Plotly.
  - Foi criada uma aba de dados processados para inspecao das mensagens desempacotadas e da tabela temporal pivotada.

- **Dificuldades encontradas:**

  - Necessidade de tratar diferentes formatos e ausencias de colunas nos arquivos de entrada.
  - Necessidade de proteger a interface contra quebras quando determinadas variaveis eletricas ou de comunicação nao sao identificadas.
  - Ajustes sucessivos de escala e plotagem para manter a leitura dos indicadores coerente na interface.
  - Dependencia de Validação com dados reais adicionais para confirmar o comportamento da página de comunicação em diferentes cenarios de co-simulacao.

- **Progresso atual:** 75%

![Progress](https://progress-bar.xyz/75)

## Proxima(s) Atividade(s)

- Realizar Validação funcional da página de comunicação com novos arquivos.
- Revisar o tratamento de encoding e acentuacao exibido na interface.
- Adicionar testes automatizados para funções de processamento eletrico e comunicação.
- Melhorar a padronizacao visual dos cards e gráficos entre as paginas.
- Revisar os arquivos versionados para remover artefatos gerados automaticamente, como `__pycache__`.
- Consolidar documentacao de uso da interface para análise elétrica e comunicação.
- Implementar funções novas para a análise do DRP e DRC.
- Implementar uma análise de P1 e P99.

## Prazo Estimado

- **Data de entrega pretendida:** 03/06/2026

## Planejamento para conclusao da entrega

1. Validar a execucao completa da interface Streamlit com dados elétricos e dados de comunicação.
2. Conferir se os indicadores exibidos nos cards correspondem aos valores calculados nos modulos utilitarios.
3. Corrigir problemas remanescentes de exibicao, encoding e formatacao visual.
4. Adicionar testes automatizados para as funções principais de QEE, escalas e comunicação.
5. Revisar a branch de trabalho antes da abertura de pull request ou consolidacao no fluxo principal do projeto.
