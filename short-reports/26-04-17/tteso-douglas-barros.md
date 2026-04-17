---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Consolidar a preparação do ambiente experimental da próxima etapa da pesquisa, incluindo validação do OpenDSS em Python 3.12.11 e instalação funcional do OMNeT++ 6.3.0.
title: "[Pesquisa Aplicada]: Consolidação do Ambiente OpenDSS + OMNeT++ para a Próxima Etapa do Sistema Transativo"
labels: pesquisa, software
assignees: "[Douglas Barros]"
---

## 📌 Descrição da Atividade

A semana de **13/04 a 17/04/2026** foi dedicada à preparação prática da infraestrutura de simulação que servirá de base para o próximo ciclo da pesquisa. O foco saiu da estabilização do PADE em si e passou para a montagem e validação do ecossistema auxiliar que dará suporte à etapa de **pesquisa aplicada em sistema transativo**, especialmente no contexto de **simulação elétrica**, **integração computacional** e futura **co-simulação**.

Nesse contexto, foram trabalhadas duas frentes principais. A primeira envolveu a organização e validação do **OpenDSS em Python 3.12.11**, por meio de duas abordagens complementares: `DSS-Python` e `py-dss-interface`. Essa etapa incluiu a criação de uma estrutura mínima de alimentador, execução de fluxo de carga e correção de um problema específico de locale no backend `Linux-C++` do `py-dss-interface`, que causava leitura incorreta de números com ponto decimal e levava a erros de impedância, falha de inversão matricial e encerramento abrupto da execução.

A segunda frente concentrou-se na instalação e validação do **OMNeT++ 6.3.0** em ambiente Linux. Foram concluídas a configuração, compilação e validação do framework, com correções de incompatibilidades entre `pyenv`, `python3-dev`, `clang`, `lld` e `libdw`, além da confirmação de execução do exemplo clássico `aloha` em modo terminal e da abertura funcional da IDE.

Com isso, a semana não foi voltada à criação de um caso final de pesquisa, mas sim à **consolidação da base experimental** que permitirá avançar, nas próximas etapas, para a definição de uma arquitetura prática envolvendo **PADE + OpenDSS** e, possivelmente, **mosaik + OMNeT++**, conforme a direção metodológica mais adequada para o sistema transativo a ser desenvolvido.

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** ( x ) Python | ( ) Julia | ( ) Docker | ( x ) OpenDSS | ( x ) OMNeT++
- **Repositório no GitHub**: `https://github.com/grei-ufc/pade`
- **Branch de Trabalho:** `local` (ainda não foi passado ao git)
- **Requisito Associado:** Preparação do ambiente experimental da próxima fase da pesquisa, com validação do OpenDSS em Python 3.12.11 e instalação funcional do OMNeT++ 6.3.0 para apoiar estudos futuros de sistema transativo e co-simulação.

## ✅ Checklist de Entrega

- [x] **Validação do OpenDSS em Python 3.12.11**
  - [x] Organização de dois fluxos locais de trabalho: `DSS-Python` e `py-dss-interface`.
  - [x] Criação de uma estrutura mínima de projeto com arquivos `dss/`, scripts de execução e caso simples de fluxo de carga.
  - [x] Execução validada do fluxo usando `DSS-Python`.
  - [x] Execução validada do fluxo usando `py-dss-interface`.

- [x] **Correção de incompatibilidades no `py-dss-interface`**
  - [x] Identificação de falha ligada ao locale do sistema no backend `Linux-C++`.
  - [x] Diagnóstico dos erros de impedância e inversão matricial em ambiente Linux com locale pt_BR.
  - [x] Forçamento do ambiente para locale `C.UTF-8`/`C` antes da inicialização do motor.
  - [x] Revalidação completa da execução dos scripts após o ajuste.

