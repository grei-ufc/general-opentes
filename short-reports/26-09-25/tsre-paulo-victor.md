---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[PESQUISA]: Migração para Modelo Físico de EVs (Caldera ICM) e Pipeline de Baterias"
labels: pesquisa, software
assignees: "Paulo Victor"
---

## 📌 Descrição da Atividade

Este relatório documenta a evolução da modelagem de Veículos Elétricos (EVs) na co-simulação. O trabalho concentrou-se em substituir o modelo simplificado de injeção estática de potência por uma abordagem baseada na eletroquímica real de baterias, utilizando o motor **Caldera ICM**. 

O ciclo focou na elaboração conceitual da mudança (`docs/proposta_caldera_icm.md`), no equacionamento matemático para contornar a ausência de dados de estado de carga (SoC) na telemetria bruta e no versionamento da infraestrutura base da arquitetura. Atualmente, o esforço encontra-se na refatoração do orquestrador de dados (`pipeline_ev.py`) para gerar os parâmetros de estado temporal exigidos pelo novo microsserviço no Mosaik.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X) Outra: OpenDSS / Mosaik
- **Repositório no GitHub**: `grei-ufc/ev-charge-analysis-2026`
- **Branch de Trabalho:** `feature/caldera-icm-integration` e `main`
- **Requisitos Associados:** 
  1. Melhoria na fidelidade das perdas térmicas e elétricas reportadas pelo OpenDSS.
  2. Implementação do efeito de *tapering* (decaimento não-linear) nos perfis de carga noturnos.
  3. Tratamento matemático para inferência estocástica de SoC em sessões de *smart meters*.

## ✅ Checklist de Entrega

- [x] Versionamento inicial do ecossistema assíncrono de co-simulação (OpenDSS/Mosaik).
- [x] Documentação da proposta matemática e estrutural do Caldera ICM finalizada.
- [x] Criação da branch isolada `feature/caldera-icm-integration` com proteção de arquivos originais (`old/`).
- [x] README.md atualizado com a nova topologia de contêineres.
- [ ] Refatoração do `pipeline_ev.py` (algoritmo em andamento para extração do banco `ev_sessions_caldera.csv`).
- [ ] Adaptação do `Dockerfile` (inclusão de CMake/pybind11 para compilação C++ do Caldera).
- [ ] Construção do wrapper Mosaik (`caldera_ev_sim.py`).

## 📈 Resultados / Dificuldades

- **Progresso atual:** 15% [##--------] 100%

Detalhes técnicos, justificativas e metodologias matemáticas aplicadas na transição:

### 1. Transição de Modelo: Injeção Ideal vs Caldera ICM
* **O Problema do Modelo Estático:** A arquitetura base utilizava um modelo de injeção retangular (o EV drena a potência máxima nominal, como 3.6 kW, de forma ininterrupta e desliga abruptamente). Para a simulação, essa abordagem falha ao superestimar severamente os picos de demanda.
* **Adoção do Caldera ICM:** Para obter respostas físicas da rede, o simulador estático está sendo substituído pelo Caldera. Este motor simula a eletroquímica interna de células de íons de lítio e curvas de conversores CC-CV. Isso traz o efeito obrigatório do **tapering** (queda de potência quando o veículo atinge altas porcentagens de carga), diluindo o impacto na rede de baixa tensão e garantindo cálculos elétricos precisos.

### 2. Metodologia Híbrida para Cálculo do SoC Inicial
* **O Bloqueio dos Smart Meters:** O Caldera exige o Estado de Carga (SoC) inicial para iniciar a física da bateria. Contudo, bases reais possuem apenas os tempos de *plug-in*, *plug-out* e a energia gasta (kWh).
* **Solução Matemática (Engenharia Reversa):** Adotou-se o equacionamento algébrico proposto por *El-Hendawi et al. (2022)*, que retro-calcula o SoC inicial subtraindo a razão da energia gasta pela capacidade total da bateria, assumindo que cargas plenas chegam ao topo ($Target = 100\%$).
* **Filtro de Tempo Ocioso ($t_{idle}$):** Como a premissa acima falha para cargas rápidas diurnas, implementou-se um filtro de inatividade. Se $t_{idle} \approx 0$ (o veículo puxou potência máxima e foi desconectado antes de encher), o algoritmo descarta a equação matemática e injeta um SoC inicial estocástico baixo, forçando o Caldera a operar na fase de Corrente Constante (CC).

### 3. Encadeamento Temporal e Memória de Estado (Retro-propagação)
* **Preservação de Micro-sessões:** Bases reais possuem ruídos (usuário desconecta e reconecta o veículo em minutos). Tratar isso como duas sessões isoladas destruiria a rampa de decaimento físico.
* **Costura de Estado:** O algoritmo do novo pipeline varre os dados buscando conexões com $\Delta t \le 30 \text{ min}$. Ao encontrá-las, o código calcula matematicamente a última sessão primeiro e retro-propaga o SoC: o estado inicial da Sessão 2 torna-se, obrigatoriamente, o estado final travado da Sessão 1, preservando o histórico da bateria para o motor do Caldera.

## 📅 Prazo Estimado

- Data de entrega pretendida: 30/09/2026

## 📋 Planejamento para conclusão da entrega

- **Passo 1:** Concluir a codificação das regras de vizinhança e equações de $t_{idle}$ no script de dados para gerar a tabela limpa das sessões.
- **Passo 2:** Ajustar o ecossistema Docker para realizar a compilação nativa em C++ da biblioteca do laboratório de Idaho (INL).
- **Passo 3:** Desenvolver a API v3 do Mosaik para os veículos físicos e orquestrá-los dinamicamente no OpenDSS através do cenário principal.
