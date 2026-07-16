# [ARGOS - OpenTES ]: Integração de Dados da Co-simulação ao Mapa de Rede e Visualização Temporal

---

## 📌 Descrição da Atividade

Durante esta semana foi desenvolvida uma nova etapa do módulo **Mapa de Rede** da plataforma ARGOS, permitindo integrar a topologia da rede elétrica aos resultados da co-simulação OpenDSS. O objetivo foi transformar a visualização da rede em uma ferramenta interativa capaz de representar o comportamento elétrico dos elementos ao longo do tempo.

As principais atividades realizadas foram:

- Implementação do carregamento simultâneo da topologia em formato **JSON** e dos resultados da co-simulação em **CSV**.
- Preservação da compatibilidade com o fluxo original de importação de circuitos OpenDSS compactados em **ZIP**.
- Desenvolvimento de um seletor temporal para navegação entre os **288 instantes** da simulação diária.
- Associação automática das tensões de fase **V1, V2 e V3** aos respectivos barramentos monitorados.
- Cálculo da tensão média em pu para cada barramento e exibição desse valor diretamente no rótulo dos nós monitorados.
- Implementação de classificação visual dos barramentos por nível de tensão, utilizando cores para indicar condições adequadas, precárias, críticas ou ausência de medição.
- Aprimoramento do inspetor de nós para apresentar informações detalhadas das medições, incluindo tensões por fase, tensão média, classificação operacional e conexões elétricas.
- Associação das medições de corrente, ângulo, potência ativa e potência reativa da linha **l115** à respectiva aresta da topologia.
- Integração das medições do sistema fotovoltaico, inversor e painel solar ao nó correspondente da rede.
- Desenvolvimento do inspetor de linhas para consulta das grandezas elétricas das arestas no instante selecionado.
- Preservação das informações originais de cada variável importada, incluindo nome da coluna, grupo, unidade, variável e valor.
- Implementação de um mecanismo para identificação de medições sem correspondência na topologia, evitando perda silenciosa de informações durante a importação.
- Criação de indicadores de cobertura para acompanhamento da qualidade da associação entre os dados da co-simulação e os elementos da rede.

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x ) OpenDSS | ( ) Excel | ( ) PowerBI | ( ) LaTeX | ( x ) VSCode
- **Repositório no GitHub:** ARGOS / OpenTES
- **Branch de Trabalho:** Desenvolvimento do módulo Mapa de Rede
- **Requisito Associado:** Integração entre a topologia da rede elétrica e os resultados das co-simulações.

---

## ✅ Checklist de Entrega

- [x] Integração da topologia JSON com resultados CSV.
- [x] Compatibilidade mantida com importação de circuitos ZIP.
- [x] Implementação da navegação temporal da simulação.
- [x] Associação automática das tensões aos barramentos.
- [x] Cálculo e exibição da tensão média em pu.
- [x] Classificação visual dos barramentos por nível de tensão.
- [x] Aprimoramento do inspetor de nós.
- [x] Associação das medições das linhas à topologia.
- [x] Integração dos dados do sistema fotovoltaico.
- [x] Implementação do inspetor de linhas.
- [x] Preservação dos metadados das variáveis importadas.
- [x] Identificação de medições não associadas.
- [x] Implementação dos indicadores de cobertura.

---

## 📈 Resultados / Dificuldades

### Principais Resultados:

- Evolução significativa do módulo Mapa de Rede, permitindo visualizar simultaneamente a topologia e os resultados da co-simulação.
- Integração temporal dos resultados elétricos, possibilitando acompanhar a evolução das grandezas ao longo dos 288 instantes da simulação.
- Melhor interpretação do estado operacional da rede por meio da classificação visual das tensões.
- Ampliação das informações disponíveis nos inspetores de nós e linhas, tornando a análise mais completa.
- Preservação integral das informações importadas dos arquivos CSV, garantindo rastreabilidade das variáveis.
- Criação de indicadores que permitem avaliar automaticamente a cobertura das associações entre medições e elementos da rede.

### Dificuldades encontradas:

- Estabelecimento da correspondência entre as variáveis da co-simulação e os elementos presentes na topologia.
- Tratamento de medições sem associação direta a nós ou arestas.
- Organização da estrutura de dados para suportar navegação temporal mantendo desempenho da interface.
- Compatibilização dos diferentes formatos de entrada (ZIP, JSON e CSV) em um fluxo único de processamento.

- **Progresso atual:** 95%

![Progress](https://progress-bar.xyz/95)

---

## 📎 Próxima(s) Atividade(s)

- Expandir a associação automática para todos os equipamentos monitorados da rede.
- Integrar animações temporais da evolução das grandezas elétricas.
- Implementar filtros para visualização por tipo de equipamento e variável.
- Adicionar novas métricas de qualidade de energia ao Mapa de Rede.
- Otimizar o desempenho da renderização para redes de maior porte.

---

## 📅 Prazo Estimado

- Data de entrega pretendida: 24/06/2026

---

## 📋 Planejamento para conclusão da entrega

1. Expandir a cobertura da associação automática das medições.
2. Implementar novas funcionalidades de análise temporal.
3. Integrar indicadores adicionais de qualidade de energia.
4. Validar o módulo com diferentes sistemas de teste.
5. Refinar a interface dos inspetores de nós e linhas.
6. Consolidar a documentação técnica do módulo Mapa de Rede.
