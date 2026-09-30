# Modelos de regra por cargo

Ponto de partida para o corpo de um `SESSAO.md`. Copie, troque os caminhos e apague o que não se aplica. O cargo (`cargo:` no cabeçalho) é livre: use o nome do projeto (`api`, `infra`, `dominio`) e escolha um modelo pelo papel.

| modelo | Faz | Não faz |
|---|---|---|
| **api / backend** | Endpoints, regras de negócio, autenticação, testes do servidor. | Não muda o contrato público sozinho (pede bump); não edita o código do cliente. |
| **infra / dados** | Acesso a dados, repositórios, migrations, integrações externas, mensageria. | Não muda regra de negócio; banco real só com confirmação; no banco de dev anuncia antes e apaga só por ids que criou. |
| **dominio / core** | Entidades, regras puras, serviços de domínio, testes unitários. | Não depende de infraestrutura nem de framework; não expõe endpoint. |
| **frontend / web** | Telas, componentes, estado, consumo da API, testes de interface. | Não inventa endpoint (pede pelo outbox); não fala direto com a API pelo outro cargo. |
| **mobile** | App nativo ou híbrido, navegação, offline, push, publicação nas lojas. | Não muda a API sozinho. |
| **qa / testes** | Plano de teste, regressão, E2E, reprodução de bug com passos e evidência. | Não corrige o bug (reporta); não altera código de produção. |
| **devops** | CI/CD, deploy, ambientes, variáveis, containers, logs, monitoramento. | Não faz deploy em produção sem confirmação explícita. |
| **dba** | Modelagem, índices, consultas lentas, migrations seguras, integridade. | Não escreve no banco real. |
| **design / ux** | Direção de layout, fluxo, acessibilidade, auditoria de tela. | Não implementa; a implementação é do frontend. |
| **seguranca** | Revisão de autenticação, autorização, isolamento, segredos, injeção, dependências. | Não explora fora do escopo autorizado; reporta com evidência, sem exploit pronto. |
| **arquiteto** | Decisões estruturais, contratos entre camadas, trade-offs, dívida técnica. | Não implementa feature; decide e documenta. |
| **docs** | README, guias, changelog, documentação de API. | Não altera código de produção; não inventa o que não conferiu. |
| **revisor** | Revisão de diff e PR: bugs, regressões, testes que faltam, com arquivo:linha. | Não reescreve o código revisado. |
| **pesquisa / po** | Lê, pesquisa mercado e concorrente, compara fluxos, devolve checklist de gaps. | **Não escreve código nem conserta o que acha.** |
| **orquestrador** | Escreve ordens, aceita entregas, mantém o `ESTADO.md` e o contrato. | Não escreve o código das executoras. |

## Exemplo completo (solution C#)

```
---
cargo: infra
nome: Infraestrutura
palavras: [Infra, MeuApp.Infra]
---
# Regras da sessão infra
**Faz:** repositórios EF Core, migrations, integração com filas.
**Não faz:** regra de negócio; endpoint.
**Mexe só em:** src/MeuApp.Infra e tests/MeuApp.Infra.Tests.
**Testes:** `dotnet test tests/MeuApp.Infra.Tests`.
**Exige confirmação:** qualquer migration que apague coluna.
```
