---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Consolidação da documentação do `grei-ufc/co-simulation-opentes` em uma
  plataforma MkDocs com Material for MkDocs, precedida da revisão e da
  atualização dos documentos que o repositório já mantinha.
---

## 📌 Descrição da Atividade

A semana teve duas frentes. A primeira foi rever os documentos que o repositório
já tinha (`README.md`, `docs/GUIA.md`, `docs/INTEGRACAO.md`,
`docs/RESULTADOS.md` e `docs/MERCADO.md`). Cada número foi conferido contra o
código e contra as execuções gravadas em `output/`, porque conferir contra a
versão anterior do próprio texto apenas propaga o erro que já estava lá. A
segunda frente foi montar o site em MkDocs com o tema Material, reunindo esses
documentos numa navegação única e escrevendo as páginas que faltavam para quem
abre o repositório sem contexto.

A revisão veio antes de propósito. Publicar a documentação velha num site novo
daria alcance maior a números que não correspondem mais ao código.

## 🛠 Contexto Técnico

- **Repositório:** `grei-ufc/co-simulation-opentes`
- **Referência:** manual de marca do GREI (paleta e tipografia); perfil de
  tensão publicado do *IEEE 13 Node Test Feeder*
- **Ferramentas:** MkDocs 1.6.1, Material for MkDocs 9.7.7, Markdown, Mermaid,
  Docker, OpenDSS

## ✅ Checklist de Entrega

- [x] Site MkDocs com Material montado, compilando sem nenhum aviso em modo
      `--strict`
- [x] Revisão dos cinco documentos existentes contra o código e as execuções
- [x] Identidade visual do GREI aplicada: paleta, tipografia, marca e favicon
- [x] Três páginas novas (capa, instalação e execução, cenários e experimentos)
- [ ] Publicação do site e commit no repositório remoto
- [ ] Páginas dedicadas por simulador, detalhando cada bloco por dentro

## 📊 Resultados / Dificuldades

A navegação ficou em quatro seções: a capa; Começar, com a instalação pelos dois
caminhos, Docker e `uv`, mais os cenários e as variáveis de ambiente; A
plataforma, com o mapa do repositório, o registro da integração componente a
componente e o guia da pasta `output/`; e Mercado transativo, com a formulação e
as decisões medidas do caso IEEE 13. Os quatro documentos antigos continuaram
nos mesmos caminhos, para não quebrar os links que já existem no repositório. A
navegação os agrupa sem movê-los.

<img width="1920" height="900" alt="image" src="https://github.com/user-attachments/assets/83f9dada-b452-4812-9681-6048a5615a2b" />

<img width="1920" height="900" alt="image" src="https://github.com/user-attachments/assets/f41c7c4c-5b2b-4cd1-9f49-2035fa5eedeb" />

<img width="1920" height="900" alt="image" src="https://github.com/user-attachments/assets/16490c45-c751-4606-a797-68c95f96b9eb" />

<img width="1920" height="900" alt="image" src="https://github.com/user-attachments/assets/b571f6d2-bc29-45ff-bb3f-644facf23c57" />

Modo claro:
<img width="1920" height="900" alt="image" src="https://github.com/user-attachments/assets/f55292e6-372b-458e-8c7e-2f9aa699e290" />


A ferramenta deu pouco trabalho. O tempo foi para a distância entre o que a
documentação afirmava e o que o código faz hoje: quatro afirmações estavam
erradas, e o levantamento está na seção seguinte, junto com um registro obsoleto
e a dívida de documentação que sobra.

## 📝 Observações Técnicas

- **Validação do bloco elétrico:** três documentos afirmavam que o cenário
  `ieee13` reproduzia "exatamente" os valores publicados pelo TSRE (`P_dc`
  3024,6 / `P_ac` 2854,2 / `P_meas` 1902,7 kW). Isso deixou de valer quando a
  temperatura do módulo passou a ser gravada em graus Celsius e o PV1 foi
  corrigido de trifásico para bifásico na barra 646. A referência agora é o
  perfil de tensão publicado do IEEE 13, que o circuito reproduz com erro médio
  de 0,00044 pu e máximo de 0,00134 pu nas 33 medidas de fase da tabela oficial.
- **Saída gravada contra a documentação:** o
  `output/ieee13/result_run_ieee13_cosim_pv_5min.csv` era de 6 de agosto,
  anterior à correção da temperatura. O cenário foi rodado de novo: pico agregado
  de 4.030,4 kW e `P_meas` acompanhando `P_ac` no PV1, como esperado depois da
  correção de fase.
- **`MARKET_V_BACKOFF`:** documentado como `2e-3` no `GUIA.md` e no `MERCADO.md`.
  O padrão do código é `1e-3` desde o commit `b0cbb34`.
- **Caso principal do mercado:** o `MERCADO.md` ainda dizia que seria o IEEE
  European LV Test Feeder, "ainda não montado". É o IEEE 13, montado pelo
  `gen_ieee13_market.py` e medido.
- **Registro obsoleto:** o `output/market_13Bus/run.json` tem 75 rodadas e é de
  10 de setembro, enquanto o registro válido tem 81 rodadas e fica em
  `simulators/market-opentes/data/run_13Bus/`. A documentação foi apontada para o
  lugar certo. O arquivo antigo continua lá, para decisão do grupo.
- **Dívida de documentação:** não há página por simulador explicando o bloco por
  dentro, e o `comm-opentes` em C++ é o caso mais sentido. Os `README.md` de cada
  pasta de simulador também ainda não entraram na navegação do site.

## 🚀 Próximos passos

- Escrita do Resumo para o SNPTEE.
- Escrita do Relatório Final do Time TTESO.

## 🎯 Conclusão

Gerar o conteúdo a partir dos arquivos que já existiam evitou duplicação. A
página de decisões medidas do IEEE 13 inclui o `estudos/ieee13/README.md` por
*snippet*, então a pasta e o site não divergem.

Os recursos do tema entraram onde resolvem um problema concreto. O Mermaid
desenha o laço causal do cenário integrado (o OpenDSS resolve a tensão, o
OMNeT++ aplica atraso, jitter e perda, o PADE decide P e Q, o OpenDSS recalcula)
em texto versionável, o que tira do repositório uma figura estática que
envelheceria em silêncio. As *admonitions* isolam os avisos operacionais que já
custaram tempo ao grupo: os simuladores `--remote` do grid aceitam uma única
conexão e morrem se forem sondados por TCP de prontidão, e o contêiner do
OpenDSS quebra com `--user`. As abas de conteúdo deixam Docker e `uv` no mesmo
bloco, sem repetir a página inteira por caminho de execução. O site também tem
busca instantânea em português, tabelas responsivas nos cenários e paletas de
tema claro e escuro.

A identidade visual saiu do manual de marca: verde `#2F5E4B` e creme `#F4FFEB`,
confirmados por amostragem do PDF, com Exo 2 nos títulos e Poppins no texto, e a
marca extraída em três tamanhos, para cabeçalho, capa e favicon.

Na prática, a informação sobre a plataforma deixou de depender de quem a
produziu. Quem chega escolhe um cenário e sabe onde conferir cada número.
