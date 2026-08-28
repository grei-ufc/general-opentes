---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[PESQUISA]: "
labels: pesquisa, software
assignees: "Paulo Victor"
---

## 📌 Descrição da Atividade

> Ajustes e atualizações no código pv_creator (melhoria da identificação de barras, melhoria da interpolação de dados, pequenas correções).
> Adição da rede IEEE Low Voltage Test Case para utilizar na co-simulação e integração com o pv_creator.
> Geração de arquivos cvs e json para plotagem na plataforma de visualização (Beto), tanto da rede LVTestCase quanto para a 13 barras.
> Ajustes na geração das colunas do arquivo csv gerado para identificação das barras nos elementos de geração FV.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | ( ) Docker | (X) OpenDSS 
- **Repositório no GitHub**: `github.com/grei-ufc/tsre-der-opentes.git`
- **Branch de Trabalho:** `tsre-der-opentes/paulo-victor`
- **Requisito Associado:** (Link para o artigo ou especificação técnica)

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings).
- [x] Testes unitários realizados.
- [x] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [ ] Outros itens que não foram listados acima.

## 📈 Resultados / Dificuldades

Tarefa | Progresso
|----------|----------|
| Implementação do sistema IEEE 13 barras na interface gráfica | ![Progress](https://progress-bar.xyz/100/) | 
| Ajustes e atualizações no código pv_creator (melhoria na identificação de barras e interpolação de dados) | ![Progress](https://progress-bar.xyz/100/) | 
| Adição da rede IEEE Low Voltage Test Case para co-simulação e integração com o pv_creator | ![Progress](https://progress-bar.xyz/100/) | 
| Geração de arquivos CSV e JSON para plotagem na plataforma de visualização (rede LVTestCase e 13 barras) | ![Progress](https://progress-bar.xyz/100/) | 
| Ajustes nas colunas do arquivo CSV gerado para identificação das barras nos elementos de geração FV | ![Progress](https://progress-bar.xyz/100/) |

Topologia da rede IEEE Low Voltage Test Case:
<img width="694" height="419" alt="Single-line-diagram-of-IEEE-European-Low-Voltage-Test-Feeder-denoting-the-number-of-each" src="https://github.com/user-attachments/assets/b6f7a492-db93-42b4-8281-64b1ad1b1315" />

Ilustração de melhoria na interpolação de dados:
<img width="3300" height="1800" alt="comparacao_interpolacao_temperatura" src="https://github.com/user-attachments/assets/505ed63c-35d0-43b8-a58f-ee61c32aaade" />


## 📅 Prazo Estimado

- Data de entrega pretendida: 04/09/2026

## 📋 Planejamento para conclusão da entrega

- Implementação de notebook python com diferentes cenários de penetração FV na rede LVTestCase para os EUs.
