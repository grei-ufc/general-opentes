---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Estudo de implementação da plataforma Mkdocs para armazenar toda a documentação do `grei-ufc/co-simulation-opentes`. Organização de documentação, atualização do repositório, entre outros.
---

## 📌 Descrição da Atividade

Essa semana se concentrou em estudar a melhor viabilidade e modo de usar o MKdocs para documentar todo o repositório `grei-ufc/co-simulation-opentes`. Portanto, grande parte do tempo foi dedicado a separação de referências bibliográficas, guias, orientações, e exemplos, todos em formato .md para anexo na plataforma do Mkdocs.

## 🛠 Contexto Técnico

- **Repositório:** `grei-ufc/co-simulation-opentes`
- **Referência:** -
- **Ferramentas:** MkDocs, Markdown, LaTeX.

## ✅ Checklist de Entrega

- [ ] Plataforma associada MKDocs completa do projeto OpenTES
- [ ] Separação dedicada de cada seção, divisão por times/sistemas.


## 📊 Resultados / Dificuldades

- **Progresso atual:** 40%

![Progress](https://progress-bar.xyz/40/)

## 📝 Observações Técnicas

- **Topologia de rádio:** as redes próprias não tinham posição dos agentes, e sem
  ela o OMNeT++ entrega as mensagens sem atraso. A topologia foi gerada por código,
  com direções do diagrama unifilar e comprimentos reais das linhas. Todos os
  agentes ficaram alcançáveis em 100% de 400 sorteios de propagação.
- **Figuras:** duas correções no gerador. A rede da tese passou a ser reconhecida
  pelo nome da pasta, porque a BT38 também tem os nós 17 a 21. E o preço sombra
  negativo deixou de ser cortado na Figura 45.
- **Registros:** cada execução sobrescrevia o `run.json` da anterior; agora cada
  rede grava o seu.
- **Defeitos de registro identificados, ainda não corrigidos:** `deviation_kw`
  sai zerado quando o leilão abre, e as retransmissões do concentrador ficam fora
  da contagem.

## 🚀 Próximos passos

- Entrega da plataforma de documentação completa.

## 🎯 Conclusão

O MkDocs vai nos permitir consolidar a documentação dividindo-a em três grandes seções integradas. A primeira seção deve focar na Arquitetura e Integração, utilizando o arquivo já existente docs/INTEGRACAO.md como base para criar uma página dedicada que explique de forma visual o fluxo de dados (como o laço em que o OpenDSS resolve a tensão, o OMNeT++ simula o atraso de rede e o PADE aplica o controle Volt/Var). A segunda seção deve ser voltada para a Operação e Cenários, transformando o README.md principal e o docs/GUIA.md em manuais de início rápido, detalhando de forma clara os dois caminhos de execução (o ambiente em Docker Compose para simulação completa e o gerenciador uv para desenvolvimento Python local), além de documentar os scripts operacionais como o run.sh. A terceira seção deve mapear os Resultados e Experimentos, absorvendo os arquivos docs/RESULTADOS.md e o externo EXPERIMENTO_PERDA.md para criar páginas ricas que descrevam minuciosamente as colunas dos arquivos gerados na pasta output/ e expliquem o comportamento das curvas nos experimentos de sensibilidade.

Para o embelezamento visual e enriquecimento da experiência do usuário, o Material for MkDocs oferece recursos nativos que elevam drasticamente a qualidade dessa documentação técnica. O uso de Gráficos e Diagramas com Mermaid.js permite renderizar o fluxo causal do cenário integrado (OpenDSS ──► OMNeT++ ──► PADE) diretamente no navegador por meio de texto, eliminando imagens estáticas difíceis de atualizar. A extensão Admonitions (Notas e Avisos) deve ser aplicada para destacar alertas operacionais críticos, como o aviso de que os simuladores --remote do grid aceitam apenas uma única conexão e não devem ser sondados por TCP de readiness para não derrubar o container. Para a documentação de código e scripts, o recurso de Abas de Conteúdo (Content Tabs) torna a leitura limpa ao permitir que o usuário alterne no mesmo bloco entre as instruções de execução via Docker Compose ou via uv sync. Por fim, a ativação do Mecanismo de Busca Instantânea, tabelas de dados responsivas para mapear os cenários (integrated, market, star, ieee13) e a configuração de paletas de cores automáticas para modo claro e escuro garantem que pesquisadores e novos desenvolvedores naveguem pelo ecossistema de co-simulação com máxima eficiência e clareza visual.


