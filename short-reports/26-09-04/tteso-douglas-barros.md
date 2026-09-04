---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Porte do mercado transativo para a IEEE 13 barras, com o Agente Concentrador
  adequado a uma rede de um único transformador de distribuição.
title: "[OpenTES / TTESO]: IEEE 13 barras, porte do mercado e adequação do Concentrador"
labels: software, pesquisa, mercado-transativo
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

Com a MVLV75 fechada, a semana foi de **portar a camada de mercado para a IEEE 13
barras**. Não é troca de arquivo: a arquitetura de quatro papéis da tese pressupõe
uma rede com vários transformadores de distribuição, e a IEEE 13 tem um só. Foi
essa adequação que ocupou a semana, junto com a validação do circuito contra o
modelo publicado.

## 🛠 Contexto Técnico

- **Repositório:** `douglas-fdbs/co-simulation-opentes`, branch `mercado-transativo`
- **Referências:** MELO, L. S. Tese, UFC, 2022; *IEEE 13 Node Test Feeder*,
  Distribution System Analysis Subcommittee (tabelas de linha, carga, trafo,
  capacitor, regulador e perfil de tensão publicado)
- **Ferramentas:** PADE 3.0, Mosaik 3.5, OMNeT++, OpenDSS, Pyomo com CPLEX

## ✅ Checklist de Entrega

- [x] Circuito da IEEE 13 validado contra o perfil de tensão publicado
- [x] Um defeito de modelagem do PV corrigido, confirmado na documentação oficial
- [x] Ajuste do regulador escolhido e justificado por medição
- [x] Agente Concentrador adequado à rede de um transformador
- [x] Caso de mercado gerado por código a partir do circuito compilado
- [x] Negociação rodando e convergindo sobre a IEEE 13
- [x] As 18 figuras adaptadas, em pasta própria
- [ ] Sequenciamento do regulador na fase de operação

## 📊 Resultados / Dificuldades

- **Progresso atual:** 92%

