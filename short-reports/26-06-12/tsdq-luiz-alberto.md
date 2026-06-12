# [OPENTES - TSDQ ]: Reestruturação do Mapa de Rede, Integração OpenDSS e Evolução da Interface ARGOS

---

## 📌 Descrição da Atividade

Durante esta semana foram realizadas atividades voltadas para a evolução arquitetural da plataforma OpenTES-TSDQ e da interface ARGOS, com foco principal na visualização topológica da rede elétrica, melhoria da robustez da aplicação Streamlit e investigação de alternativas para visualização interativa da rede.

As principais atividades desenvolvidas foram:

- Análise da arquitetura atual do módulo "Mapa de Rede".
- Estudo da substituição do Cytoscape pelo WebVis utilizado no ecossistema Mosaik.
- Avaliação da viabilidade técnica de integração do WebVis à interface ARGOS/OpenTES.
- Levantamento da estrutura interna do projeto mosaik-web e análise dos requisitos de integração.
- Reformulação da estratégia de desenvolvimento do arquivo `3_Mapa_de_Rede.py`, considerando reconstrução do módulo a partir de uma nova arquitetura.
- Investigação dos problemas de estabilidade relacionados à movimentação dos nós da rede durante a visualização gráfica.
- Análise dos erros que causavam interrupções da aplicação após recompilações sucessivas do circuito.
- Diagnóstico do comportamento do OpenDSS durante o processo de recompilação da rede.
- Correções e ajustes relacionados ao carregamento de circuitos OpenDSS através do OpenDSSDirect.
- Revisão da estrutura de persistência dos dados utilizados na visualização topológica.
- Organização do ambiente de desenvolvimento para contribuição em repositórios GitHub através de Forks.
- Configuração de sincronização entre repositório original e fork de desenvolvimento.
- Ajustes no ambiente Python utilizando UV para gerenciamento de dependências.
- Atualização e sincronização das branches de desenvolvimento.
- Planejamento da integração futura entre os módulos de visualização elétrica, qualidade de energia e topologia da rede dentro da interface ARGOS.

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x ) OpenDSS | ( ) Excel | ( ) PowerBI | ( ) LaTeX | ( x ) VSCode
- **Repositório no GitHub**: OpenTES-TSDQ
- **Branch de Trabalho:** refatoração e modularização da interface
- **Requisito Associado:** Desenvolvimento da Interface ARGOS e do módulo de visualização topológica da rede elétrica.

---

## ✅ Checklist de Entrega

- [x] Estudo da arquitetura do Mapa de Rede.
- [x] Avaliação técnica do WebVis (Mosaik-Web).
- [x] Comparação entre Cytoscape e WebVis.
- [x] Definição da estratégia de reconstrução do módulo de topologia.
- [x] Investigação dos erros de recompilação do OpenDSS.
- [x] Correção de problemas relacionados ao carregamento da rede.
- [x] Revisão da estrutura de persistência dos dados da aplicação.
- [x] Configuração de ambiente utilizando UV.
- [x] Configuração de Fork e sincronização GitHub.
- [x] Atualização das branches de desenvolvimento.
- [ ] Testes completos de integração.
- [ ] Validação final da nova arquitetura do Mapa de Rede.

---

## 📈 Resultados / Dificuldades

### Principais Resultados:

- Definição de uma nova estratégia para evolução do módulo de visualização topológica.
- Identificação das limitações da implementação atual baseada em Cytoscape.
- Confirmação da viabilidade técnica de utilização do WebVis como alternativa futura.
- Melhor entendimento da arquitetura do Mosaik-Web e seu potencial de integração com o OpenTES.
- Diagnóstico dos principais pontos de instabilidade durante recompilações da rede.
- Aprimoramento do fluxo de desenvolvimento utilizando Forks no GitHub.
- Ambiente de desenvolvimento reorganizado e sincronizado.
- Base arquitetural preparada para continuidade da evolução da interface ARGOS.

### Dificuldades encontradas:

- Instabilidades durante a movimentação dinâmica dos nós da rede.
- Problemas de persistência de estado entre recompilações sucessivas do circuito.
- Complexidade de integração entre OpenDSS, Streamlit e componentes de visualização gráfica.
- Necessidade de reavaliar parte da arquitetura originalmente implementada para o módulo de topologia.
- Processo de adaptação do ambiente de desenvolvimento para o novo fluxo baseado em Forks.

- *Progresso atual:* 85%

![Progress](https://progress-bar.xyz/85)

---

## 📎 Próxima(s) Atividade(s)

- Iniciar reconstrução do módulo `3_Mapa_de_Rede.py`.
- Implementar nova arquitetura de visualização topológica.
- Avaliar integração prática do WebVis à interface ARGOS.
- Aprimorar persistência de estado da aplicação.
- Integrar visualização topológica aos módulos de qualidade de energia.
- Realizar testes de desempenho com circuitos de maior porte.

---

## 📅 Prazo Estimado

- Data de entrega pretendida: 12/06/2026

---

## 📋 Planejamento para conclusão da entrega

1. Finalizar definição da arquitetura do novo Mapa de Rede.
2. Implementar componentes de visualização modularizados.
3. Validar integração com OpenDSSDirect.
4. Realizar testes de estabilidade e desempenho.
5. Integrar funcionalidades à interface ARGOS.
6. Documentar a nova estrutura do sistema.
