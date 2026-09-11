---
name: "🚀 Relatório de Progresso"
about: "Interface web com streamlit"
title: "[OPENTES - TSCC]"
labels: pesquisa, software, integração, progresso
assignees: "Laiza Edwigens Rocha Silva e Rafael dos Santos Moura"
---

## 📌 Descrição da Atividade
Nessa semana, implementamos melhorias visuais e funcionais no script `menu_streamlit.py`:
- **Ícones dos Agentes:** Carregamento estático de arquivos SVG e representação dinâmica de cada topologia a partir do número de agentes. 
- **Gerenciamento de Resultados:** Atualização do ciclo de vida dos gráficos na tela, uma vez que, agora são exibidos os gráficos após o terminal rodar a co-simulação. Ao clicar em "Iniciar", os gráficos anteriores são removidos da tela. Ao finalizar a co-simulação com sucesso, o estado é atualizado e  exibe os novos arquivos PNG gerados pela execução atual.


- **Linguagem/Ferramenta:** (x) Python | (x) C++ | (x) Docker | (x) ZeroMQ | (x) PADE | (x) OMNeT++ | Streamlit (X)
- **Repositório Principal:** tscc-com-opentes/development
- **Status do Ambiente:** Estável / Totalmente Integrado

## ✅ Checklist de Entrega
* [X] Menu interativo com o usuário para configuração
* [X] Interface web desse menu
* [X] Inserção de ícones em SVG customizados com as cores do projeto
* [X] Renderização dinâmica dos gráficos (limpeza e atualização)
* [ ] Testes - *WIP*

## 📈 Resultados / Dificuldades

### **Resultados Alcançados (Pesquisa):**
* WIP 
### **Resultados Alcançados (Software):**
* Menu interativo para o usuário configurar a co-simulação
* Gestão fluida dos resultados visuais, evitando sobreposição de gráficos de execuções anteriores
* Interface mais robusta e descritiva com o *Preview* das topologias

## 📅 Próximos Passos
* **Testes e atualizações:** Precisamos fazer os testes e introduzir esses gráficos e atualizações do software no artigo.
---
