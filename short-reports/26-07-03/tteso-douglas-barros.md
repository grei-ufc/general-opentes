---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Estruturar e redigir um primeiro rascunho completo de um artigo científico
  documentando a modernização do framework PADE (da versão legada para
  Python 3.12), com a integração OpenTES temporariamente em standby.
title: "[OpenTES / TTESO]: Início do artigo científico sobre a modernização do PADE"
labels: pesquisa, escrita científica
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

Nesta semana o foco deslocou-se da integração --- deixada **temporariamente em
standby** --- para a **produção científica**. Iniciou-se a redação de um artigo
documentando a **modernização do PADE** (*Python Agent DEvelopment framework*),
o framework de agentes que compõe a camada TTESO/PADE da co-simulação. O
trabalho consistiu em estruturar o projeto LaTeX (template ACM) e escrever um
**primeiro rascunho completo**, a partir de uma investigação a fundo das duas
versões do PADE.

## 🛠 Contexto Técnico

- **Ferramentas:** LaTeX (ACM `acmart`/`sigplan`, Overleaf), Python, Git.
- **Objeto de estudo:** PADE --- versões **2.2.5** (Python 3.7) e **3.0.0** (Python 3.12).
- **Repositório do PADE:** `https://github.com/grei-ufc/pade`
- **Idioma do artigo:** inglês.

## ✅ Checklist de Entrega

- [x] Estrutura modular do artigo (Preâmbulo/Texto/Figuras/Referências) no template ACM
- [x] Investigação das duas versões (guia de migração, empacotamento, *diff* de módulos)
- [x] Rascunho completo das **6 seções** (introdução, fundamentação, PADE legado, modernização, avaliação, conclusão)
- [x] Referências principais (incluindo a publicação oficial do PADE)
- [ ] Revisão e edição do conteúdo pelos autores (em andamento)

## 📊 Resultados / Dificuldades

- **Progresso atual:** 50%

![Progress](https://progress-bar.xyz/50/)

A narrativa técnica documentada no artigo — a diferença central entre as versões — é:

- **Legado (2.2.5, Python 3.7):** núcleo em Twisted + uma pilha web **Flask/SQLAlchemy** com banco **SQLite**, com dependências fixadas em versões exatas e já obsoletas → **não instala em Python 3.12**; o fluxo exigia recriar o banco a cada reinicialização.
- **Novo (3.0.0, Python 3.12):** **remove** a pilha Flask/SQLite; introduz **telemetria em CSV**; unifica a execução em uma **CLI integrada**; adota empacotamento moderno (`pyproject`/`uv`/Docker); e traz um **driver Mosaik 3.0** — a ponte usada pela co-simulação OpenTES.

**Dificuldade principal:** menos técnica e mais de **extração e organização** ---
consolidar as mudanças módulo a módulo a partir do guia de migração e do código
das duas versões, de forma fiel.

## 📝 Observações Técnicas

- A **integração OpenTES** foi deixada **em standby** nesta semana para priorizar a redação do artigo.
- O rascunho foi escrito como uma **base** para edição pelos autores: cada seção
  pode ser aceita, ajustada ou reescrita conforme a revisão.

## 🚀 Próximos passos

- Revisar e editar o conteúdo do artigo (texto + figuras).
- Definir e inserir as figuras principais (arquitetura antes/depois; integração de co-simulação).
- (Futuro) segundo artigo, focado na integração OpenTES, e retomada da integração.

## 🎯 Conclusão

A semana foi dedicada à **produção científica**: um primeiro rascunho completo do
artigo sobre a modernização do PADE, fundamentado na investigação das duas
versões e pronto para a edição dos autores. A integração OpenTES segue em standby
e será retomada na sequência.
