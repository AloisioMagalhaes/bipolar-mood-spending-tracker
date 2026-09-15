# MoodLedger

MoodLedger é um protótipo Flutter Web/Android para registrar, com consentimento, gastos, motivos autorrelatados e indicadores subjetivos de estado mental em pessoas com transtorno bipolar. Organiza informações para revisão longitudinal entre paciente e profissional; não diagnostica, não classifica automaticamente fases, não recomenda medicamentos e não substitui atendimento clínico.

## Visão de engenharia

O sistema é um cliente Flutter multiplataforma, com Material 3, componentes reutilizáveis e persistência local no Android. O Web funciona como demonstração sem persistência clínica. O domínio modela `SpendingEntry`, `MoodEntry` e `ProfessionalLink`; o vínculo atual é demonstrativo, com código, consentimento explícito e revogação local.

Decisões de requisitos, limites clínicos, métricas e referências: [docs/01-TRS.md](docs/01-TRS.md). UX mobile-first, acessibilidade e movimento reduzido: [docs/ux/design-system.md](docs/ux/design-system.md) e [docs/ux/sketches.md](docs/ux/sketches.md).

## Capacidades implementadas

- Registro de gastos, motivos e indicadores subjetivos de humor, energia, pensamentos, impulsividade e sono.
- Resumo visual com rótulos numéricos, `Semantics`, contraste redundante e redução de animações.
- Persistência local Android tolerante a JSON inválido e exportação JSON para clipboard.
- Vínculo demonstrativo profissional–paciente com consentimento granular, revogável e auditável localmente.
- Testes widget, análise estática, builds Web/Android e auditoria de dependências no GitHub Actions.

## Arquitetura e rastreabilidade

- [Diagramas C4](docs/diagrams/c4/): contexto, contêineres, componentes, código e implantação.
- [Diagramas UML 2.x](docs/diagrams/uml/): 14 modelos Mermaid e SVGs renderizados.
- [Backlog](docs/backlog.md), [auditoria Sourcery](docs/sourcery-audit.md) e [regras de workflow](docs/workflow-rules.md).
- [Governança LGPD](docs/privacy-lgpd.md): classificação, minimização, consentimento e direitos do titular.
- [Threat model e Zero Trust](docs/threat-model.md): ativos, STRIDE, fronteiras e controles futuros.

## Qualidade e entrega

O fluxo usa `issue -> feature/<slug> -> pull request -> develop -> main -> tag SemVer`. `main` exige pull request, checks `verify` e `dependency-audit`, bloqueia force-push/exclusão e permite revisão do proprietário quando não houver colaborador externo. Falhas do Actions interrompem a promoção até correção documentada.

Tags SemVer publicam APK e pacote Web em [GitHub Releases](https://github.com/AloisioMagalhaes/bipolar-mood-spending-tracker/releases); pushes em `main` atualizam o [GitHub Pages](https://aloisiomagalhaes.github.io/bipolar-mood-spending-tracker/).

## Desenvolvimento local

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
flutter run -d <android-device>
```

Dependências são mantidas no mínimo: Dart/Flutter SDK e `shared_preferences` para persistência local Android. Novas dependências exigem justificativa e atualização documental.

## Segurança, ética e limitações

Não use dados clínicos reais neste estágio. O protótipo não possui backend, autenticação, auditoria server-side, sincronização clínica ou validação externa suficiente para uso assistencial. Consulte [SECURITY.md](SECURITY.md), [docs/ci-security.md](docs/ci-security.md) e a bibliografia ABNT em [docs/01-TRS.md](docs/01-TRS.md).

## Licença e referências

Consulte [LICENSE](LICENSE). Afirmações não relacionadas ao código devem permanecer acompanhadas de fonte identificável no próprio documento ou em sua bibliografia.
