# CI, segurança e publicação

O workflow executa análise Dart, testes com cobertura, build Web, APK debug/release, OSV Scanner e Gitleaks em container. O workflow Pages publica `build/web` com `base-href` compatível com o nome do repositório. Falhas de segurança bloqueiam a entrega. APKs são artefatos; assinatura de produção será configurada somente com segredo externo e processo de release aprovado. Qualquer falha no Actions é P0 até triagem, correção, reexecução e registro em issue/PR.

## Proteção de `main`

Configurada via GitHub API: merges somente por pull request com pelo menos uma aprovação; `verify` e `dependency-audit` obrigatórios e atualizados; administradores incluídos na regra; force-push e exclusão bloqueados; aprovações antigas descartadas após novo push.
## Política de builds

O job `verify` executa análise, testes e build Web para feedback rápido. O APK
Android não é gerado em pushes ou pull requests; ele é compilado somente pelo
job `release-assets` após uma tag SemVer (`vX.Y.Z`) e checks obrigatórios verdes.
Isso evita trabalho redundante e mantém o artefato Android associado a uma
versão publicada.
