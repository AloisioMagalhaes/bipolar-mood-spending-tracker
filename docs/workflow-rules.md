# Regra Sourcery-AI e revisão automatizada

Todo PR deve ser lido integralmente, incluindo sugestões do Sourcery-AI e demais bots. Cada sugestão deve ser classificada como `corrigir`, `aceitar com justificativa` ou `não aplicável com evidência`. Bugs de persistência, privacidade, exportação e concorrência são bloqueadores. A resposta e o commit corretivo devem ser vinculados ao PR antes do merge.

## Conflitos primeiro

Antes de criar/continuar issue, PR, merge ou promoção de branch, verificar divergência/conflitos com a base (`git fetch origin`, `git merge-base`, `gh pr view`). Se houver conflito, bloquear a tarefa: atualizar a branch com a base, resolver manualmente preservando requisitos e documentação, executar `flutter analyze`, `flutter test` e checks remotos, e registrar a resolução no PR. É proibido iniciar a próxima etapa enquanto o PR estiver `CONFLICTING`, `UNSTABLE` ou com checks pendentes.
## Auto-merge controlado

O repositório habilita o auto-merge nativo do GitHub. Um workflow pode apenas
solicitar `--auto`; o GitHub efetiva o merge somente quando o PR estiver sem
conflitos e todos os checks obrigatórios estiverem verdes. PRs de forks são
excluídos da automação por segurança. Falhas, conflitos, revisão Sourcery
acionável ou checks pendentes continuam bloqueando a promoção.

## Code Scanning

O workflow oficial do CodeQL executa a análise `security-and-quality` da
workflows do GitHub Actions em pull requests, pushes de `main`/`develop` e
semanalmente. Alertas devem ser tratados como P0 antes de qualquer promoção.
Essa análise é complementar a `flutter analyze`, testes, OSV Scanner, Gitleaks
e revisão do threat model; a análise é complementar e não representa cobertura
completa do código Dart.
