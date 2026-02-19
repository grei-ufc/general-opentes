---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[OpenTES-TSCC]:: "
labels: pesquisa, software
assignees: "[Laiza Edwigens Rocha Silva]"
---

## 📌 Descrição da Atividade

> Implementando a containerização MOSAIK + OMNeTpp + COSIMA, com foco na separação dos ambientes em contêineres distintos.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X)
  Outra: C++ (OMNeTpp/INET)
- **Repositório no GitHub**: https://github.com/grei-ufc/tscc-com-opentes
- **Branch de Trabalho:** https://github.com/grei-ufc/tscc-com-opentes/tree/development-1
- **Requisito Associado:** (Link para o artigo ou especificação técnica)

## ✅ Checklist de Entrega

- [X] Código documentado (Docstrings).
- [X] Testes unitários realizados.
- [X] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [X] Outros itens que não foram listados acima: Substituição da branch development (estava com muitos arquivos de teste do período de construção da imagem) por development-1.

## 📈 Resultados / Dificuldades

- **Progresso atual:** 60% `[██████░░░░]` 100%
- **Bloqueios:** Apesar das imagens serem construídas com sucesso, o container do Mosaik inicia e aguarda por 60 tentativas de conexão na porta 4242, e o container do OMNeT++ não inicia. O processo morre antes de abrir a porta para comunicação. Tentei iniciar ele manualmente, então abri a aplicação pelo Docker Desktop, abri o terminal dentro do desktop, construí as imagens e apareceu os contêineres e dentro da aplicação cliquei no botão de start que fica ao lado do contêiner e mesmo assim o contêiner do omnet não iniciou. Por isso, a comunicação entre os containers não é estabelecida, o OMNeT++ não consegue executar completamente.
A causa do problema ainda não foi identificada, executo em um segundo terminal `docker logs cosima-omnet`, enquanto estou com o `docker-compose up` (após construir a imagem do omnet), mas eu ainda não consegui entender o que os logs estão mostrando.
## 📅 Prazo Estimado

- Data de entrega pretendida: 06/03/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Diagnosticar por que o container OMNeT++ não executa
- Passo 2. Estabelecer a comunicação TCP entre MOSAIK e OMNeT++
