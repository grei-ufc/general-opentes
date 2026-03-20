---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[OPENTES - TSDQ Desenvolvimento de Ferramenta de Análise em Python e Compreensão de código]: "
labels: pesquisa, software
assignees: "[Luiz Alberto Silva Sales Marinho]"
---

## 📌 Descrição da Atividade

A atividade teve o foco principal do desenvolvimento foi a reestruturação arquitetural e o aprimoramento da visualização de dados da interface gráfica da aplicação para resultados do OpenDSS. Realizou-se a migração de toda a lógica rígida de mapeamento de variáveis do código Python para um arquivo de configuração externo dinâmico (mapeamento.json). Essa mudança tornou o sistema universal, permitindo a leitura e plotagem automática de diversas grandezas (Tensão, Corrente, Potências e Irradiância), além de tornar a captura de nomes (Regex) mais robusta para aceitar nomenclaturas complexas, espaços e formatações alinhadas aos padrões oficiais (como ONS e BDGD da ANEEL). Adicionou-se também documentação instrutiva embutida no próprio JSON para orientar a equipe quanto aos padrões de nomenclatura. No aspecto de interface e experiência do usuário (UX), implementaram-se traduções dinâmicas e dicas de contexto automáticas para componentes específicos, como a identificação dos lados primário e secundário de reguladores de tensão.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x ) OpenDSS | (  ) Excel | ( x ) PowerBI
- **Repositório no GitHub**: `[endereço do repositório de trabalho no GitHub](https://github.com/grei-ufc/tsdq-dataview-opentes)`
- **Branch de Trabalho:** `(https://github.com/grei-ufc/tsdq-dataview-opentes/branches)`
- **Requisito Associado:** (Link para o artigo ou especificação técnica)

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings).
- [x] Testes unitários realizados.
- [x] Estudo de obtenção de dados a partir de uma co-simulação.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.

## 📈 Resultados / Dificuldades

- **Progresso atual:** 100%
  
![Progress](https://progress-bar.xyz/75/)
- **Bloqueios:** Problemas na plotagem de valores muito pequenos é apresentado apenas como uma linha reta. 

## 📎Próxima(s) Atividade(s)

Correção de plotagem e estudo a respeito de uma ilustração para cada sistemas.

## 📅 Prazo Estimado

- Data de entrega pretendida: 03/04/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Compreensão dos códigos utilizados para a co-simulação do OpenDSS que incluem essa ilustração do sistema.
- Passo 2. Aplicação da estrutura no código.

