---
name: "🚀 Relatório de Progresso / Nova tarefa"
about: Atualizar o framework PADE da versão Python 3.8 para 3.12.11, removendo dependências obsoletas e conflitantes, preservando a funcionalidade core de sistema multiagentes baseado em Twisted.
title: "[OpenTES-TTESO]: PADE para Python 3.12.11 "
labels: pesquisa, software
assignees: "[Francisco Douglas Barros da Silva]"
---

## 📌 Descrição da Atividade

Atualização do framework PADE de sua versão 2.2.5 para a provisória versão 2.2.6.

**Bibliotecas Removidas:**
- `SQLAlchemy===1.3.10`
- `alchimia===0.8.1`
- `werkzeug===0.16.0`
- `markupsafe===1.1.1`
- `jinja2===2.10.3`
- `itsdangerous==1.1.0`
- `Flask-Script===2.0.6`
- `Flask-Bootstrap===3.3.7.1`
- `Flask-Login===0.4.1`
- `Flask-WTF===0.14.2`
- `Flask-SQLAlchemy===2.4.1`
- `Flask-Migrate===2.5.2`
- `Flask===1.1.1`

**Bibliotecas Atualizadas:**
*Versões Novas:*
- `twisted>=22.10.0`
- `requests>=2.31.0`
- `click>=8.1.0`
- `terminaltables>=3.1.0`

*Versões Antigas:*
- `twisted>=19.7.0`
- `requests>=2.22.0`
- `click>=7.0`
- `terminaltables>=3.1.0`

### 🔍 Motivos das Remoções

**Alchimia (0.8.1)**
- **Motivo:** Conflito arquitetural entre Twisted (assíncrono) e SQLAlchemy (síncrono).
- **Status:** Biblioteca abandonada (última atualização em 2018).
- **Problema:** Não é compatível com Python 3.12 e não recebe atualizações desde 2018.
- **Impacto:** Era a ponte que permitia SQLAlchemy rodar com Twisted, mas causava deadlocks.

**SQLAlchemy (1.3.10)**
- **Motivo:** ORM bloqueante em sistema assíncrono.
- **Versão:** Extremamente defasada (1.3.10 vs atual 2.0+).
- **Problema:** Forçava o uso de Alchimia para integração com Twisted.
- **Impacto:** Causava gargalos de performance e problemas de concorrência.

**Flask e Ecossistema Web**
- **Motivo:** Interface web NÃO seria utilizada para a aplicação que necessitamos no momento.
- **Problema:** Adicionava complexidade desnecessária e dependências pesadas.
- **Impacto:** A remoção simplifica drasticamente a arquitetura.

---

### 🏗️ Status do Framework

**✅ Preservados e ajustados:**
* **Sistema Multiagente Completo:**
  - AMS (Agent Management System) - Gerenciamento de agentes.
  - Sniffer - Monitoramento de mensagens.
  - Protocolos FIPA-ACL - Comunicação padrão FIPA.
  - Behaviours - Comportamentos dos agentes.
  - AID (Agent Identifier) - Identificação de agentes.
  - Peer-to-peer communication - Comunicação direta entre agentes.
* **Integrações Mantidas:**
  - Twisted reactor - Loop de eventos assíncrono.
  - Comunicação TCP/IP - Base da arquitetura distribuída.
  - CLI completo - Todos os comandos essenciais.
  - Logging - Agora em CSV (antes em BD).

**❌ Removidos:**
* **Funcionalidades Web/Banco de Dados:**
  - Interface web Flask - Dashboard de monitoramento.
  - Banco de dados SQLite - Persistência em SQL.
  - Autenticação de usuários - Login/senha via web.
  - Migrações de banco - Alembic/Flask-Migrate.
  - Modelos ORM - SQLAlchemy models.
* **Outras funcionalidades:**
  - Alchimia - Camada de compatibilidade Twisted+SQLAlchemy.
  - Flask-Script - Scripts de gerenciamento web.
  - Flask-Bootstrap - Templates CSS.
  - WTF Forms - Validação de formulários.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** [X] Python | [ ] Julia | [ ] Docker | [ ] Outra: _____
- **Repositório no GitHub**: [grei-ufc/pade](https://github.com/grei-ufc/pade)
- **Branch de Trabalho:** `/tree/pade2026`
- **Requisito Associado:** *(Adicione o link aqui, se houver)*

## ✅ Checklist de Entrega

**Um framework multiagentes:**
- [x] 100% funcional em Python 3.12.11
- [x] Baseado puramente em Twisted (assíncrono)
- [x] Sem dependências obsoletas ou conflitantes
- [x] Com logging em CSV para análise posterior
- [x] Mantendo todos os protocolos FIPA e comportamentos
- [ ] Código documentado (Docstrings)
- [ ] Testes unitários realizados
- [ ] Container Docker atualizado (se aplicável)
- [ ] Resultados preliminares validados com o Orientador
- [ ] Outros itens que não foram listados acima

## 📈 Resultados / Dificuldades

- **Progresso atual:** 60% `[██████░░░░]` 100%
- **Bloqueios:** O principal bloqueio no momento é a exibição de caracteres desconhecidos/hexadecimais nos logs do terminal. Mensagens que deveriam ser texto legível estão aparecendo como sequências de bytes (ex: `b'\x80\x04\x95...'`) ou caracteres Unicode mal interpretados (ex: `⚠<fe0f>`). Acredito que isso esteja relacionado à forma como o PADE serializa as mensagens (usando `pickle`) e como o método `react()` dos agentes está processando esses dados. Ainda estou buscando uma solução definitiva para tratar esses dados binários e exibi-los de forma legível sem quebrar a funcionalidade do sistema.

## 📅 Prazo Estimado

- **Data de entrega pretendida:** 02/03/2026

## 📋 Planejamento para conclusão da entrega

1. **Corrigir a exibição de caracteres hexadecimais nos logs:** Implementar tratamento adequado no método `react()` dos agentes para diferenciar mensagens de texto de dados binários (tabela de agentes serializada com pickle). Criar uma função utilitária que converta bytes para formato legível quando possível, ou exiba uma mensagem amigável (ex: `[Tabela de agentes recebida]`) em vez do conteúdo binário bruto.
2. **Testar exemplos legados do PADE:** Executar todos os exemplos da pasta `examples/` original na nova versão, incluindo:
   - Exemplos com protocolos FIPA (Request, Contract Net, Subscribe).
   - Comportamentos temporizados (`TimedBehaviour`).
   - Comunicação entre múltiplos agentes.
   - Exemplos que utilizam o Sniffer para captura de mensagens.
   - *Documentar quais exemplos funcionam 100% e quais precisam de ajustes.*
3. **Validar o sistema de logging CSV:** Testar exaustivamente o `data_logger.py` com cenários reais de comunicação entre agentes, verificando se:
   - Todas as mensagens são registradas corretamente nos arquivos CSV.
   - Caracteres especiais e conteúdo complexo são tratados adequadamente.
   - Os comandos `pade show-logs` e `pade export-logs` funcionam como esperado.
   - Não há perda de dados ou problemas de concorrência na escrita dos arquivos.
