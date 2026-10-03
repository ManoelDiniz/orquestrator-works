# /comunicar — escolher o cargo e preparar a mensagem

Uso: `/comunicar <cargo> <mensagem>`. Os cargos **não são fixos**: vêm dos `SESSAO.md` do projeto. Siga a regra `orquestracao-de-sessoes` (seções 1 e 7).

O Cursor não envia mensagem entre sessões. Este comando **grava a ordem em arquivo e entrega uma mensagem pronta** para o dono colar no chat da sessão do cargo.

## Passos

1. **Descobrir os cargos:** suba do diretório atual até achar `.time/` e leia só o cabeçalho (`cargo`, `nome`) de cada `SESSAO.md` sob a raiz, sem entrar em `node_modules`, `bin`, `obj`, `.git`. Sem `.time/`, diga que o time não está configurado e sugira `/equipe`.
2. **Escolher o cargo:** se a primeira palavra for um cargo existente, cargo = ela e mensagem = o resto. Senão, liste os cargos (`nome (cargo)`) e pergunte para qual vai e o quê.
3. **Gravar:** se for tarefa, grave `<canal>/inbox/NNN-slug.md` (NNN = maior número em `inbox/` + `archive/` + 1; formato na regra `formato-sessao`). Pergunta ou aviso curto não precisa de arquivo.
4. **Auditoria:** acrescente uma linha em `.time/AUDITORIA.md` (regra, seção 8; `via` = `inbox` ou `mensagem`).
5. **Entregar** ao dono, em bloco de código, a mensagem de 1 a 3 linhas para colar no chat do cargo (primeira linha autossuficiente; se tiver arquivo, aponte o caminho). Diga em uma linha o cargo e a pasta onde o chat deve estar aberto; se não houver sessão aberta lá, é abrir o Cursor nessa pasta e colar num chat novo.

Vários cargos: repita para cada um, sem misturar as mensagens.
