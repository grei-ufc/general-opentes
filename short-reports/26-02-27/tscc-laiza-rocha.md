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

> Diagnóstico e resolução do problema de inicialização do container com OMNet++, no projeto de containerização MOSAIK + OMNET + COSIMA, em progresso. A abordagem está sendo reconstruir o Dockerfile do omnet utilizando como referência o Dockerfile do cosima e realizando testes no ambiente local.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X)
  Outra: C++ (OMNeTpp/INET)
- **Repositório no GitHub**: https://github.com/grei-ufc/tscc-com-opentes
- **Branch de Trabalho:** https://github.com/grei-ufc/tscc-com-opentes/tree/development-1
- **Requisito Associado:** (Link para o artigo ou especificação técnica)

## ✅ Checklist de Entrega

- [ ] Código documentado (Docstrings).
- [X] Testes unitários realizados.
- [X] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [ ] Outros itens que não foram listados acima: 

## 📈 Resultados / Dificuldades

- **Progresso atual:** 65% [███████░░░] → 100%
- **Bloqueios:** Após tentativa de análise dos logs e tentativa de iniciar o container do OMNeT++ manualmente, a causa raiz ainda não foi identificada. Uma hipótese é que o Dockerfile do OMNeT++ atual possa ter configurações incompatíveis ou faltantes, herdadas da fase de construção inicial, que impedem a execução completa do processo, por isso, copiei inteiramente o repositório do projeto COSIMA na minha aplicação e estou utilizando como referência o Dockerfile do projeto COSIMA para a construção de um outro Dockerfile OMNETpp e realizando os testes localmente, no VSCode antes de submeter as alterações para a branch..
 
## 📅 Prazo Estimado

- Data de entrega pretendida: 06/03/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Finalizar a reconstrução do Dockerfile do OMNeT++: Adaptar o Dockerfile do COSIMA para incluir todas as dependências e as etapas de build necessárias para o OMNeT++/INET.
- Passo 2. Construir a nova imagem e testar a inicialização: Executar o build da nova imagem e verificar se o container do OMNeT++ sobe corretamente e mantém o processo ativo.
- Passo 3. Verificar configurações de rede e portas.
- Passo 4. Comunicação TCP entre MOSAIK e OMNeT++.
