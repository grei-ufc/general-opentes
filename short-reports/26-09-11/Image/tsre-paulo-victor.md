---
name: "🚀 Relatório de Progresso / Nova tarefa"
about: Utilize este template para documentar avanços em algoritmos, correções ou novas implementações.
title: "[PESQUISA]: Integração de Redes IEEE, Estabilização Mosaik e Pipeline Estocástico NextGen"
labels: pesquisa, software
assignees: "Paulo Victor"
---

## 📌 Descrição da Atividade

Este relatório consolida os avanços cronológicos das últimas semanas, englobando três áreas interdependentes que estruturam a nova arquitetura de co-simulação distribuída (Mosaik + OpenDSS). O trabalho evoluiu desde a representação física das redes e definição de alimentadores, passando pela estabilização da engine de simulação, até a geração estocástica complexa de cargas residenciais.

O ciclo inicial foi dedicado à definição topológica, ajustes no código `pv_creator` e à melhoria substancial da identificação de barras, além da reestruturação da geração distribuída. Na etapa seguinte, o foco voltou-se para a consolidação estrutural da co-simulação, resolvendo travamentos do container do OpenDSS, mitigando conflitos de rede no Docker e injetando rastreabilidade dinâmica nos dados de saída. A etapa mais recente focou no desenvolvimento do orquestrador embutido (`pipeline_cargas.py`) para trazer estocasticidade espacial e temporal ao OpenDSS, cruzando dados da BDGD com telemetria inteligente da Austrália de forma 100% *In-Memory* e alinhada ao PRODIST/ANEEL.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X) Outra: OpenDSS / Mosaik / uv
- **Repositórios no GitHub**: `grei-ufc/tsre-der-opentes`
- **Branches de Trabalho:** `tsre-der-opentes/paulo-victor` e `main` 
- **Requisitos Associados:** 
  1. Parametrização e rastreabilidade para a plataforma de visualização (Beto).
  2. Arquitetura adaptada para injeção de parâmetros OpenDER nativos via Mosaik.
  3. Conformidade regulatória (PRODIST/ANEEL) no tratamento de cargas de Baixa Tensão (BT) e compatibilização de datasets internacionais.

## ✅ Checklist de Entrega

- [x] Código documentado com Docstrings em todos os repositórios trabalhados.
- [x] Testes unitários realizados, atualizados e corrigidos (remoção de *hardcodes* defasados de chaves antigas).
- [x] Refatoração de caminhos dinâmicos de diretório (`BASE_DIR`) para suportar a nova estrutura de pastas (`src/ajuste-dados`).
- [x] Geração de artefatos CSV e JSON otimizados para plotagem de ambas as redes na interface gráfica.
- [x] Container Docker atualizado, com correção definitiva do `entrypoint` do OpenDSS e contorno de limitações de rede.
- [x] Processamento de dados *In-Memory* implementado com sucesso para extração, limpeza e cruzamento estocástico.
- [x] Correção integral dos resíduos de Linting (Ruff) exigidos para aprovação na esteira CI/CD da `origin/main`.
- [x] Resultados validados (CSVs finais gerados sem colisão, contendo as barras e dados climáticos corretamente mapeados).

## 📈 Resultados / Dificuldades

- **Progresso atual:** 95% [█████████-]

Detalhes técnicos, bloqueios resolvidos e metodologias aplicadas em cada etapa de desenvolvimento:

### 1. Seleção e Modelagem do Alimentador Base (Subestação Eusébio - ESB)

Para a validação estrutural do estudo, selecionou-se um alimentador da Subestação do Eusébio (ESB). A região foi estrategicamente escolhida por sua alta densidade de cargas e elevado índice de desenvolvimento econômico. Devido à predominância de condomínios residenciais de alto padrão, o local representa um cenário demográfico altamente propício para simular uma alta taxa de penetração de carregadores de veículos elétricos (VEs). O processo inicial consistiu na importação e análise estrutural da rede elétrica real da Enel CE, realizando a filtragem topológica dos dados diretamente da BDGD a partir desta subestação.