- [x] **Instalação e Configuração do OMNeT++ 6.3.0**
  - [x] Instalação das dependências do ambiente Linux.
  - [x] Criação e ativação do ambiente local `.venv` do OMNeT++.
  - [x] Correção da configuração para evitar conflito com bindings Python opcionais do Scave.
  - [x] Ajuste da toolchain para uso de `gcc/g++` em vez de `clang/lld`.
  - [x] Desativação do suporte opcional de backtrace para contornar falhas de link com `libdw`.

- [x] **Compilação e Validação Inicial do OMNeT++**
  - [x] Execução bem-sucedida de `./configure`.
  - [x] Compilação completa com `make`.
  - [x] Geração dos executáveis dos exemplos, incluindo `samples/aloha/aloha`.
  - [x] Validação do exemplo `aloha` em modo `Cmdenv`.
  - [x] Confirmação de abertura funcional da IDE.

- [x] **Melhoria da Experiência de Uso**
  - [x] Criação de um wrapper local para permitir o uso do comando `omnetpp` após `source setenv`.
  - [x] Consolidação de um fluxo de uso reprodutível para terminal e IDE.

## 📈 Resultados / Dificuldades

- **Progresso atual:** 20

![Progress](https://progress-bar.xyz/20/)

### ✅ **Resultados da Semana**

| Módulo/Atividade | Status Atual | Observação |
|---------|-----------|----------|
| **OpenDSS com DSS-Python** | ✅ Validado | Fluxo mínimo executando corretamente em Python 3.12.11 |
| **OpenDSS com py-dss-interface** | ✅ Validado | Problema de locale corrigido e execução estabilizada |
| **Ambiente Python auxiliar** | ✅ Organizado | Estrutura local separada por abordagem e scripts de teste prontos |
| **OMNeT++ 6.3.0** | ✅ Instalado e compilado | `configure` e `make` concluídos com sucesso |
| **IDE do OMNeT++** | ✅ Funcional | Abre corretamente no ambiente local |
| **Exemplo Aloha** | ✅ Validado | Executando em `Cmdenv` após compilação |

### 🔧 **Atividades Desenvolvidas na Semana**

1. **Estruturação do ambiente OpenDSS em Python 3.12.11:** organização de duas frentes de teste independentes, uma baseada em `DSS-Python` e outra em `py-dss-interface`, para permitir comparação prática e avaliação de robustez.
2. **Montagem de um caso elétrico mínimo:** criação de arquivos `.dss` e scripts Python para fluxo de carga simples, suficientes para validar integração, solver e saída dos motores disponíveis.
3. **Validação funcional do `DSS-Python`:** confirmação de operação correta do motor OpenDSS em Python 3.12.11 com execução do caso base.
4. **Diagnóstico profundo do `py-dss-interface` em Linux:** investigação dos erros de leitura de impedância e falhas internas do backend `Linux-C++`, associados à interpretação incorreta de números decimais em ambiente com locale brasileiro.
5. **Correção por controle explícito de locale:** ajuste do ambiente para `C.UTF-8`/`C` antes da inicialização do `py-dss-interface`, estabilizando o parsing numérico e eliminando os erros de inversão de matriz e encerramento abrupto.
6. **Instalação do OMNeT++ 6.3.0:** execução do fluxo de instalação local, dependências e preparação do ambiente de build.
7. **Correção da fase de configuração do OMNeT++:** resolução do conflito entre o Python do `pyenv` e o `python3-dev` do sistema, optando por desligar os bindings Python opcionais do Scave nesta etapa.
8. **Ajuste da toolchain de compilação:** substituição da preferência por `clang/lld` por `gcc/g++`, devido a incompatibilidades locais no toolchain C++ detectadas durante o `configure`.
9. **Correção do link com bibliotecas de backtrace:** desativação do suporte opcional de backtrace para contornar erros com `libdw` durante a compilação.
10. **Validação final do ambiente OMNeT++:** compilação completa, teste do exemplo `aloha` em modo terminal e confirmação da abertura funcional da IDE, além da criação de um wrapper para o comando `omnetpp`.

### ⚠️ **Dificuldades Enfrentadas**

- O `py-dss-interface` apresentou um comportamento sensível ao locale do sistema em Linux, interpretando incorretamente parâmetros numéricos com ponto decimal, o que levou a erros difíceis de diagnosticar à primeira vista.
- A configuração inicial do OMNeT++ encontrou incompatibilidade entre o Python do `pyenv` e os pacotes de desenvolvimento do sistema, exigindo ajuste da configuração para desabilitar bindings opcionais que não eram essenciais para esta etapa.
- O toolchain `clang/lld` não se mostrou estável no ambiente local para a compilação completa do OMNeT++, sendo necessário migrar para `gcc/g++`.
- O link com suporte a backtrace via `libdw` falhou durante a build, exigindo desativação dessa funcionalidade opcional para concluir a compilação com sucesso.

## 📅 Prazo Estimado

- A definir.

## 📋 Planejamento para conclusão da entrega

### ✅ **Concluído nesta semana**

- [x] Validação do OpenDSS com `DSS-Python` em Python 3.12.11.
- [x] Validação do OpenDSS com `py-dss-interface` após correção de locale.
- [x] Instalação, configuração e compilação do OMNeT++ 6.3.0.
- [x] Validação do exemplo `aloha` em modo terminal.
- [x] Confirmação de abertura da IDE do OMNeT++.

### 🔄 **Próximos passos**

- Passo 1. Consolidar o critério de escolha entre `DSS-Python` e `py-dss-interface` para os próximos experimentos.
- Passo 2. Definir como o OpenDSS será acoplado ao fluxo principal da pesquisa com PADE.
- Passo 3. Avaliar se o uso do OMNeT++ ficará restrito à camada de estudo de comunicação ou se entrará em uma arquitetura mais ampla de co-simulação.
- Passo 4. Investigar a integração futura com `mosaik`, caso a composição `PADE + OpenDSS + OMNeT++` se mostre metodologicamente vantajosa.
- Passo 5. Iniciar o desenho de um caso experimental de sistema transativo sobre a nova base já validada.
- Passo 6. Estudo aprofundado do código utilizado no artigo: "Co-simulation platform for the assessment of transactive energy systems"
- Passo 7. Utilizar do código do artigo base anterior para servir de base a nova implementação do sistema transativo. Agora Ns3 -> Omnet++, MyGrid/Pandapower -> OpenDSS via `DSS-Python` ou `py-dss-interface`.

## 🔍 Observações Técnicas

O OpenDSS agora está validado em Python 3.12.11 por dois caminhos distintos, e o OMNeT++ 6.3.0 encontra-se efetivamente operacional no ambiente local, tanto em terminal quanto em IDE.

Esse cenário amplia significativamente as possibilidades da próxima etapa. A partir daqui, já existe base concreta para estudar uma composição em que o **PADE** atue como plataforma multiagente, o **OpenDSS** como motor elétrico e o **OMNeT++** como suporte à camada de comunicação, com ou sem uma orquestração adicional via **mosaik**. A definição dessa arquitetura ainda depende de decisão metodológica, mas a infraestrutura mínima necessária para começar os testes foi estabelecida.

## 🎯 Conclusão

A semana foi dedicada à montagem do ambiente técnico da próxima fase da pesquisa. Em vez de avançar diretamente para um sistema transativo completo, o esforço foi concentrado em garantir que as ferramentas auxiliares fundamentais estivessem realmente funcionando no ambiente alvo.

Como resultado, o **OpenDSS** ficou validado em Python 3.12.11, inclusive com correção de um problema específico de locale no `py-dss-interface`, e o **OMNeT++ 6.3.0** foi instalado, configurado, compilado e testado com sucesso. Com essa base pronta, o próximo ciclo pode avançar com muito mais segurança para a fase de **pesquisa aplicada**, integração entre ferramentas e definição do novo caso experimental.
