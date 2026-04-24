
---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[OPENTES - TSDQ ]: "
labels: pesquisa, produção científica
assignees: "[Luiz Alberto Silva Sales Marinho]"
---

## 📌 Descrição da Atividade

Desenvolvimento e correção do sistema de visualização de grandezas elétricas no dashboard, com foco na padronização automática de unidades e melhoria da robustez do parser de colunas provenientes do OpenDSS.

Foram realizadas correções na lógica de conversão de unidades (MW → W, MVAr → var), implementação de um sistema de autoescala consistente baseado em ordem de grandeza e ajuste da estrutura de cálculo da escala global para evitar distorções (uso de valor máximo ao invés de média).

Além disso, foi identificado um problema estrutural na dependência da unidade a partir da variável selecionada, sendo proposta uma abordagem mais robusta baseada no nome da coluna (ex: _mw, _mvar, _pu). Também foi estruturado um manual de padronização de nomes de colunas para garantir compatibilidade com o parser via regex.

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | (  ) OpenDSS | (  ) Excel | (  ) PowerBI | (  ) LaTeX | ( X ) VSCode
- **Repositório no GitHub**: (https://github.com/grei-ufc/CBA-2026-Quality-Analysis)
- **Branch de Trabalho:** `(https://github.com/grei-ufc/CBA-2026-Quality-Analysis/branches)`
- **Requisito Associado:** (https://github.com/grei-ufc/CBA-2026-Quality-Analysis)

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings).
- [x] Testes unitários realizados.
- [x] Padronização automática de unidades implementada.
- [x] Correção do algoritmo de autoescala.
- [x] Elaboração de manual de padronização de colunas.
- [ ] Estudo de obtenção de dados a partir de uma co-simulação.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.

## 📈 Resultados / Dificuldades

- Principais Resultados:
  - Eliminação de erros de unidade (exibição incorreta em µW e mW).
  - Implementação de escala automática consistente para visualização.
  -  Melhoria da confiabilidade na leitura de dados do OpenDSS.
  -  Integração entre nomenclatura das colunas e interpretação física das grandezas.
    
-  Dificuldades encontradas:
  -  Inconsistência entre unidade nominal da variável e valor numérico interpretado.
  -  Dependência inicial de apenas uma curva para definição de escala global.
  -  Problemas de indentação e estrutura lógica no código Python.
  -  Interpretação inadequada da unidade a partir do rótulo ao invés do sufixo da coluna.

- *Progresso atual: 75* %

![Progress](https://progress-bar.xyz/75/)

## 📎Próxima(s) Atividade(s)

- Melhorar a interface gráfica (UX) do dashboard.
- Generalizar o parser para novas grandezas elétricas.

## 📅 Prazo Estimado

- Data de entrega pretendida: 01/05/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Implementar suporte expandido de unidades no parser.
- Passo 2. Refinar visualização e consistência da interface.



