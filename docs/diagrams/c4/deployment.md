# C4 — Implantação

```mermaid
flowchart LR
  Dev[Push/PR] --> Actions[GitHub Actions]
  Actions --> Security[OSV + Gitleaks]
  Actions --> Tests[Analyze + tests + coverage]
  Actions --> Builds[Flutter Web + Android]
  Builds --> Pages[GitHub Pages]
  Builds --> Artifacts[Actions artifacts / Releases]
```

Qualquer falha em Security, Tests ou Builds bloqueia a publicação.

P0 operacional: falha → issue de incidente → branch corretiva → PR → checks verdes → atualização UML/C4 → promoção.
