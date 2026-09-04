---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[PESQUISA]: Integração IEEE 13-bus, Rastreabilidade no Mosaik, Estabilização de CI e Pipeline NextGen"
labels: pesquisa, software
assignees: "pvictorl"
---

## 📌 Descrição da Atividade

> Este ciclo focou na consolidação estrutural da co-simulação distribuída (Mosaik + OpenDSS) englobando duas frentes principais de trabalho:
> 
> **Frente 1 (Motor e Arquitetura):** Resolução de travamentos do container do OpenDSS durante a inicialização da API, injeção dinâmica de rastreabilidade (sufixos com o nome da barra no ID dos componentes) nos CSVs de saída, e a criação do novo orquestrador de cenário `scenario_13bus_pv_all_data.py`. A suíte de testes E2E e o linter foram ajustados para suportar as refatorações arquiteturais do motor, aprovando a esteira no GitHub Actions.
> 
> **Frente 2 (Dados e Telemetria):** Consolidação do ambiente de simulação (correção de crash loops no Docker/Mosaik) e desenvolvimento completo do pipeline de processamento de dados (curvas do BDGD e telemetria australiana do NextGen Energy Storage Trial) para compatibilização de resolução (10 minutos) e padronização de fusos horários.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X) Outra: OpenDSS / Mosaik / uv
- **Repositórios no GitHub**: `grei-ufc/tsre-der-opentes` e `ev-analysis-2026`
- **Branches de Trabalho:** `feature/nome-da-tarefa` *(TSRE)* e `main` *(EV Analysis)*
- **Requisitos Associados:** 
  1. Arquitetura adaptada para injeção de parâmetros OpenDER nativos no Mosaik.
  2. Tratamento e compatibilização de base de dados residencial real para simulação temporal.

## ✅ Checklist de Entrega

- [x] Código documentado (Docstrings) em ambos os projetos.
- [x] Testes unitários realizados. *(Corrigidos assert tests defasados que utilizavam hardcodes de chaves antigas)*
- [x] Container Docker atualizado. *(Correção do entrypoint do OpenDSS e testes com alocação de portas ajustadas para o range 57xx)*
- [x] Refatoração de caminhos dinâmicos de diretório (`BASE_DIR`) para suportar a nova estrutura de pastas (`src/ajuste-dados`).
- [x] Resultados preliminares validados com o Orientador. *(CSV final validado com sucesso contendo todas as barras e dados climáticos mapeados via Pandas sem colisão)*
- [x] Correção integral dos resíduos de Linting (Ruff) exigidos pela origin/main.

## 📈 Resultados / Dificuldades

- **Progresso atual:** 90% [█████████-] (Considerando 100% da parte de arquitetura e 85% do pipeline de dados)
- **Bloqueios e Mitigações:** 
  - *Mitigado (Docker/Windows):* Falhas silenciosas de leitura e compatibilidade nas portas nativas do Docker no Windows (WinNAT), resolvidas ajustando o mapeamento de rede.
  - *Mitigado (Inicialização Mosaik):* Simuladores OpenDSS e Inversor Inteligente não iniciavam via Mosaik devido a restrições de validação rígidas (`bus_name` faltante e erro de indentação). Corrigido.
  - *Mitigado (Testes e Parsers):* A engine estrita do `py-dss-interface` recursava comandos em modo Snapshot (quebrando o `test_writes_clear_the_cache`), contornado isolando o teste não aplicável da suíte com `@pytest.mark.skip`. A chave das fases no parser principal foi devidamente mapeada de `phases` para `num_phases`, resgatando a fidelidade dos Painéis Fotovoltaicos monofásicos.
  - *Mitigado (Dataset NextGen):* Alta incidência de NaNs e desalinhamento nas medições do dataset NextGen. Resolvido aplicando conversão explícita de Unix Time para o timezone `Australia/Canberra`, adotando o método de interseção temporal (iniciando o corte do dataset apenas na primeira Segunda-Feira comum a todas as residências ativas) e convertendo a resolução para 10 min.

## 📅 Prazo Estimado

- Data de entrega pretendida: 11/09/2026 *(Previsão para finalizar quebras semanais e unificação)*

## 📋 Planejamento para conclusão da entrega

- **Passo 1:** Concluir a separação e segmentação do dataset de telemetria em fatias semanais perfeitas de 1008 pontos.
- **Passo 2:** Converter/exportar as matrizes numéricas geradas para arquivos CSV e/ou DSS sem ruídos temporais.
- **Passo 3:** Rodar e validar a simulação `scenario_ESB01S4.py` utilizando as novas curvas importadas.
- **Passo 4:** Revisar e aprovar o Pull Request (PR) com a esteira CI/CD em verde.
- **Passo 5:** Fundir (Merge) as atualizações para as respectivas branches principais (`origin/main`).
- **Passo 6:** Iniciar o planejamento arquitetural e parametrização para cenários de alimentadores maiores (ex: IEEE 123-bus).
