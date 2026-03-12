---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[OPENTES - TSCC] Desenvolvimento de aplicação de simulação e co-simulação em ambientes conteinerizados"
labels: pesquisa, software
assignees: "[Laiza Edwigens Rocha Silva e Rafael Moura Sousa]"
---

## 📌 Descrição da Atividade
Conclusão da implementação de co-simulação entre MOSAIK (Python) e OMNeT++ (C++) em containers Docker separados, com comunicação via ZeroMQ e orquestração via Docker Compose.

A partir das abordagens paralelas desenvolvidas pela equipe (Laiza: containerização do COSIMA+OMNeT; Rafael: container MOSAIK separado e comunicação), consolidamos uma solução funcional onde:

1. O MOSAIK em um container envia comandos de criação de cenário
2. O OMNeT++ em outro contêiner instancia dinamicamente os nós de rede
3. A comunicação ocorre via sockets ZMQ na porta 5555
4. Dados são injetados em tempo real (`15.0` no `data_in` do `node_0`)
5. Resultados são coletados e salvos em `results.csv`
Tal estrutura está visualmente representada na figura abaixo:

<div align="center">
  <img src="Images/esquematico.jpeg" alt="Arquitetura Mosaik e OMNeT" width="700">
  <p><i>Figura: Arquitetura de Co-Simulação Mosaik-OMNeT.</i></p>
</div>


Válido ressaltar também para fins de documentação, o prosseguimento das abordagens realizadas:

| Abordagem | Descrição |
|-----------|-----------|
| **1. Container Único COSIMA+OMNeT + MOSAIK separado** | Construção de um container com COSIMA e OMNeT++ integrados, comunicando-se com outro container MOSAIK via Docker Compose | 
| **2. Container COSIMA existente + Novo container MOSAIK** | Utilização do container COSIMA já construído, criação de novo container MOSAIK, foco na comunicação entre eles | 
| **3. Containers separados OMNeT e MOSAIK** | Construção de containers independentes para OMNeT++ (puro) e MOSAIK, com comunicação via ZMQ | 

Observações sobre cada abordagem:

| Abordagem | Aprendizados | Desafios |
|-----------|--------------|----------|
| **1** | Estrutura do COSIMA, dependências OMNeT++, Dockerfiles | Complexidade do COSIMA, tempo de compilação |
| **2** | Comunicação entre containers, variáveis de ambiente | Portas conflitantes dentro do COSIMA |
| **3** | ZMQ, criação dinâmica de nós, sincronização lock-step | Sucesso |

## 🛠 Contexto Técnico
- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X)
  Outra: C++ (OMNeTpp/INET)
- **Repositório no GitHub**: https://github.com/grei-ufc/tscc-com-opentes
- **Branch de Trabalho:** https://github.com/grei-ufc/tscc-com-opentes/tree/integration
- **Requisito Associado:** (Link para o artigo ou especificação técnica)

## ✅ Checklist de Entrega

- [ ] Código documentado (Docstrings).
- [X] Testes unitários realizados.
- [X] Container Docker atualizado (se aplicável).
- [ ] Resultados preliminares validados com o Orientador.
- [ ] Outros itens que não foram listados acima: 

## 📈 Resultados / Dificuldades
O arquivo `results.csv` gerado confirma o funcionamento da co-simulação:

| Tempo | node_0.data_out | node_1.data_out | Status |
|-------|-----------------|-----------------|--------|
| 0 | 0.0 | 0.0 | active |
| 1 | 1.0 | 0.0 | active |
| 2 | 2.0 | 0.0 | active |
| ... | ... | ... | ... |
| 9 | 9.0 | 0.0 | active |

Observação: interpretação dos resultados

O MOSAIK injetou o valor `15.0` no `data_in` do `node_0`;
O OMNeT processou este valor, gerando um pacote a cada passo de simulação;
O contador `data_out` foi incrementado de 0 a 9, conforme esperado;
O `node_1` permaneceu com `data_out = 0.0` (não recebeu injeção direta);
Ambos os nós mantiveram status "active" durante toda simulação

- **Progresso atual:** 100% [████████] → 100%
  
- **Bloqueios:**

## 📅 Prazo Estimado 

- Data de entrega pretendida: /03/2026

## 📋 Planejamento para conclusão da entrega

- Passo 1. 
- Passo 2. 
