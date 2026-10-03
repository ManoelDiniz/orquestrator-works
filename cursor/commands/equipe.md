# /equipe — configurar o time de sessões

Argumento opcional: pasta raiz do time. Siga a regra `orquestracao-de-sessoes` (seção 1) e a regra `formato-sessao`. Nada é fixo: **o usuário escolhe os cargos, as pastas e as regras**.

## Passos

1. **Raiz do time:** o argumento, se veio; senão a raiz do workspace. Se já existir `.time/` aí, é reconfiguração: leia os `SESSAO.md` existentes e **não sobrescreva nada sem perguntar**.
2. **Sugerir pastas:** liste candidatas a sessão, sem entrar em `node_modules`, `bin`, `obj`, `.git`, `dist`. Prefira pastas com marcador de projeto (`*.csproj`, `package.json`, `pom.xml`, `go.mod`, `pyproject.toml`, `composer.json`), e a própria raiz para o orquestrador.
3. **Perguntar** (em texto, numa mensagem só): quais pastas viram sessão; o **cargo** de cada uma (sugira o nome do projeto em minúsculo e aceite nome livre; modelos na regra `modelos-de-cargo`); qual é o **orquestrador** (normalmente a raiz).
4. **Gerar**, para cada sessão escolhida:
   - `<pasta>/SESSAO.md` com o cabeçalho (`cargo`, `nome`) e o corpo de regras a partir do modelo mais próximo, com "Mexe só em" apontando para a própria pasta;
   - `<pasta>/.cursor/rules/time-de-sessoes.mdc` com `alwaysApply: true` e este texto: "Você é a sessão do cargo `<cargo>`. Na **primeira interação, qualquer que seja a mensagem do usuário**, antes de responder: leia o `SESSAO.md` desta pasta; olhe `.time/<cargo>/inbox` (a partir da raiz do time) e execute a task mais antiga sem `.done.md` correspondente no `outbox`, seguindo a regra `orquestracao-de-sessoes` (seções 3 e 6). Sem pendência, diga em uma linha o cargo e que o inbox está vazio. Ao entregar, escreva ao final da resposta a mensagem curta \"NNN done\" para o dono colar no orquestrador.";
   - `.time/<cargo>/inbox`, `fila`, `outbox` e `archive` (com um `.gitkeep`);
   - `.time/ESTADO.md` (só na primeira vez) com o diário vazio e a tabela cargo → pasta;
   - `.time/AUDITORIA.md` (só na primeira vez) com o cabeçalho `| data/hora | de | para | via | arquivo | resumo |`.
5. **Garantir o `time-de-sessoes.mdc` em TODA pasta de sessão, inclusive em reconfiguração.** Se já existe, não duplique. Sem ele, um chat novo não lê o `inbox`.
6. **Mostrar o resultado** em poucas linhas (cargo → pasta) e dizer como usar: abrir o Cursor em cada pasta (uma janela por sessão), depois `/comunicar`.
7. Se o projeto for versionado, perguntar se `.time/` e os `SESSAO.md` entram no repositório (recomendado: sim).

## Regras

- Nunca apague nem substitua um `SESSAO.md` existente sem confirmação.
- Só crie arquivos dentro da raiz informada.
- Não abra sessões sozinho: só diga como abrir.
