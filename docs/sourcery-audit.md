# Auditoria Sourcery AI

Data da auditoria: 2026-09-15  
Repositório: `AloisioMagalhaes/bipolar-mood-spending-tracker`

## Escopo e método

Foram consultados, via GitHub CLI, os comentários de todos os pull requests
fechados (`#4`, `#6`, `#7`, `#9`, `#15`, `#16`, `#18` e `#19`) e das issues
fechadas (`#1`, `#2`, `#3`, `#5`, `#8`, `#10`, `#11`, `#12` e `#17`). Também foi
consultado o PR aberto `#20`. Comentários cujo autor contém `sourcery` foram
classificados como guia automático ou recomendação acionável.

## Resultado

| Item | Classificação | Ação | Evidência |
|---|---|---|---|
| PRs #4, #6, #7, #9, #15, #18 e #19 | Guia automático | Nenhuma correção pendente identificada | Comentários do bot no histórico dos PRs |
| PR #16 | Recomendações acionáveis | Corrigidas: corrida no carregamento, JSON inválido, retorno de persistência, exportação e persistência Web | Commits do PR #16; testes/análise verdes |
| PR #20 | Recomendações acionáveis | Corrigido contraste do indicador de tendência com `Colors.deepOrange.shade700` | Commit `2f87c8d`; PR #20 |
| Issues fechadas listadas acima | Nenhuma recomendação acionável adicional | Nenhuma pendência Sourcery encontrada | Comentários das issues consultadas |

## Regra operacional para próximos PRs

Toda revisão Sourcery deve ser lida integralmente. Cada apontamento deve ser
classificado como bloqueador, melhoria ou falso positivo; para apontamentos
acionáveis, a issue/PR deve registrar causa, impacto, correção, teste e link
para a evidência. A promoção fica bloqueada enquanto houver apontamento
bloqueador, conflito de branch ou workflow pendente/falho. Essa regra integra
o fluxo definido em [`workflow-rules.md`](workflow-rules.md).

## Limitações

A auditoria depende do conteúdo atualmente disponível na API do GitHub e não
reinterpreta guias automáticos como defeitos. A ausência de comentário do bot
não é evidência de ausência de defeitos; os gates locais e do GitHub Actions
continuam obrigatórios.

## Referências

GITHUB. *GitHub CLI manual: gh pr view*. [S. l.], 2026. Disponível em:
<https://cli.github.com/manual/gh_pr_view>. Acesso em: 15 set. 2026.

SOURCERY AI. *Sourcery documentation*. [S. l.], 2026. Disponível em:
<https://docs.sourcery.ai/>. Acesso em: 15 set. 2026.
