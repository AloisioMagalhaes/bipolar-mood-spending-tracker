# CI, segurança e publicação

O workflow executa análise Dart, testes com cobertura, build Web, OSV Scanner e Gitleaks em container. O APK Android é gerado apenas em tags SemVer pelo fluxo de release. O workflow Pages publica `build/web` com `base-href` compatível com o nome do repositório. Falhas de segurança bloqueiam a entrega. APKs são artefatos; assinatura de produção será configurada somente com segredo externo e processo de release aprovado. Qualquer falha no Actions é P0 até triagem, correção, reexecução e registro em issue/PR.

## Promoção versionada

Toda promoção de `develop` para `main` deve ser seguida por uma tag `vMAJOR.MINOR.PATCH` no mesmo commit de release. A tag dispara o build Web e Android e publica ambos como assets na GitHub Release. O Pages é disparado pelo push do mesmo commit em `main`, pois o ambiente protegido aceita a branch de produção; assim o conteúdo publicado é idêntico ao commit versionado. A promoção não é considerada concluída enquanto a release e o Pages não estiverem verdes.

Prompt operacional: “Verifique issue, critérios, conflitos, Sourcery (`Issue`, `Triggers`, `Suggested fix`), testes, segurança e documentação; implemente em branch Gitflow, use Conventional Commits, abra PR, aguarde checks verdes, faça merge autorizado e somente então crie a tag SemVer. Em qualquer falha, pare a promoção, registre evidência e corrija antes de prosseguir.”

## Proteção de `main`

Configurada via GitHub API: merges somente por pull request com pelo menos uma aprovação; `verify` e `dependency-audit` obrigatórios e atualizados; administradores incluídos na regra; force-push e exclusão bloqueados; aprovações antigas descartadas após novo push.
## Política de builds

O job `verify` executa análise, testes e build Web para feedback rápido. O APK
Android não é gerado em pushes ou pull requests; ele é compilado somente pelo
job `release-assets` após uma tag SemVer (`vX.Y.Z`) e checks obrigatórios verdes.
Isso evita trabalho redundante e mantém o artefato Android associado a uma
versão publicada.