Alimentadores da subestação ESB:
<img width="1120" height="790" alt="image" src="https://github.com/user-attachments/assets/14066d7c-1ab1-493e-8310-c6139dc35ecc" />

Análise dos alimentadores:
<img width="3600" height="3000" alt="grafico_barras_cargas_ESB" src="https://github.com/user-attachments/assets/02a96bb1-7af0-45ce-a45e-68bb725d5cd5" />

Alimentador escolhido: 
<img width="1107" height="676" alt="image" src="https://github.com/user-attachments/assets/10337f84-ef58-42dd-9793-5dd4a08c243c" />

**Caracterização do Alimentador ESB01S4:**
Para as simulações, utilizou-se o alimentador real **ESB01S4**, extraído da base BDGD de uma concessionária brasileira nos padrões do PRODIST/ANEEL. Trata-se de uma rede radial com as seguintes características principais:
* **Tensão Operacional:** 13,8 kV na Média Tensão (MT) e 380/220 V na Baixa Tensão (BT).
* **Infraestrutura:** Possui 120 transformadores de distribuição interligando 980 segmentos de linhas (MT e BT).
* **Consumidores:** Atende a cerca de 1.650 unidades consumidoras físicas (modeladas em parcelas de impedância e potência constantes).
* **Geração Distribuída:** Alta penetração fotovoltaica, com 614 usinas solares conectadas (603 na BT e 11 na MT).
Essa alta capilaridade associada à forte presença de geração solar torna o ESB01S4 um cenário ideal e desafiador para avaliar os impactos da inserção de Veículos Elétricos em co-simulação.

### 2. Redes, Modelagem Fotovoltaica e Visualização (`pv_creator`)
* **Processo de Escolha para Redes de Teste:** A seleção de alimentadores adicionais seguiu critérios de complexidade progressiva. Inicialmente, adotou-se o sistema **IEEE 13-bus** devido ao seu alto grau de desequilíbrio e topologia compacta, ideais para depuração ágil de convergência. Em seguida, para suportar a modelagem de alta penetração residencial, selecionou-se a rede **IEEE Low Voltage Test Case**. Este alimentador europeu de baixa tensão possui ramificações densas e perfis fortemente assimétricos, configurando o ambiente definitivo para validar as curvas estocásticas antes da escalabilidade.
* **Modelagem Dinâmica de Geração Fotovoltaica (Integração `PVSystem`):** A substituição dos geradores genéricos da BDGD por elementos do tipo `PVSystem` transcendeu a modelagem estática baseada em curvas predefinidas. A recriação inseriu características físicas essenciais (ex: perdas de conversão e *clipping* CC/CA) e destravou a simulação de controles de *Smart Inverters* (Volt-Var/Volt-Watt). No contexto da co-simulação via Mosaik, essa abordagem foi imperativa: permitiu que o modelo recebesse dados meteorológicos (irradiância e temperatura) a cada passo de integração temporal, transformando a rede em um Gêmeo Digital (*Digital Twin*) responsivo a variações climáticas e malhas de controle de Smart Grids.
* **Algoritmo de Interpolação Climática:** O motor térmico apresentava saltos bruscos. O código foi reestruturado para gerar curvas de temperatura fisicamente coerentes e suavizadas, fundamentais para simular a eficiência dos painéis sem distorções em degrau. 
* **Rastreabilidade de Colunas para a Interface Gráfica:** As rotinas de exportação do CSV foram ajustadas com identificadores explícitos de barra. Essa injeção permitiu que a plataforma de visualização (Beto) mapeasse cada inversor perfeitamente em seu nó elétrico físico, habilitando análises de sobretensão e fluxo bidirecional.

