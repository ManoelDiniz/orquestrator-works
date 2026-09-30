---
description: 'Fala com outra sessão do time escolhendo o cargo (ex.: /comunicar infra confere a migration)'
argument-hint: "[cargo] [mensagem]"
---

Argumentos recebidos: $ARGUMENTS

# /comunicar — escolher o cargo e mandar a mensagem

Os cargos **não são fixos**: vêm dos arquivos `SESSAO.md` do projeto. Siga a skill `orquestracao-de-sessoes` (seções 1 e 7).

## 1. Descobrir os cargos

Suba do diretório atual até achar `.time/` (a raiz do time) e leia só o cabeçalho (`cargo`, `nome`, `palavras`) de cada `SESSAO.md` sob a raiz, sem entrar em `node_modules`, `bin`, `obj`, `.git`. **Layout antigo** (raiz com `ORQUESTRACAO.md`): os cargos vêm da tabela "Quem é quem" dele; leia só essa tabela. Sem nenhum dos dois, diga que o time não está configurado e sugira `/equipe`.

Rode `ListAgents` e marque cada cargo como **aberto** (uma sessão cujo nome casa com as `palavras`, padrão = nome da pasta) ou **fechado**. Não conte a própria sessão.

## 2. Atalho

Se a primeira palavra dos argumentos for um cargo existente (`/comunicar infra confere a migration`), pule o menu: cargo = primeira palavra, mensagem = o resto. Se não for cargo, trate tudo como mensagem e faça o menu.

## 3. Menu (sem cargo nos argumentos)

Pergunte com `AskUserQuestion`. O limite é 4 opções por pergunta:
- Até 4 cargos: uma pergunta só.
- Mais de 4: divida em levas de até 4 (a última opção da leva é "Mais cargos..."), ou pergunte o grupo primeiro se o usuário tiver agrupado os cargos.
- Cada opção mostra `nome (cargo)` e, na descrição, `aberto` ou `fechado (a ordem fica no inbox)`. "Outro" permite digitar mais de um cargo.

Sem mensagem ainda, pergunte em texto simples: "O que mando para <cargo>?" e espere.

## 4. Enviar

Com cargo e mensagem, siga a seção 7 da skill:
- **Aberto:** `SendMessage` (primeira linha autossuficiente). Se for tarefa, grave antes `<canal>/inbox/NNN-slug.md` e a mensagem só aponta para ele.
- **Fechado:** grave a ordem no `inbox/` do cargo, avise que ficou lá e ofereça abrir a sessão (`claude` na pasta do `SESSAO.md`); só abre com o OK.
- **Vários cargos:** repita para cada um, sem misturar as mensagens.
- **Nome de sessão que não casa com nenhum cargo:** pergunte uma vez qual sessão é o cargo e grave o nome em `palavras` do `SESSAO.md`.

Termine com uma linha: para quem foi, aberto ou fechado, e o que foi enviado.
