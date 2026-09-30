# Formato do `SESSAO.md` e da pasta `.time/`

Leia só ao montar ou reconfigurar o time (`/equipe`) ou quando um `SESSAO.md` estiver faltando campo.

```
<raiz do time>/                 <- a pasta onde o /equipe foi rodado (ex.: a da .sln)
  .time/                        <- marca a raiz do time
    ESTADO.md                   <- diário e decisões (dono: orquestrador)
    <cargo>/inbox/  fila/  outbox/  archive/    <- canal de cada cargo
  src/Api/SESSAO.md             <- uma pasta por sessão; o arquivo diz quem ela é
  src/Infra/SESSAO.md
```

```
---
cargo: api                 # nome livre, sem espaço, minúsculo; é o que se digita em /comunicar
nome: API REST             # opcional, como aparece nos menus
canal: .time/api           # opcional; padrão .time/<cargo> a partir da raiz
palavras: [Api, Web.Api]   # opcional: nomes que a sessão pode ter no ListAgents; padrão = nome da pasta
---
# Regras da sessão api
**Faz:** ... **Não faz:** ...
**Mexe só em:** src/Api e seus testes.
(qualquer regra própria: padrões de código, comandos de teste, o que exige confirmação)
```

O corpo é lido pela própria sessão ao abrir e vale como regra dela. **Mantenha curto (até ~20 linhas):** é relido em toda sessão nova. Modelos de regra por cargo: `modelos-de-cargo.md`.

**Descobrir as sessões:** procure `SESSAO.md` sob a raiz (ignore `node_modules`, `bin`, `obj`, `.git`). Cada um é um cargo. O `orquestrador` normalmente fica na própria raiz.

## Formato da task e da entrega

Task (`inbox/NNN-slug.md`, **até ~60 linhas**): `# TASK NNN — título` · `STATUS: ordem · CARGO: <cargo>` · `PRIORIDADE / depende de` · `## Contexto` · `## O que fazer` (passos numerados; cite arquivo e seção do contrato, não cole conteúdo) · `## Regras` · `## Entrega`.

Entrega (`outbox/NNN-slug.done.md`, **até ~40 linhas**): `STATUS: done|blocked|needs-info` · `TASK: NNN` · `## O que foi feito` · `## Arquivos alterados` · `## Testes (comando + resultado resumido)` · `## Impacto no contrato` ("nenhum" ou a lista) · `## Pendências / perguntas`. Explicação longa vai na mensagem de commit.

Emenda, nota ou aviso sobre uma task: `NNN-EMENDA-01-slug.md`, `NOTA-NNN-slug.md`. Arquivados junto com a task.
