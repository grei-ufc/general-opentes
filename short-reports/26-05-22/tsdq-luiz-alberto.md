---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[OPENTES - TSDQ ]: Evolução da interface de Análise Elétrica e implementação inicial do módulo QEE"
assignees: "[Luiz Alberto Silva Sales Marinho]"
---

## 📌 Descrição da Atividade

Durante esta etapa foi realizada uma reestruturação significativa da aba de Análise Elétrica da plataforma OpenTES-TSDQ, com foco em modularização da interface, organização semântica das variáveis elétricas e implementação inicial de funcionalidades voltadas à Qualidade da Energia Elétrica (QEE).

Foi consolidado o fluxo de leitura dinâmica de arquivos CSV oriundos de simulações elétricas, incluindo organização semântica das variáveis a partir do arquivo `mapeamento.json`, identificação automática de grandezas elétricas e preparação das séries temporais para visualização gráfica.

A interface passou a suportar:
- Seleção dinâmica de tipos de variáveis;
- Seleção de elementos elétricos;
- Visualização individual e multissérie de sinais elétricos;
- Organização expandível de datasets e estruturas internas;
- Implementação inicial do painel de Qualidade da Energia Elétrica.

Também foi iniciada a implementação do módulo QEE, incluindo:
- Seleção de barra de referência para monitoramento;
- Cálculo inicial de DRP e DRC conforme PRODIST;
- Cálculo simplificado de desequilíbrio de tensão;
- Implementação de indicadores temporais;
- Organização modular dos cards elétricos;
- Estrutura preparada para futura integração com metadados oriundos da co-simulação.

Foi realizada ainda a revisão da padronização semântica das colunas elétricas do sistema, incluindo ajustes nas regex do `mapeamento.json` para identificação automática de unidades elétricas como MW, MVar, kW, kV, A e pu.

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | (  ) OpenDSS | (  ) Excel | (  ) PowerBI | (  ) LaTeX | (  ) VSCode
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
- [ ] Implementação inicial da interface de comunicação OMNeT++.
- [ ] Suporte para leitura dinâmica de métricas de comunicação.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.

## 📈 Resultados / Dificuldades

- Principais Resultados:

- Modularização da aba de análise elétrica;
- Implementação inicial do dashboard QEE;
- Implementação de DRP e DRC conforme PRODIST;
- Implementação inicial do cálculo simplificado de desequilíbrio;
- Implementação de gráficos multissérie para visualização trifásica;
- Implementação da seleção dinâmica de barras monitoradas;
- Implementação de indicadores temporais;
- Correção da organização de layout dos cards elétricos;
- Consolidação do parser semântico baseado em regex;
- Organização estrutural do sistema visando futura integração com metadados da co-simulação;
- Estrutura preparada para futura integração com análise de comunicação e qualidade de serviço.

-  Dificuldades encontradas:

- Inconsistência inicial entre limites gráficos e cálculo do PRODIST;
- Necessidade de reorganização semântica das variáveis elétricas;
- Problemas relacionados à padronização automática de unidades;
- Dificuldade em separar semanticamente diferentes tipos de potência elétrica;
- Ajustes necessários na renderização HTML dinâmica dos cards;
- Limitações atuais do dataset para implementação de desequilíbrio baseado em componentes simétricas;
- Necessidade de definição futura de metadados da co-simulação para consolidação semântica do sistema QEE.

- *Progresso atual: * 72%

![Progress](https://progress-bar.xyz/72)

## 📎Próxima(s) Atividade(s)

- Refinamento do sistema de autoescala de unidades elétricas;
- Implementação de persistência das configurações QEE;
- Implementação de exportação de relatórios elétricos;
- Desenvolvimento de indicadores avançados de qualidade de energia;
- Estruturação semântica baseada em metadados da co-simulação;
- Implementação futura da integração OMNeT++;
- Implementação de análise harmônica;
- Implementação de mapas elétricos interativos;
- Consolidação visual da interface elétrica em padrão SCADA.

## 📅 Prazo Estimado

- Data de entrega pretendida: 30/05/2026

## 📋 Planejamento para conclusão da entrega

- Consolidação da estrutura modular do sistema QEE;
- Integração futura com metadados oriundos da co-simulação;
- Refinamento da interpretação semântica das variáveis elétricas;
- Validação dos cálculos elétricos conforme PRODIST;
- Expansão dos indicadores temporais;
- Estruturação de futuras análises integradas entre potência e comunicação;
- Organização visual definitiva da plataforma OpenTES-TSDQ.
