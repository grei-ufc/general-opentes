
---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:Utilize este template para documentar avanços em algoritmos, correções ou novas implementações.
title: "[OPENTES - ARGOS]: Unificação da Análise Elétrica com o Mapa de Rede e Implementação da Visualização D3"
labels: opentes, argos, pesquisa, software
assignees: "Luiz Alberto Silva Sales Marinho"
---


# [ARGOS - OpenTES]: Unificação da Análise Elétrica com o Mapa de Rede e Implementação da Visualização D3

---

## 📌 Descrição da Atividade

Durante esta semana foram realizadas melhorias na integração dos módulos da plataforma ARGOS, com foco na **unificação entre Mapa de Rede e Análise Elétrica**, na organização das medições associadas aos elementos da rede e na implementação de uma nova visualização interativa utilizando **D3/JavaScript**.

As principais atividades desenvolvidas foram:

* Consolidação da integração entre as páginas **Mapa de Rede** e **Análise Elétrica**, utilizando o barramento selecionado no grafo como referência para o Inspetor e para a análise temporal.

* Manutenção do fluxo de entrada baseado em **JSON da topologia + CSV dos resultados**, com validação do vínculo entre os arquivos por **hash SHA-256**.

* Criação do script independente `scripts/aplicar_hash_topologia.py` para calcular o SHA-256 do CSV e registrar o resultado em `metadata.results_sha256` no JSON.

* Reorganização visual do Mapa de Rede, posicionando o Inspetor abaixo do grafo e priorizando as informações relacionadas ao barramento selecionado.

* Reformulação do Inspetor utilizando cards específicos para tensões, ângulos, correntes, potências e equipamentos conectados.

* Organização conceitual das grandezas elétricas conforme o elemento ao qual pertencem, diferenciando medições de **barramentos, linhas e equipamentos**.

* Manutenção do cálculo da potência aparente `S` como grandeza derivada dos pares correspondentes de potência ativa `P` e reativa `Q` do próprio elemento.

* Atualização da leitura dos dados de **PVPanel, Inverter e PVSystem**, incorporando explicitamente o barramento aos padrões de identificação das variáveis.

* Separação dos cards de geração fotovoltaica em categorias específicas para potência DC, potência ativa e reativa AC, temperatura e irradiância.

* Implementação de estrutura para padronização dos rótulos e unidades apresentados ao usuário por meio de `configs/rotulos_medicoes.json`, `utils/rotulos_medicoes.py` e `utils/unidades.py`.

* Correção de textos e acentuação da interface para melhorar a apresentação da plataforma.

* Criação do **SavePoint 2**, preservando uma versão estável da plataforma antes das alterações relacionadas à integração mais intensa do D3/JavaScript.

* Desenvolvimento de uma nova alternativa de visualização da topologia utilizando **D3/JavaScript**, mantendo o Agraph disponível como opção.

* Implementação de diferentes modos de visualização das tensões no D3: **3 fases, Fase A, Fase B, Fase C, mínimo, máximo, média e spread**.

* Implementação de reprodução temporal local no navegador, permitindo acompanhar visualmente a evolução das tensões.

* Conversão da visualização D3 em um componente Streamlit próprio para permitir que o clique nos nós seja retornado à aplicação.

* Integração do nó selecionado no D3 ao `st.session_state["network_selected_node"]`, permitindo alimentar diretamente o Inspetor e a análise elétrica.

* Validação da classificação visual dos nós conforme os níveis de tensão.

* **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x ) OpenDSS | ( ) Excel | ( ) PowerBI | ( ) LaTeX | ( x ) VSCode | ( x ) JavaScript/D3

* **Repositório no GitHub:** ARGOS / OpenTES

* **Branch de Trabalho:** ARGOS

* **Requisito Associado:** Integração da análise elétrica à visualização topológica e aprimoramento da interação com os elementos da rede.

---

## ✅ Checklist de Entrega

