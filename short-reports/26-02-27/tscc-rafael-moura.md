---
name: "🚀 Relatório de Progresso / Nova tarefa"
about:
  Utilize este template para documentar avanços em algoritmos, correções ou
  novas implementações.
title: "[PESQUISA]: Comunicação entre Containers"
labels: pesquisa, software
assignees: "Rafael Moura"
---

## 📌 Descrição da Atividade

> Implementação e configuração da infraestrutura de comunicação entre dois containers Docker utilizando o projeto OpenTES.
>
> Foi estabelecida conectividade entre os containers dentro da mesma rede Docker, com resolução correta de nomes e validação de acesso entre serviços.
>
> **Importante:** até o momento foi validada apenas a conexão entre os containers. A troca efetiva de mensagens/dados ainda não foi implementada ou validada.
>
> A documentação técnica encontra-se registrada na mesma **Branch de Trabalho** indicada abaixo.

---

## 🛠 Contexto Técnico

- **Linguagem/Ferramenta:** (X) Python | ( ) Julia | (X) Docker | (X) OpenTES  
- **Repositório no GitHub**: https://github.com/grei-ufc/tscc-com-opentes  
- **Branch de Trabalho**: https://github.com/grei-ufc/tscc-com-opentes/tree/caminho2  
- **Requisito Associado**: Estruturação de ambiente distribuído baseado em containers para futura implementação de comunicação cliente-servidor.

---

## ✅ Checklist de Entrega

- [x] Containers executando simultaneamente.
- [x] Rede Docker compartilhada configurada.
- [x] Resolução de nome entre containers validada.
- [x] Conectividade básica testada (ping/acesso à porta).
- [x] Documentação consolidada na Branch de Trabalho.
- [ ] Implementação de envio de mensagens.
- [ ] Implementação de recebimento de mensagens.
- [ ] Teste de troca bidirecional de dados.
- [ ] Validação final com o Orientador.

---

## 📈 Resultados / Dificuldades

### ✔ Resultados Obtidos

1. Criação de rede Docker compartilhada.
2. Execução simultânea dos dois containers.
3. Resolução correta de hostname via DNS interno do Docker.
4. Verificação de conectividade entre os serviços.
5. Documentação da configuração realizada.

Neste estágio, os containers:

- Estão na mesma rede.
- Conseguem se enxergar.
- Conseguem estabelecer conexão na porta configurada.

Porém, **a camada de aplicação para troca de mensagens ainda não foi validada**.

---

### ⚠ Dificuldades Encontradas

- Permissões no daemon Docker (`/var/run/docker.sock`).
- Ajustes na configuração de rede.
- Correção de parâmetros de host e porta.
- Garantia de que ambos os serviços estivessem na mesma bridge network.

---

## 📊 Progresso Atual

**80%**  
`[########--] 100%`

Infraestrutura de rede concluída.  
Falta implementação e validação da troca efetiva de dados.

---

## 📅 Prazo Estimado

- Data de entrega pretendida: **28/02/2026**
- Situação: Dentro do cronograma.

---

## 📋 Planejamento para Conclusão

1. Implementar endpoint de envio de mensagens.
2. Implementar mecanismo de recebimento e resposta.
3. Validar troca bidirecional de dados.
4. Documentar testes de comunicação.
5. Submeter para validação com o orientador.

---

## 🎯 Status Atual

Infraestrutura de comunicação pronta (nível de rede).  
Camada de aplicação (troca de mensagens) pendente.

Próxima etapa técnica:
