---
name: "🚀 Relatório de Progresso"
about: "Parâmetros de Rede Wireless"
title: "[OPENTES - TSCC] Evolução da Telemetria e Interface de Usuário"
labels: pesquisa, software, integração, progresso
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade
Refatoração do protocolo de comunicação entre agentes PADE na simulação
tscc-com-opentes, substituindo o transporte manual de mensagens ACL
(via val_out/val_in do Mosaik) pelo protocolo FIPA nativo do PADE,
seguindo o padrão identificado na simulação de referência (a tese da profa Janaína Almada).

## 🛠 Contexto Técnico
* **Linguagem/Ferramenta:** (X) Python | () C++ | (X) Docker | (X) ZeroMQ | (X) PADE
* **Repositório Principal:** tscc-com-opentes
* **Status do Ambiente:** In Transition / Under debugging

## ✅ Checklist de Entrega
- [x] Identificação dos métodos próprios que substituíam o protocolo FIPA
      em pade_sim.py e pade_star.py 
- [x] Lógica alinhada dos métodos do protocolo FIPA com referência acadêmica validada na simulação da tese da profa Janaína Almada
## 📈 Resultados / Dificuldades
* **Progresso atual:** 90% [████████░]
* **Resultados:**
  - pade_sim.py e pade_star.py reescritos com protocolo FIPA nativo completo,mas ainda é preciso testar
* **Dificuldades identificadas (Ainda não funcional):**
  - No momento, há a carência de dificuldades pela falta do teste.

## 📅 Próximos Passos (Pesquisa)
* Validar execução completa com docker compose up --build sem erros
* Fechar as issues atribuídas ao nosso time
* Documentar padrão PADE + Mosaik + FIPA no README para referência futura
