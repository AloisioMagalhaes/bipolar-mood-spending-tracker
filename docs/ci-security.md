# CI, segurança e publicação

O workflow executa análise Dart, testes com cobertura, build Web, APK debug/release, OSV Scanner e Gitleaks. O workflow Pages publica `build/web` com `base-href` compatível com o nome do repositório. Falhas de segurança bloqueiam a entrega. APKs são artefatos; assinatura de produção será configurada somente com segredo externo e processo de release aprovado.
