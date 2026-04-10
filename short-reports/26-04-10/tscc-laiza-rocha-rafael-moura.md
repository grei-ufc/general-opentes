---
name: "🚀 Relatório de Progresso "
about:
  Avanços do time de co-simulação e simulação de comunicação
title: "[OPENTES - TSCC] Desenvolvimento de aplicação de simulação e co-simulação em ambientes conteinerizados"
labels: pesquisa, software
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---
## 📌 Descrição da Atividade

Continuando à co-simulação entre Mosaik(Python) e OmNet++(C++) em containeres separados com comunicação via ZeroMQ e orquestração via Docker Compose, foram adicionados algumas melhorias:

### Incrementos 

**1. Sincronização de Passos (SYNC) entre Mosaik e OMNeT++:**

Foi implementado um contador explícito de passos (`mosaik_step`) no `MosaikBridge.cc`. A cada `handleMessage`, o OMNeT++ verifica se o campo `time` recebido do Mosaik coincide com o passo esperado internamente, emitindo um aviso de dessincronização caso haja divergência. O campo `time_resolution` (segundos por passo) passou a ser propagado do `init()` do wrapper até o OMNeT++, garantindo que o `scheduleAt(simTime() + time_resolution, stepMsg)` use o mesmo intervalo de tempo definido pelo Mosaik.

**2. Ciclo de Retroalimentação de Dados (Feedback Loop):**

No `main.py`, foi adicionada uma conexão de feedback do `node_0` (hub) de volta ao `Controlador` (Gerador de Tráfego), usando `time_shifted=True`. Esse parâmetro é obrigatório no Mosaik para ciclos de dados — sem ele, o framework rejeita a topologia com erro de causalidade. Com ele, o `data_out` do passo `t` chega ao Controlador no passo `t+1`, criando uma comunicação real.


Além disso, houve um estudo e compilação de exemplos do PADE atualizado, para habituar-se ao framework e posteriormente trabalhar com o mesmo. Tendo em vista esses estudos, foi possível incrementar no trabalho de co-simulação da professora Janaína a nova versão do PADE.


## 🛠 Contexto Técnico
- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X) Outra: C++ (OMNeTpp/INET)
- **Repositório no GitHub**: https://github.com/grei-ufc/tscc-com-opentes
- **Branch de Trabalho:** https://github.com/grei-ufc/tscc-com-opentes/tree/integration
- **Requisito Associado:** (Link para o artigo ou especificação técnica)

## ✅ Checklist de Entrega

- [X] Código documentado (Docstrings).
- [X] Testes unitários realizados.
- [X] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [X] Outros itens que não foram listados acima: Implementação de novas funções para de limite de pacotes, desincronização dos tempos e atualizações de dependências para o novo PADE na co-simulação da professora Janaína.

## 📈 Resultados / Dificuldades

- **Progresso atual:** 100% [████████] → 100%

- **Bloqueios:** Nenhum bloqueio significativo foi identificado durante.

## 📅 Prazo Estimado 

- Data de entrega pretendida: xx/03/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. Validar os resultados preliminares com o orientador.
- Passo 2. Incluir PADE na nossa co-simulação. 
