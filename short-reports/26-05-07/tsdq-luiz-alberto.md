---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[OPENTES - TSDQ ]: Atualização do sistema de mapeamento dinâmico e padronização de metadados"
labels: pesquisa, produção científica
assignees: "[Luiz Alberto Silva Sales Marinho]"
---

## 📌 Descrição da Atividade

Durante esta etapa foram realizadas atividades relacionadas à melhoria do sistema de leitura, interpretação e visualização de dados provenientes de co-simulações elétricas no OpenTES-TSDQ. As principais modificações envolveram a atualização do arquivo de mapeamento dinâmico (`mapeamento.json`) e a adequação do dashboard Streamlit para interpretação automática de diferentes grandezas elétricas utilizando expressões regulares (regex).

Foi realizada a revisão completa da padronização de nomenclatura das colunas utilizadas nos arquivos CSV, incluindo a correção de inconsistências entre unidades, prefixos e sufixos das grandezas elétricas. Também foi feita a separação adequada entre variáveis de geração fotovoltaica, potência de geradores e potência da rede, eliminando ambiguidades durante o processo de classificação automática das colunas.

Além disso, foram implementadas melhorias no algoritmo de autoescala de unidades e na visualização gráfica 2D, incluindo ajuste dinâmico do eixo Y com base nos valores mínimo e máximo do elemento selecionado, permitindo melhor visualização de sinais com baixa amplitude de variação.

Também foi desenvolvido e atualizado o manual de padronização de metadados em LaTeX, alinhando sua documentação ao comportamento real implementado no sistema de parsing e mapeamento dinâmico.

Adicionalmente, iniciou-se a implementação de uma nova interface de comunicação para leitura e interpretação de dados provenientes do OMNeT++, permitindo o carregamento de arquivos CSV gerados pela co-simulação de rede de comunicação. 

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | (  ) OpenDSS | (  ) Excel | (  ) PowerBI | ( X ) LaTeX | ( X ) VSCode
- **Repositório no GitHub**: (https://github.com/grei-ufc/CBA-2026-Quality-Analysis)
- **Branch de Trabalho:** `(https://github.com/grei-ufc/CBA-2026-Quality-Analysis/branches)`
- **Requisito Associado:** (https://github.com/grei-ufc/CBA-2026-Quality-Analysis)

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings).
- [ ] Testes unitários realizados.
- [x] Padronização automática de unidades implementada.
- [x] Correção do algoritmo de autoescala.
- [x] Elaboração de manual de padronização de colunas.
- [x] Estudo de obtenção de dados a partir de uma co-simulação.
- [x] Implementação inicial da interface de comunicação OMNeT++.
- [x] Suporte para leitura dinâmica de métricas de comunicação.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.

## 📈 Resultados / Dificuldades

- Principais Resultados:

  - Implementação de mapeamento dinâmico baseado em regex via JSON.
  - Correção de conflitos entre potência da rede e geração de potência.
  - Atualização do sistema de leitura para suportar tensão com e sem identificação de fase.
  - Melhoria da visualização gráfica com ajuste dinâmico do eixo Y.
  - Padronização das unidades elétricas para compatibilidade com o dashboard.
  - Atualização do manual técnico de nomenclatura e metadados.
  - Adequação do sistema para leitura de dados provenientes de co-simulação.
  - Implementação de nova aba de comunicação no dashboard Streamlit.
  - Integração inicial com arquivos CSV exportados pelo OMNeT++.


-  Dificuldades encontradas:

  - Ambiguidade inicial entre padrões regex de potência ativa da rede e geração.
  - Inconsistências entre unidades descritas no manual e aquelas utilizadas nos arquivos CSV.
  - Necessidade de tratamento especial para grandezas sem identificação explícita de fase.
  - Ajuste do algoritmo de autoescala para evitar conversões incorretas de unidades em valores de baixa magnitude.
  - Necessidade de tratamento específico para arquivos contendo simultaneamente dados numéricos, texto e estruturas JSON provenientes do OMNeT++.
  - Adequação da estrutura de pivotamento e filtragem de variáveis válidas para visualização gráfica na interface de comunicação.

- *Progresso atual: * 80%

![Progress](https://progress-bar.xyz/80)

## 📎Próxima(s) Atividade(s)

- Expandir os recursos de visualização da comunicação com indicadores estatísticos e eventos de troca de mensagens.
- Realizar validação dos resultados obtidos com conjuntos reais de dados de co-simulação.
- Corrigir erro de análise da parte de comuinicação.

## 📅 Prazo Estimado

- Data de entrega pretendida: 22/05/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Consolidar a padronização de leitura e classificação automática das grandezas.
- Passo 2. Validar os gráficos e indicadores utilizando diferentes cenários de co-simulação.
- Passo 3. Integrar métricas de comunicação e métricas elétricas em uma visualização unificada da co-simulação.
