# CI, segurança e publicação

O workflow executa análise Dart, CodeQL dos workflows GitHub Actions, testes com cobertura, build Web, OSV Scanner e Gitleaks em container. O APK Android é gerado apenas em tags SemVer pelo fluxo de release. O workflow Pages publica `build/web` com `base-href` compatível com o nome do repositório. Falhas de segurança bloqueiam a entrega. APKs são artefatos; assinatura de produção será configurada somente com segredo externo e processo de release aprovado. Qualquer falha no Actions é P0 até triagem, correção, reexecução e registro em issue/PR.

## Revisão automática externa

O workflow gerenciado **GitHub Advanced Security** não é versionado neste
repositório. Se ele falhar por configuração de modelo, permissão ou serviço,
isso deve ser tratado como P0 operacional e não como aprovação de segurança.
No run de referência de 16 set. 2026, a etapa `Processing Request (Linux)`
retornou `CAPIError: 400 The requested model is not supported` ao solicitar
`claude-opus-5`; o incidente está rastreado na
[issue #89](https://github.com/AloisioMagalhaes/bipolar-mood-spending-tracker/issues/89).
O responsável pelo GitHub Advanced Security deve selecionar um modelo
suportado, confirmar a associação/permissão do agente e reexecutar o run. Até
essa evidência existir, a revisão por IA externa permanece inconclusiva; os
checks versionados CodeQL, dependency-audit, Gitleaks e testes não são
substituídos por ela.

## Promoção versionada

### Incidente do governance-gate — releases v1.0.3 e v1.0.4

Os runs `35166199286` e `35167513928` falharam antes dos builds porque a
detecção de caminhos tratava a lista de arquivos modificados com regex frágil.
O falso positivo foi corrigido em [PR #99](https://github.com/AloisioMagalhaes/bipolar-mood-spending-tracker/pull/99)
e tornado determinístico em [PR #102](https://github.com/AloisioMagalhaes/bipolar-mood-spending-tracker/pull/102),
com iteração por caminho e padrões explícitos. As tags afetadas são imutáveis;
por isso a recuperação usa a versão `v1.0.5`. O gate continua bloqueando
alterações reais de backend/sincronização sem evidência formal.

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
