---
name: "🚀 Relatório de Progresso / Nova tarefa"
about: "Utilize este template para documentar avanços em algoritmos, correções ou novas implementações."
title: "[OPENTES - ARGOS]: Estudo para Implementação de Relatórios na Interface"
labels: "opentes, argos, pesquisa, software"
assignees: "Luiz Alberto Silva Sales Marinho"
---

# [ARGOS - OpenTES]: Estudo e Planejamento da Geração de Relatórios pela Interface

---

## 📌 Descrição da Atividade

Durante esta semana foram realizadas atividades de estudo e levantamento técnico para a evolução da plataforma ARGOS, com foco na futura implementação de uma funcionalidade capaz de gerar relatórios a partir dos dados de simulação carregados na interface.

Como parte da fundamentação do desenvolvimento, foi realizada a leitura da dissertação **"Interface Gráfica para o Planejamento da Expansão da Transmissão de Energia Elétrica"**, buscando compreender referências relacionadas ao desenvolvimento de interfaces gráficas aplicadas a sistemas elétricos e identificar aspectos que possam contribuir para a evolução da plataforma ARGOS.

Paralelamente, foi realizado um estudo das possibilidades técnicas para disponibilizar uma saída em formato de relatório diretamente pela interface Streamlit.

As principais atividades desenvolvidas foram:

- Leitura e análise da dissertação **"Interface Gráfica para o Planejamento da Expansão da Transmissão de Energia Elétrica"** como referência para o desenvolvimento da interface.
- Estudo de diferentes estratégias para geração de relatórios a partir dos dados processados pela plataforma ARGOS.
- Avaliação da possibilidade de utilizar a própria interface Streamlit para apresentar uma versão visual do relatório.
- Levantamento de alternativas para exportação dos resultados para **HTML, PDF, DOCX e Markdown**.
- Análise do uso de HTML como etapa intermediária para geração de relatórios com gráficos, tabelas e demais elementos visuais da interface.
- Avaliação de bibliotecas para geração de PDF, incluindo **ReportLab, WeasyPrint, fpdf2 e Playwright/Chromium**.
- Avaliação do uso de `python-docx` para geração de documentos editáveis em formato DOCX.
- Análise do uso de Markdown como alternativa para geração de relatórios técnicos versionáveis.
- Estudo da utilização de um sistema baseado em **templates**, separando os dados processados, a estrutura do relatório e o formato final de exportação.
- Definição preliminar da estrutura que um relatório da simulação deverá apresentar.
- Definição das informações que devem ser registradas no relatório, incluindo arquivos de entrada, resumo da rede, nós monitorados, séries temporais, linhas, elementos fotovoltaicos, alertas e medições não associadas.
- Definição de um princípio de rastreabilidade para garantir que o relatório utilize exclusivamente os dados presentes nos arquivos de entrada.
- Definição de tratamento para informações ausentes, utilizando a indicação **"informação não disponível nos arquivos de entrada"** em vez de estimativas ou valores interpolados.

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x ) OpenDSS | ( ) Excel | ( ) PowerBI | ( ) LaTeX | ( x ) VSCode | ( x ) Streamlit
- **Repositório no GitHub:** ARGOS / OpenTES
- **Branch de Trabalho:** ARGOS
- **Requisito Associado:** Estudo e planejamento da implementação de geração e exportação de relatórios técnicos pela plataforma ARGOS.

---

## ✅ Checklist de Entrega

- [x] Leitura da dissertação utilizada como referência.
- [x] Levantamento das possibilidades de geração de relatórios.
- [x] Estudo da geração de relatório em HTML.
- [x] Estudo da geração de relatório em PDF.
- [x] Estudo da geração de relatório em DOCX.
- [x] Estudo da geração de relatório em Markdown.
- [x] Avaliação da utilização de templates.
- [x] Definição preliminar da estrutura do relatório.
- [x] Definição das informações que devem ser apresentadas.
- [x] Definição do princípio de utilização apenas dos dados disponíveis.
- [x] Definição do tratamento para informações ausentes.
- [ ] Implementação do gerador de relatório.
- [ ] Implementação da exportação para PDF.
- [ ] Validação do relatório com dados reais da plataforma.

---

## 📈 Resultados / Dificuldades

### Principais Resultados:

- Foi estabelecida uma base conceitual para a futura implementação de relatórios na plataforma ARGOS.
- Foram identificadas diferentes possibilidades de saída, permitindo avaliar a evolução da funcionalidade de acordo com a necessidade do projeto.
- O formato **HTML** foi identificado como uma possibilidade de integração direta com a interface, permitindo reutilizar elementos já existentes, como gráficos, tabelas e métricas.
- O formato **PDF** foi considerado como uma etapa posterior para disponibilizar uma versão mais adequada para documentação e entrega formal.
- Foi definida uma possível arquitetura baseada em **dados reais → template → relatório → exportação**, facilitando a manutenção e evolução da funcionalidade.
- Foi estabelecida uma estrutura preliminar para o relatório de simulação.
- Foi definido que o relatório deverá manter rastreabilidade dos dados utilizados, sem criação, interpolação ou estimativa de valores inexistentes nos arquivos de entrada.

### Dificuldades encontradas:

- Necessidade de avaliar qual formato de saída apresenta melhor integração com os componentes atualmente utilizados pela plataforma.
- Necessidade de preservar gráficos, tabelas e informações da interface durante a exportação.
- Diferenças entre os formatos de saída quanto à possibilidade de edição, visualização e versionamento.
- Necessidade de definir uma arquitetura que permita posteriormente adicionar novos tipos de relatório sem duplicar a lógica de processamento dos dados.

- **Progresso atual:** 70%

![Progress](https://progress-bar.xyz/70)

---

## 📎 Próxima(s) Atividade(s)

- Definir a estrutura final do relatório da simulação.
- Implementar uma primeira versão do relatório diretamente na interface Streamlit.
- Criar o template utilizado para organizar as informações.
- Integrar os dados da topologia e da co-simulação ao relatório.
- Incorporar tabelas e gráficos já disponíveis na plataforma.
- Implementar uma primeira opção de download do relatório.
- Avaliar posteriormente a conversão do relatório para PDF.

---

## 📅 Prazo Estimado

- Data de entrega pretendida: 25/09/2026

---

## 📋 Planejamento para conclusão da entrega

1. Definir o modelo visual e estrutural do relatório.
2. Separar os dados necessários para cada seção.
3. Criar o template do relatório.
4. Implementar a visualização do relatório na interface ARGOS.
5. Adicionar gráficos e tabelas gerados a partir dos dados disponíveis.
6. Implementar a exportação do relatório.
7. Validar o resultado utilizando arquivos reais de simulação.
8. Verificar a rastreabilidade das informações e o tratamento de dados ausentes.
