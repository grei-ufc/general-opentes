---
name: "🚀 Relatório de Progresso / Nova tarefa"

about: |
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.

title: "[OPENTES - TSDQ]: Desenvolvimento do Mapa de Rede e Plotagem Topológica"

assignees: "[Luiz Alberto Silva Sales Marinho]"
---

## 📌 Descrição da Atividade

Desenvolvimento do módulo de visualização topológica da plataforma ARGOS para representação de redes elétricas modeladas em OpenDSS. As atividades envolveram o estudo da arquitetura do Mosaik WebVis, implementação da leitura de arquivos OpenDSS compactados (.zip), construção automática da topologia da rede e avaliação de alternativas para renderização interativa utilizando Cytoscape integrado ao Streamlit.

Foram realizados testes com diferentes modelos de rede visando validar a identificação de barramentos, linhas, transformadores e demais elementos do circuito, além da construção de versões simplificadas e completas do mapa de rede.

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x ) OpenDSS | ( ) Excel | ( ) LaTeX | ( x ) VSCode

- **Repositório no GitHub**: https://github.com/betomsales/tsdq-dataview-opentes.git

- **Branch de Trabalho:** refactor/modularizacao-streamlit

- **Requisito Associado:** Implementação do módulo de visualização topológica da rede elétrica para integração à plataforma ARGOS.

## ✅ Checklist de Entrega

- [x] Estudo da arquitetura e funcionamento do Mosaik WebVis.
- [x] Implementação inicial da extração da topologia a partir de arquivos OpenDSS.
- [x] Construção da visualização simplificada da rede.
- [x] Construção da visualização completa contendo todos os elementos identificados.
- [ ] Aplicação de coloração dinâmica baseada em grandezas elétricas.
- [ ] Integração temporal com resultados de simulação.

## 📈 Resultados / Dificuldades

### Principais Resultados

- Implementação da primeira versão funcional do mapa de rede.
- Construção automática do grafo elétrico a partir dos arquivos do circuito.
- Identificação e representação de barramentos e conexões elétricas.
- Definição da estrutura necessária para futuras funcionalidades de coloração e animação temporal.

### Dificuldades encontradas

- Dificuldade na reconstrução correta das conexões entre elementos OpenDSS.
- Inconsistências na identificação de terminais e barramentos durante o processamento dos arquivos DSS.
- Problemas de renderização em redes de maior porte devido ao elevado número de nós e arestas.
- Necessidade de adaptar conceitos originalmente implementados no Mosaik WebVis para a arquitetura do ARGOS.
- Reestruturar o interface para adaptar um visualização simplificada da rede e outra completa.

- **Progresso atual:** 75%

![Progress](https://progress-bar.xyz/75)

## 📎 Próxima(s) Atividade(s)

- Implementar coloração dinâmica dos elementos da rede utilizando dados elétricos provenientes das simulações.
- Integrar resultados temporais para atualização visual da topologia ao longo da simulação.
- Implementar persistência de estado para evitar perda da topologia durante interações do usuário.
- Desenvolver mecanismos de filtragem e navegação na rede.

## 📅 Prazo Estimado

- Data de entrega pretendida: 24/06/2026

## 📋 Planejamento para conclusão da entrega

1. Finalizar a estabilização da geração automática da topologia.
2. Implementar associação entre elementos da rede e resultados de simulação.
3. Desenvolver sistema de coloração baseado em tensão, corrente e carregamento.
4. Realizar testes com alimentadores de maior porte.
5. Integrar o módulo de visualização ao fluxo principal da plataforma ARGOS.
