---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[PESQUISA]: Comunicação entre Containers"
labels: pesquisa, software
assignees: "Rafael Moura"
---

## 📌 Descrição da Atividade

> Implementação e validação da comunicação entre dois containers Docker
> utilizando o projeto OpenTES, garantindo troca de mensagens correta entre os
> serviços distribuídos. O objetivo final é permitir que os dois containers
> estabeleçam comunicação bidirecional funcional dentro da mesma rede Docker,
> utilizando as configurações definidas no repositório oficial do projeto.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | ( ) Outra:
  OpenTES
- **Repositório no GitHub**: <https://github.com/grei-ufc/tscc-com-opentes>
- **Branch de Trabalho:**
  <https://github.com/grei-ufc/tscc-com-opentes/tree/caminho2>
- **Requisito Associado:** Especificação de comunicação distribuída baseada no
  OpenTES (arquitetura cliente-servidor em containers)

## ✅ Checklist de Entrega

- [ ] Código documentado (Docstrings).
- [ ] Testes unitários realizados.
- [ ] Container Docker atualizado (se aplicável).
- [ ] Comunicação validada entre os dois containers.
- [ ] Configuração da rede Docker documentada.
- [ ] Resultados preliminares validados com o Orientador.

## 📈 Resultados / Dificuldades

- **Progresso atual:** 60% [######----] 100%
- **Bloqueios:** Ajustes na configuração de rede Docker e mapeamento de portas
  entre os containers. Necessidade de validar corretamente os parâmetros de
  conexão (host, porta e nome do serviço na rede Docker).

## 📅 Prazo Estimado

- Data de entrega pretendida: 28/02/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Revisar configuração do `docker-compose` e garantir que ambos os
  containers estejam na mesma rede.
- Passo 2. Validar resolução de nome de serviço dentro da rede Docker.
- Passo 3. Implementar testes de envio e recebimento de mensagens entre os
  containers.
- Passo 4. Documentar o processo de configuração e execução.
- Passo 5. Submeter para validação com o orientador.