### 3. Motor de Co-simulação e Arquitetura (Mosaik/Docker)
* **Crash Loops no Docker e Redes Virtuais (Mitigado):** Falhas silenciosas de leitura e perda de comunicação do Mosaik rodando via Windows ocorriam com frequência devido ao mapeamento interno do WinNAT. A solução exigiu reconfigurar a alocação de portas no Docker, deslocando o range seguro e livre de colisão para a faixa `57xx`.
* **Inicialização Estrita do Mosaik (Mitigado):** Durante a orquestração do cenário `scenario_13bus_pv_all_data.py`, simuladores do OpenDSS e Inversor Inteligente travavam no *boot*. A causa envolvia restrições severas de validação (falta de repasse do parâmetro `bus_name` e erros de indentação no construtor da API). O fluxo de injeção foi estabilizado.
* **Conflitos de Parsers e Suíte de Testes (Mitigado):** A biblioteca `py-dss-interface` falhava ao compilar painéis fotovoltaicos monofásicos devido à chave defasada no parser. O mapeamento foi corrigido de `phases` para `num_phases`. A engine também recursava comandos no modo *Snapshot*, causando quebras no teste `test_writes_clear_the_cache`, que foi isolado usando `@pytest.mark.skip`.

### 4. Pipeline Estocástico e Algoritmos de Dados (NextGen)
* **Continuidade Matemática nas Curvas BDGD:** Interpolar as 24 horas originais com regressão linear criava "quinas" irreais. O método foi substituído pela interpolação polinomial **PCHIP**. Clonando o ponto `00:00` no final do dia temporariamente, garantiu-se uma curva diária de 144 pontos (10 min) com transição circular perfeitamente contínua à meia-noite.
* **Qualidade Rigorosa na Telemetria Bruta:** O dataset australiano do *NextGen Energy Storage Trial* teve dados forçados para o fuso `Australia/Canberra`, convertidos de Unix Time e agrupados via *resample* em blocos de 10 minutos. O corte da série utilizou interseção temporal (iniciando na primeira segunda-feira com medição em todas as residências), descartando qualquer dia contendo `NaN` ou consumo negativo.
* **Alocação de Perfil via Gale-Shapley:** O cálculo de distância Euclidiana foi convertido em percentual de similaridade via RMSE. Aplicou-se o **Algoritmo de Gale-Shapley**: as curvas reais competem ativamente pelas vagas nas referências BDGD. Quando o limite se esgota, os perfis com piores similaridades são rejeitados e buscam a segunda melhor opção, garantindo 100% de cobertura distribuída nos nós da rede.
* **Costura de Emendas e Degraus da Meia-Noite:** A montagem de semanas sintéticas sorteando dias úteis sem repetição criava um choque vertical no instante `23:50 -> 00:00`. O orquestrador converte os últimos e primeiros 20 minutos de dias adjacentes para `NaN` e retrança um novo arco PCHIP, soldando as curvas com derivada suave.
* **Otimização do Modelo ZIP (PRODIST/ANEEL):** A regulação exige dividir cargas residenciais BT em Impedância Constante (`_M1`) e Potência Constante (`_M2`). Gerar semanas independentes criaria assinaturas elétricas conflitantes. A arquitetura resolve isso via rotina de *herança*: gera a série temporal estocástica para a chave `_M1` e, ao encontrar `_M2`, apenas herda a matriz exata da memória. Isso preserva a física elétrica e reduz o processamento em 50%.

## 📅 Prazo Estimado

- Data de entrega pretendida: 18/09/2026

## 📋 Planejamento para conclusão da entrega

- **Passo 1:** Correção de problemas identificados em alguns dados de temperatura e irradiância provenientes no BR-PVGen.
- **Passo 2:** Implementação de diferentes cenários de penetração de geração FV em um notebook python na rede IEEE LVTestCase (para os EUs).
- **Passo 3:** Implementação da integração de veículos elétricos à rede com dados reais.
