# orquestrator-works

Skill do Claude Code para coordenar várias sessões no terminal, uma por pasta do projeto, cada uma com um cargo definido num `SESSAO.md`, canais `inbox/outbox` e mensagens entre sessões.

## Instalação

- `skills/orquestracao-de-sessoes/` → copie para `~/.claude/skills/`
- `commands/comunicar.md` e `commands/equipe.md` → copie para `~/.claude/commands/`

## Uso

1. `/equipe` na raiz do projeto: cria `.time/` e um `SESSAO.md` por pasta.
2. Abra uma sessão por pasta, todas no **mesmo modo de permissão** (senão o Claude Code segura as mensagens entre elas até alguém aprovar).
3. `/comunicar <cargo> <mensagem>` para falar com outra sessão.