* [x] Unificação entre Mapa de Rede e Análise Elétrica.
* [x] Validação JSON + CSV utilizando SHA-256.
* [x] Criação do script independente para aplicação do hash.
* [x] Reorganização visual do Mapa de Rede.
* [x] Reformulação dos cards do Inspetor.
* [x] Organização das grandezas por tipo de elemento elétrico.
* [x] Atualização da identificação de PVPanel, Inverter e PVSystem.
* [x] Padronização de rótulos e unidades.
* [x] Correção dos textos e acentuação da interface.
* [x] Criação de SavePoint do estado estável da plataforma.
* [x] Implementação da visualização D3/JavaScript.
* [x] Implementação de visualização das tensões por fase.
* [x] Implementação da reprodução temporal no D3.
* [x] Integração do clique no D3 com o Streamlit.
* [x] Validação das cores dos nós conforme nível de tensão.
* [ ] Validação completa da nova interface com diferentes casos de co-simulação.

---

## 📈 Resultados / Dificuldades

### Principais Resultados:

* Consolidação do **Mapa de Rede como ponto central da análise da plataforma**, reunindo topologia, seleção de barramentos, Inspetor e análise temporal.
* Maior consistência na associação das grandezas elétricas aos elementos correspondentes da rede.
* Maior segurança no carregamento dos dados através da validação do vínculo entre JSON e CSV por SHA-256.
* Melhor organização das informações dos sistemas fotovoltaicos, distinguindo painel, inversor e PVSystem.
* Padronização dos nomes e unidades apresentados ao usuário, reduzindo a exposição dos nomes brutos provenientes do CSV.
* Implementação de uma nova visualização D3 capaz de representar as tensões por fase e sua evolução temporal.
* Integração bidirecional entre o componente D3 e o Streamlit, permitindo utilizar o clique no grafo como mecanismo de seleção do barramento.
* Preservação do Agraph como alternativa de visualização durante o desenvolvimento.
* Criação de um ponto de retorno estável antes das alterações mais significativas no sistema de visualização.

### Dificuldades encontradas:

* O D3 inicialmente incorporado por `components.html` não retornava o nó selecionado para o Streamlit, exigindo sua transformação em um componente Streamlit próprio.

* Necessidade de reorganizar as grandezas para evitar que potências de linhas ou equipamentos fossem interpretadas como grandezas próprias dos barramentos.

* Adequação da leitura dos sistemas fotovoltaicos para associar explicitamente cada equipamento ao barramento correspondente.

* Tratamento das tensões iguais a `0.0` sem confundi-las com ausência de medição.

* Pequena variação das tensões do caso IEEE123 utilizado nos testes, fazendo com que a maioria dos nós com medição permanecesse visualmente na faixa verde durante a reprodução temporal.

* Ajustes no procedimento de inicialização do Streamlit no ambiente UV.

* **Progresso atual:** 97%

![Progress](https://progress-bar.xyz/97)

---

## 📎 Próxima(s) Atividade(s)

* Validar a nova visualização D3 com diferentes resultados de co-simulação.
* Refinar a interação entre o grafo, Inspetor e análise temporal.
* Expandir a associação automática para outros tipos de equipamentos da rede.
* Avaliar o comportamento visual das cores utilizando cenários com maiores variações de tensão.
* Aprimorar a reprodução temporal e os controles da visualização D3.
* Continuar a integração dos módulos da plataforma ARGOS em uma experiência única de análise.

---

## 📅 Prazo Estimado

* Data de entrega pretendida: 09/09/2026

---

## 📋 Planejamento para conclusão da entrega

1. Realizar testes completos do componente D3 com diferentes cenários.
2. Validar a seleção dos barramentos e atualização do Inspetor.
3. Verificar a associação das medições de linhas e equipamentos.
4. Validar os diferentes modos de representação das tensões.
5. Refinar a reprodução temporal e a interação do usuário com o grafo.
6. Consolidar a integração entre Mapa de Rede, Análise Elétrica e componentes de Qualidade de Energia.
7. Documentar a nova arquitetura e o fluxo de utilização da plataforma.
