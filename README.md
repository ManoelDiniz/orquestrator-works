# orquestrator-works

Skill do Claude Code para coordenar várias sessões no terminal, **uma por pasta do projeto**, cada uma com um cargo definido num `SESSAO.md`. As sessões trocam tarefas e entregas por arquivos (`inbox/outbox`) e se chamam por mensagens curtas.

Exemplo: numa solution C#, uma sessão orquestradora na raiz e uma executora para cada projeto (Api, Infra, Domain...).

## O que vem aqui

| Item | Para que serve |
|---|---|
| `skills/orquestracao-de-sessoes/SKILL.md` | O protocolo: papéis, ciclo de uma task, regras de convivência, economia de uso |
| `skills/orquestracao-de-sessoes/formato-sessao.md` | Formato do `SESSAO.md` e modelos de task e entrega |
| `skills/orquestracao-de-sessoes/modelos-de-cargo.md` | Modelos de cargo prontos para adaptar |
| `commands/equipe.md` | Comando `/equipe`: monta o time |
| `commands/comunicar.md` | Comando `/comunicar`: fala com outra sessão |

## Instalação

Copie para a pasta do Claude Code do seu usuário:

```bash
cp -r skills/orquestracao-de-sessoes ~/.claude/skills/
cp commands/*.md ~/.claude/commands/
```

No Windows (PowerShell):

```powershell
Copy-Item -Recurse skills\orquestracao-de-sessoes $HOME\.claude\skills\
Copy-Item commands\*.md $HOME\.claude\commands\
```

## Versão para o Cursor

A pasta `cursor/` traz a mesma skill adaptada ao Cursor: regras (`.mdc`) e comandos.

| Item | Para que serve |
|---|---|
| `cursor/rules/orquestracao-de-sessoes.mdc` | O protocolo, sem `SendMessage`/`ListAgents` |
| `cursor/rules/formato-sessao.mdc` | Formato do `SESSAO.md` e modelos de task e entrega |
| `cursor/rules/modelos-de-cargo.mdc` | Modelos de cargo |
| `cursor/commands/equipe.md` | `/equipe`: monta o time |
| `cursor/commands/comunicar.md` | `/comunicar`: grava a ordem e entrega a mensagem pronta |

Instalação, na raiz do projeto (o Cursor lê `.cursor/` do projeto):

```bash
mkdir -p .cursor && cp -r cursor/rules cursor/commands .cursor/
```

Diferença: o Cursor não deixa uma sessão acordar outra. O fluxo de arquivos (`inbox/outbox`, `ESTADO.md`, auditoria) é o mesmo, mas quem leva o aviso de uma sessão à outra é você, colando a mensagem curta que o agente entrega. Cada pasta de sessão ganha um `.cursor/rules/time-de-sessoes.mdc` (criado pelo `/equipe`) para o chat novo ler o `inbox` sozinho.

## Como usar

1. Na raiz do projeto, rode `/equipe`. Ele sugere as pastas, pergunta o cargo e as regras de cada uma e cria `.time/` com um `SESSAO.md` por pasta.
2. Abra uma sessão do Claude Code em cada pasta, todas no **mesmo modo de permissão**. Se forem diferentes, o Claude Code segura as mensagens entre elas até alguém aprovar.
3. Fale com outra sessão por cargo:

   ```
   /comunicar infra confere a migration
   ```

## Como funciona

- **Orquestrador:** escreve as ordens, aceita entregas, mantém o diário (`.time/ESTADO.md`) e o contrato entre os projetos.
- **Executora:** uma task por vez, só dentro da própria pasta.
- **Pesquisa/PO** (opcional): lê e investiga, não escreve código.

Ciclo de uma task:

1. O orquestrador grava `.time/<cargo>/inbox/NNN-slug.md` (a ordem) e avisa a sessão com uma mensagem curta.
2. A executora faz a task e entrega em `outbox/NNN-slug.done.md`.
3. O orquestrador confere, registra no diário e move tudo para `archive/`.

Só o que está em `inbox/` é ordem. Executoras não falam entre si e não mexem na pasta do outro: tudo passa pelo orquestrador.

## Licença

Sem licença definida.