![Progress](https://progress-bar.xyz/92/)

**O circuito reproduz o modelo de referência.** Fixando as derivações do regulador
nos valores publicados (10, 8, 11), o erro contra o perfil de tensão oficial é de
**0,00044 pu em média e 0,00134 pu no máximo**, nas 14 barras e 33 medidas de fase
da tabela. Essa validação só foi possível depois de corrigir um defeito: o
`PVSystem.PV1`, de 5 MW, estava declarado como trifásico na barra 646, que é
bifásica. A configuração 603, do ramal `632-645-646`, tem faseamento "C B N", e o
perfil publicado mostra 645 e 646 sem fase A. **37% da potência do PV1 era
injetada num nó que não conduz corrente.** Correção de uma linha.

**Resultado do mercado sobre a IEEE 13:**

```
negociacao   75 rodadas, convergiu
operacao     95 janelas
baseline     V 0,85364 a 1,12570 pu    446 leituras fora de ANSI Range A
negociado    V 0,92302 a 1,08413 pu    174 leituras fora de ANSI Range A
```

A negociação melhora bastante e não zera, ao contrário da execução centralizada,
que zera. As três causas estão medidas: a leitura acima é **por fase**, e não a
média que o modelo do DSO enxerga; o regulador está livre e disputa a variável
com o mercado, o que custa 22 mpu; e a demanda é a **realizada**, com desvio em
relação à programada.

**A escolha do regulador foi medida, não arbitrada.** Três configurações ao longo
do dia inteiro:

| configuração | fora de ANSI C84.1 Range A |
|---|---|
| derivações travadas nos valores publicados | 53,3% |
| derivações travadas pela inicialização | 27,9% |
| **derivações livres, ajuste oficial** | **5,0%** |

As derivações publicadas são uma fotografia no pico de carga. Mantê-las por 24 h,
com a carga caindo a 353 kW de madrugada, produz 46% de leituras acima de 1,05 pu
**sem PV nenhum**. Ficou o regulador oficial, sem alteração.

## 📝 Observações Técnicas

### Um transformador, um Concentrador

Esse foi o ponto central da semana e merece o registro completo.

A camada de mercado da tese pressupõe uma rede MT/BT com vários transformadores de
distribuição, e distribui os quatro papéis assim: **um Agente Concentrador por
transformador** e **um Agente Prosumidor por nó de baixa tensão**. Na MVLV75 isso
dá 5 concentradores e 68 prosumidores, com o Concentrador agregando as propostas
dos prosumidores sob o próprio transformador.

A IEEE 13 tem **um único transformador de distribuição**, o XFM-1 de 500 kVA que
liga a barra 633 à 634, e **uma única barra de baixa tensão**, a 634. Aplicada ao
pé da letra, a regra da tese daria **1 concentrador e 1 prosumidor**. Um mercado
com um participante não é um mercado.

A adequação adotada:

```
Agente Concentrador  ->  um so, a cabeceira do alimentador, com o transformador
                         da subestacao de 5 MVA (115 kV / 4,16 kV)
Agente Prosumidor    ->  um por barra com carga ou geracao:
                         611, 632, 634, 645, 646, 652, 670, 671, 675 e 692
Agente DSO           ->  um, na subestacao
Agente Mercado       ->  um, coordenando a decomposicao dual
```

Dez prosumidores e um concentrador. Duas consequências que ficam registradas
porque mudam o significado do modelo:

1. **A restrição de carregamento (Eq. 6.28) passa a limitar o alimentador
   inteiro** em 4500 kW, e não um transformador de distribuição.
2. **O papel de "nó de baixa tensão" deixou de coincidir com o nível de tensão
   elétrico.** Na IEEE 13 quase todas as barras de prosumidor estão em 4,16 kV.
   O que define quem é prosumidor passou a ser ter carga ou geração, e isso está
   escrito no gerador do caso.

É uma **reinterpretação** da arquitetura da tese, não a arquitetura dela, e está
documentada como tal.

### O caso é gerado, não escrito à mão

`gen_ieee13_market.py` **lê a topologia do circuito já compilado**: barras, fases
por barra, linhas, transformadores e cargas saem do próprio OpenDSS. Transcrever
à mão abriria espaço para o caso de mercado divergir do circuito publicado sem
ninguém perceber. O gerador produz `force.json`, `Master.dss`, `config.json`, os
perfis de carga e geração e a topologia de rádio.

Três decisões de conversão, todas com o custo declarado:

- **Uma carga por nó**, porque é o que a interface do mercado escreve. Nas barras
  634, 670 e 675 o desequilíbrio entre fases da carga se perde; nas demais não há
  o que perder, porque a carga oficial já é monofásica ou equilibrada.
- **Modelo de carga de potência constante em todas.** A restrição de tensão do
  DSO é linearizada em dV/dP com potência constante; manter carga de impedância
  constante deixaria o modelo do agente e o fluxo de potência falando de coisas
  diferentes.
- **Os nomes das barras são os da IEEE**, e não o padrão `n{nó}` das redes
  geradas aqui. Renomear perderia a correspondência com a referência, então o
  `force.json` passou a poder trazer o nome real da barra em cada nó.

### O armazenamento foi dimensionado por medição

Para cada um dos 96 intervalos resolveu-se, com a matriz de sensibilidade do
próprio caso, a menor injeção total que mantém todas as barras dentro da faixa:

| limite por nó | folga residual |
|---|---|
| 400 kW | 13,05 mpu |
| 600 kW | 6,33 mpu |
| 800 kW | 0,98 mpu |
| **1000 kW** | **0 (factível)** |

A necessidade medida soma 7737 kW e 12,3 MWh, concentrada em 646, 634, 645 e 652,
que são as barras onde o PV excede a carga local com folga. Para julgar o porte:
o alimentador tem 3390 kW de pico de carga e **4894 kW de pico de geração**.

### As 18 figuras, em pasta própria

Ficam em `13Bus/figuras_13bus/`, na mesma convenção da `figuras_tese/` da MVLV75.
O gerador tinha a rede da tese embutida em quatro lugares (os nós 17 a 21, o 74 e
o 25, o 15/24/32/52, e os horários de 17:45 e 10:00). A escolha passou a ser
guiada pelos dados, com a rede da tese reconhecida pelos nós que ela destaca:
sendo ela, tudo fica como está escrito na tese; sendo outra, tudo vem dos dados.
O eixo dos nós também passou a ser categórico quando os nomes são esparsos, porque
com 611, 632, 645, 646 o eixo numérico abria vãos vazios e as marcas caíam em
números que não existem.

### O preço sombra ficou negativo, e isso é esperado

Na IEEE 13 o λ é negativo em 74,6% dos pares (nó, intervalo); na MVLV75 nunca é.
Não é defeito. É o multiplicador de uma restrição de **igualdade**, livre em
sinal, e o sinal segue a necessidade da rede: λ positivo pede descarga, que é o
que a subtensão exige, e λ negativo pede carga, que é o que a sobretensão exige.
O λ médio é −192,6 nos 40 intervalos com sobretensão e −30,8 nos demais, e o mais
negativo cai no instante da pior sobretensão.

O caso da tese **não tem um único intervalo de sobretensão**, então o sinal nunca
foi exercitado lá. Vale lembrar que a própria tese, na subseção 6.1.4.4, recusa a
leitura monetária de λ e o trata como variável de controle: com o `Ck = 1`
adimensional, ele tem unidade de potência, não de moeda.

## 🚀 Próximos passos

- **Migrar para as redes próprias BT16 e BT38.** A MVLV75 cumpriu o papel de
  padrão de calibração e não é o objeto do trabalho.

## 🎯 Conclusão

A IEEE 13 passou de rede validada a caso de mercado completo: circuito conferido
contra o perfil publicado com erro de 4,4×10⁻⁴ pu, arquitetura de agentes
adequada a uma rede de um transformador, negociação convergindo em 75 rodadas e as
18 figuras de referência geradas.

O que vale registrar como método: **a regra da tese não sobrevive à mudança de
rede sem uma decisão explícita**. Um Concentrador por transformador é uma boa
regra numa rede com cinco deles e vira um mercado de um participante numa rede com
um. Adequar exigiu dizer, por escrito, o que passa a fazer o papel de prosumidor e
o que a restrição de carregamento passa a significar. Fazer isso em silêncio teria
produzido um resultado que roda e não quer dizer nada.
