---
name: orquestracao-de-sessoes
description: 'Coordena várias sessões do Claude Code no terminal, cada uma numa pasta do projeto (ex.: uma por projeto de uma solution C#: Api, Infra...), com cargos e regras definidos pelo usuário num arquivo SESSAO.md por pasta, canais inbox/outbox e mensagens entre sessões. Use ao montar um time de sessões, despachar ou aceitar tarefas entre elas, ou quando o usuário falar em "orquestrador", "SESSAO.md", "despachar task", "inbox", "outbox", "chamar a sessão do <cargo>".'
---

# Orquestração de sessões do Claude Code

Várias sessões abertas ao mesmo tempo, **uma por pasta**, cada uma com um **cargo livre** e regras próprias. Uma é o **orquestrador**; as outras são **executoras**. Quem diz o cargo é o `SESSAO.md` da pasta, não o nome dela.

## 1. Onde as coisas vivem

- **Raiz do time:** suba do diretório atual até a primeira pasta com `.time/`. Lá ficam `.time/ESTADO.md` (diário, dono: orquestrador) e `.time/<cargo>/inbox|fila|outbox|archive`. Sem `.time/`: sugira `/equipe`.
- **Cargos:** um `SESSAO.md` por pasta de sessão. Formato, descoberta e modelos de task/entrega: `formato-sessao.md` (leia só quando precisar).
- **Auditoria:** `.time/AUDITORIA.md`, só de acréscimo (seção 8). Quem falou com quem, por qual canal e o quê.
- **Layout antigo:** raiz com `ORQUESTRACAO.md` e pastas `<lado>-comunication/`. Os cargos vêm da tabela "Quem é quem" do `ORQUESTRACAO.md` (cargo, pasta, canal, palavras no `ListAgents`), e o diário é o próprio `ORQUESTRACAO.md`. O resto do protocolo é igual.

## 2. Papéis

- **Orquestrador:** escreve ordens, aceita entregas, mantém o diário e o contrato entre os projetos, decide prioridade, fala com o dono. Não escreve o código das executoras.
- **Executora:** uma task por vez, **só dentro da pasta dela**. Não muda contrato sozinha.
- **Pesquisa/PO** (se houver): lê, pesquisa e devolve achado; **não escreve código nem conserta**.

Executoras **não falam entre si**: tudo passa pelo orquestrador. Problema fora do escopo: **reporta em Pendências, não conserta.**

## 3. Ciclo de uma task

**Só `inbox/` é ordem.** `fila/`, `archive/` e o resto são referência.

1. **Escopo primeiro:** o orquestrador apresenta ao dono o que vai despachar e espera o OK (salvo se o dono delegou).
2. **Despacho:** grava `<canal>/inbox/NNN-slug.md` e manda `SendMessage` curta para acordar a sessão. O arquivo é a ordem; a mensagem só acorda. NNN = maior número em `inbox/` + `archive/` + 1.
3. **Execução:** uma task por vez. Bloqueio real vai na hora como `STATUS: blocked` ou `needs-info`.
4. **Entrega:** `<canal>/outbox/NNN-slug.done.md` + mensagem "NNN done" ao orquestrador.
5. **Aceite:** o orquestrador confere contra a **resposta real**, aplica bump de contrato se a superfície mudou, registra no diário, avisa quem depende e **move task, emendas, notas e entrega para `<canal>/archive/`**. No `inbox/` só fica o que está pendente.
6. **Autodespacho (opcional):** sem pendência, a executora pode puxar o próximo item da própria `fila/`. O que o orquestrador mover pra `inbox/` vale.

## 4. Regras de convivência

- **Contrato manda no código.** Divergiu: ou o código está errado, ou o contrato precisa de bump, que passa pelo orquestrador.
- **Ninguém muda a fronteira entre projetos sozinho** (API, esquema de mensagem, interface pública): pede bump pelo `outbox/`.
- **Ninguém edita a pasta do outro.**
- **Divergência se afirma contra a resposta real,** não contra o código.
- **Banco de dev compartilhado:** anuncia antes, guarda o id de tudo que criar, apaga **só por esses ids**, confere a contagem antes e depois. Nunca por janela de tempo, nunca em dados reais.
- **Investigação** ("por que X não funciona", "como o concorrente faz Y") vai para a pesquisa, não para o orquestrador.
- **Git:** commit e push ao fechar cada task, se o dono autorizou; nunca `-f` em branch principal, nada de segredo.

## 5. Economia de uso

O que mais gasta é **ler arquivo grande** e **conversa longa relida a cada resposta**.

