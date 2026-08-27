
# [ARGOS - OpenTES]: Integração entre Mapa de Rede e Análise Elétrica

---

## 📌 Descrição da Atividade

Durante esta semana foi iniciada a **unificação funcional entre os módulos Mapa de Rede e Análise Elétrica da plataforma ARGOS**, permitindo que a seleção de um barramento na topologia seja utilizada diretamente como referência para as análises elétricas e de qualidade de energia.

O desenvolvimento manteve o fluxo de entrada baseado no **JSON da topologia e CSV dos resultados da co-simulação**, adicionando validação de integridade por **hash SHA-256** antes da disponibilização dos dados na interface.

As principais atividades realizadas foram:

* Manutenção do carregamento conjunto do arquivo **JSON da topologia** e **CSV dos resultados**.

* Validação da correspondência entre os arquivos por meio do `results_sha256` armazenado no JSON e do hash SHA-256 calculado para o CSV.

* Bloqueio da visualização quando os arquivos não possuem hash válido ou apresentam incompatibilidade.

* Integração das funcionalidades da página **Análise Elétrica** ao **Mapa de Rede**.

* Sincronização do barramento selecionado no grafo com o Inspetor, Análise Temporal e indicadores de Qualidade de Energia.

* Implementação de seleção alternativa por meio do campo **Barramento analisado**.

* Reorganização da análise temporal de acordo com a entidade à qual cada medição pertence: barramento, linha, equipamento conectado ou grandeza derivada.

* Associação conceitual das tensões aos barramentos e das correntes e fluxos de potência às linhas.

* Separação das potências provenientes de PVSystem, inversor e painel fotovoltaico como grandezas dos respectivos equipamentos conectados.

* Implementação do cálculo da potência aparente `S` por fase a partir dos pares correspondentes de potência ativa `P` e reativa `Q`.

* Aprimoramento do Inspetor para diferenciar as potências dos equipamentos conectados dos fluxos de potência das linhas.

* Integração dos cards de Qualidade de Energia ao barramento selecionado no Mapa de Rede.

* Melhoria da identificação de variáveis com diferentes padrões de acentuação e codificação.

* Validação da estrutura utilizando os arquivos CSV e JSON de exemplo.

* **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x ) OpenDSS | ( ) Excel | ( ) PowerBI | ( ) LaTeX | ( x ) VSCode

* **Repositório no GitHub:** ARGOS / OpenTES

* **Branch de Trabalho:** ARGOS

* **Requisito Associado:** Integração da visualização topológica com os módulos de análise elétrica e qualidade de energia.

---

## ✅ Checklist de Entrega

* [x] Integração entre Mapa de Rede e Análise Elétrica.
* [x] Validação dos arquivos JSON e CSV por SHA-256.
* [x] Sincronização do barramento selecionado no grafo.
* [x] Organização das grandezas por entidade elétrica.
* [x] Separação entre grandezas de barra, linha e equipamentos.
* [x] Aprimoramento do Inspetor.
* [x] Integração dos cards de Qualidade de Energia.
* [x] Melhoria do reconhecimento das variáveis.
* [x] Validação de sintaxe dos módulos modificados.
* [x] Testes com arquivos CSV e JSON de exemplo.
* [ ] Validação visual completa da interface no Streamlit.

---

## 📈 Resultados / Dificuldades

### Principais Resultados:

* Unificação inicial dos módulos **Mapa de Rede** e **Análise Elétrica** em um fluxo de análise integrado.
* O barramento selecionado na topologia passou a atuar como elemento central das análises apresentadas pela interface.
* Maior clareza na associação das grandezas elétricas aos elementos físicos da rede.
* Diferenciação entre tensão do barramento, fluxo de potência das linhas e potência dos equipamentos conectados.
* Implementação da potência aparente `S` como grandeza derivada, calculada por fase a partir de `P` e `Q` do mesmo elemento.
* Integração dos indicadores de qualidade de energia ao elemento selecionado.
* Maior robustez na identificação das variáveis provenientes da co-simulação.

### Dificuldades encontradas:

* Garantir a correta associação das grandezas à entidade elétrica correspondente.

* Evitar que potências de linhas ou equipamentos fossem interpretadas como grandezas próprias dos barramentos.

* Compatibilizar diferentes padrões de nomenclatura, acentuação e codificação presentes nas variáveis.

* Necessidade de preservar a sincronização entre a seleção realizada no grafo e os demais componentes da interface.

* **Progresso atual:** 95%

![Progress](https://progress-bar.xyz/95)

---

## 📎 Próxima(s) Atividade(s)

* Refinar a sincronização entre seleção gráfica e análise elétrica.
* Realizar testes com diferentes arquivos de co-simulação.
* Consolidar a integração entre Mapa de Rede, Análise Elétrica e Qualidade de Energia.
* Estudar a viabilidade de apresentar valores de base e não somente em pu.
* Criar um indicador de posição do nó selecionado.

---

## 📅 Prazo Estimado

* Data de entrega pretendida: 02/09/2026

---

## 📋 Planejamento para conclusão da entrega

1. Validar visualmente a nova interface integrada.
2. Testar a seleção dos barramentos diretamente no grafo.
3. Validar as grandezas apresentadas para barras, linhas e equipamentos.
4. Verificar os cálculos derivados de potência aparente.
5. Testar os indicadores de qualidade de energia para diferentes barramentos.
6. Corrigir eventuais inconsistências e consolidar a integração dos módulos.
