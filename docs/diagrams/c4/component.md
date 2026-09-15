# C4 — Componentes

```mermaid
flowchart LR
  Timeline --> MoodService
  Timeline --> SpendingService
  ClinicianDashboard --> CorrelationView
  ConsentScreen --> ConsentService
  ConsentService --> ConsentScope[Escopos: mood, spending, link, export]
  MoodService --> SyncService
  SpendingService --> SyncService
  SyncService --> Repository[(Repository)]
  StateLoader --> SafeDecoder
  StateLoader --> PlatformGuard
  ExportService --> Clipboard[Flutter Clipboard]
  LinkDialog --> ProfessionalLink
  LinkDialog --> ConsentScope
  Timeline --> TrendBar
  TrendBar --> Semantics[Flutter Semantics]
  DesignSystem --> MoodScaleTile
  MoodScaleTile --> Semantics[Flutter Semantics]
```