1. Orquestrador e pesquisa em modelo mais barato; executoras (código e teste) no mais forte.
2. **Sem monitor ocioso:** monitor só enquanto há task em andamento.
3. **Conversas novas** a cada reinício ou quando ficar longa: o estado vive no diário, nas pastas e no git.
4. **Leia só o necessário:** contrato grande é dividido **um arquivo por seção** com um índice; a task cita a seção e a sessão lê só ela. Diário: só as últimas ~5 entradas. Nunca abra `archive/` nem o diário arquivado inteiro; busque (grep) pelo número ou pela data.
5. **Textos curtos:** task até ~60 linhas, `.done.md` até ~40, entrada de diário até ~10. Cite arquivo, seção ou task anterior em vez de colar. Passando de ~15 entradas no diário, mova as antigas para um arquivo `*-arquivo-*.md`.
6. **Mensagem entre sessões:** uma a três linhas; o conteúdo está no arquivo.
7. Uma task por vez por cargo; PARCIAL + commit WIP antes de parar.

## 6. Ao abrir uma sessão

**Executora:** leia o `SESSAO.md` da própria pasta. Olhe `<canal>/inbox`: arquivo sem `.done.md` no `outbox/` é ordem pendente; execute a mais antiga. Sem pendência, diga isso em uma linha e fique ociosa, sem monitor. Vale na primeira interação, qualquer que seja a mensagem (o bloco do `CLAUDE.md` gravado pelo `/equipe` e o prompt de abertura disparam isso).

**Orquestrador:** leia as regras e as ~5 últimas entradas do diário, confira os `inbox/` de todos os cargos, rode `ListAgents` e avise cada sessão aberta: "Sou o novo orquestrador; quando fechar a task, me avise por aqui." Diga ao dono, em poucas linhas, onde estamos e o que falta.

## 7. Chamar uma sessão pelo cargo (`/comunicar`)

1. Descubra os cargos (seção 1). Nunca use nome de sessão de memória: `ListAgents` muda a cada reinício.
2. Ache a sessão casando o nome no `ListAgents` com as `palavras` do cargo (padrão: nome da pasta). Não mande pra si mesma.
3. **Uma candidata:** `SendMessage` com a primeira linha autossuficiente. Se for tarefa, grave antes o arquivo no `inbox/`; a mensagem só aponta pra ele.
4. **Nenhuma (cargo fechado):** grave a ordem no `inbox/` mesmo assim, avise e ofereça abrir a sessão; só abra com OK (cada sessão gasta uso): `cd <pasta> && claude --dangerously-skip-permissions "Você é a sessão do cargo <cargo>. Leia o SESSAO.md e execute o inbox pendente (skill orquestracao-de-sessoes, seção 6)."`. Abra **sempre no mesmo modo de permissão das outras sessões**: se os modos forem diferentes, o Claude Code segura a mensagem entre elas até o dono aprovar ("Cross-session message held for approval").
5. **Duas ou mais:** pergunte qual. Nome que não casa com nada: pergunte uma vez e grave em `palavras`.
6. Sessão `busy`: a mensagem entra na fila; não faça polling (use `notify_when_idle: true` se precisar).
7. Diga ao usuário em uma linha para quem foi e o quê.

**Mensagem entre sessões do time não pede aprovação do dono.** Mandar e receber `SendMessage`, gravar/ler `inbox`/`outbox`, avisar "NNN done" e executar a task do `inbox` acontecem direto, sem perguntar. O que o dono já autorizou no protocolo (ex.: commit + push ao fechar a task) vale também quando o pedido chega por outra sessão. Só pare para confirmar o que fugir do protocolo e da task: apagar dado real, `push -f`, mensagem para fora do time.

## 8. Auditoria: quem fala, como fala

Toda comunicação entre sessões deixa **uma linha** em `.time/AUDITORIA.md` (crie com o cabeçalho abaixo se não existir; layout antigo: `AUDITORIA.md` na raiz). **Só acrescenta ao fim; nunca edita nem apaga linha.** Quem envia registra, no ato:

```
| data/hora | de (cargo) | para (cargo) | via | arquivo | resumo |
```

- **via:** `SendMessage`, `inbox` (despacho), `outbox` (entrega), `bump` (pedido de contrato) ou `dono` (instrução direta do dono à sessão).
- **arquivo:** `NNN-slug.md` quando houver; senão `-`.
- **resumo:** até ~10 palavras. Sem segredo, token ou dado real.
- **de:** o cargo do `SESSAO.md` da sessão que escreve, nunca o nome do `ListAgents`.

Mensagem sem linha na auditoria não vale como ordem. Ao aceitar uma entrega, o orquestrador confere que existem as linhas de despacho e de entrega. Para auditar: `grep` por cargo, número ou data; nunca leia o arquivo inteiro. Passando de ~200 linhas, mova as antigas para `AUDITORIA-arquivo-AAAA-MM.md`.
