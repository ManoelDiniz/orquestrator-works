---
description: 'Configura o time de sessões deste projeto (cria .time/ e um SESSAO.md por pasta, com o cargo e as regras que você escolher)'
argument-hint: "[pasta-raiz]"
---

Argumentos recebidos: $ARGUMENTS

# /equipe — configurar o time de sessões

Siga a skill `orquestracao-de-sessoes` (seção 1 e o arquivo `formato-sessao.md` da pasta dela). Nada é fixo: **o usuário escolhe os cargos, as pastas e as regras**.

## Passos

1. **Raiz do time:** o argumento, se veio; senão o diretório atual. Se já existir `.time/` aí, é reconfiguração: leia os `SESSAO.md` existentes e **não sobrescreva nada sem perguntar**. Em reconfiguração, o que só falta (por exemplo o bloco do `CLAUDE.md`) pode ser acrescentado sem perguntar.
2. **Sugerir pastas:** liste candidatas a sessão, sem entrar em `node_modules`, `bin`, `obj`, `.git`, `dist`. Prefira pastas com marcador de projeto (`*.csproj`, `package.json`, `pom.xml`, `go.mod`, `pyproject.toml`, `composer.json`), e a própria raiz para o orquestrador. Numa solution C#, cada `.csproj` é uma candidata.
3. **Perguntar** (`AskUserQuestion`; em caso de muitas pastas, em levas de até 4):
   - quais pastas viram sessão;
   - o **cargo** de cada uma. Sugira o nome do projeto em minúsculo (`MeuApp.Infra` → `infra`) e aceite qualquer nome livre. Modelos de papel em `modelos-de-cargo.md` (na pasta da skill);
   - qual é o **orquestrador** (normalmente a raiz).
4. **Gerar**, para cada sessão escolhida:
   - `<pasta>/SESSAO.md` com o cabeçalho (`cargo`, `nome`, `palavras` = nome da pasta) e o corpo de regras a partir do modelo de papel mais próximo, com "Mexe só em" apontando para a própria pasta;
   - um bloco no `<pasta>/CLAUDE.md` (crie o arquivo se não existir; se existir, **acrescente** o bloco, sem apagar nada), entre as marcas `<!-- time-de-sessoes:inicio -->` e `<!-- time-de-sessoes:fim -->`, dizendo: "Você é a sessão do cargo `<cargo>`. Na **primeira interação, qualquer que seja a mensagem do usuário**, antes de responder: leia o `SESSAO.md` desta pasta; olhe `.time/<cargo>/inbox` (caminho a partir da raiz do time) e execute a task mais antiga sem `.done.md` correspondente no `outbox`, seguindo a skill `orquestracao-de-sessoes` (seções 3 e 6). Sem pendência, diga em uma linha o cargo e que o inbox está vazio. Ao entregar (`.done.md` no `outbox`), avise o orquestrador com uma mensagem curta \"NNN done\" via `SendMessage`, se ele estiver aberto (`ListAgents`).";
   - `.time/<cargo>/inbox`, `fila`, `outbox` e `archive` (com um `.gitkeep`);
   - `.time/ESTADO.md` (só na primeira vez) com o diário vazio e a tabela cargo → pasta.
   - `.time/AUDITORIA.md` (só na primeira vez) com o cabeçalho `| data/hora | de | para | via | arquivo | resumo |` (skill, seção 8).
5. **Garantir o bloco do `CLAUDE.md` em TODA pasta de sessão, inclusive em reconfiguração** (passo 4, bloco marcado). Se o bloco já existe entre as marcas, não duplique. Sem esse bloco, um `claude` recém-aberto não lê o `inbox`. Isto não precisa de pergunta.
6. **Mostrar o resultado** em poucas linhas (cargo → pasta) e dizer como usar: abrir uma sessão em cada pasta (`claude` dentro dela), depois `/comunicar`.
7. Se o projeto for versionado, perguntar se `.time/` e os `SESSAO.md` entram no repositório (recomendado: sim, o time herda os cargos; `.time/*/outbox` pode ir no `.gitignore` se preferirem).

## Regras

- Nunca apague nem substitua um `SESSAO.md` existente sem confirmação.
- Só crie arquivos dentro da raiz informada.
- Não abra sessões sozinho: só diga o comando para abrir.
