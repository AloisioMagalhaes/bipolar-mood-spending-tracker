# MoodLedger

Aplicativo Flutter Web/Android para registro consentido e revisão longitudinal de gastos e estado mental em pessoas com transtorno bipolar. É uma ferramenta de apoio à decisão clínica, não um instrumento diagnóstico.

## Estado

Baseline Flutter criada. Requisitos e arquitetura: [docs/01-TRS.md](docs/01-TRS.md). Diagramas C4: [docs/diagrams/c4](docs/diagrams/c4). Limitações de ferramentas: [docs/tooling-limitations.md](docs/tooling-limitations.md).

## Desenvolvimento

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
flutter run -d <android-device>
```

## Segurança

Não use dados clínicos reais neste estágio. Consulte [SECURITY.md](SECURITY.md) antes de configurar backend, autenticação ou dados de estudo.

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
