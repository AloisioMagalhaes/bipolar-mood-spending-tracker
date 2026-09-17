# GitHub Project — MoodLedger UX/UI e qualidade

Este arquivo é um template reproduzível para configurar um GitHub Project. A configuração remota deve ser feita manualmente pelo proprietário ou por automação autorizada.

## Views

| View | Layout | Filtro/uso |
|---|---|---|
| Backlog UX/UI | Table | `is:open`, grupo por Area |
| Delivery Kanban | Board | Status: Triage, Ready, In progress, Review, Verify, Done |
| Roadmap | Roadmap | Target date e Milestone |
| Quality & Risk | Table | Accessibility, Performance, Privacy, Clinical-safety |
| Discovery | Board | Hipóteses, sketches, evidências e testes |

## Campos

`Status`, `Priority` (P0–P3), `Area`, `Type`, `User value`, `Effort`, `Risk`, `Target date`, `Milestone`, `Evidence URL`, `Definition of done`.

## Labels recomendados

`area:ux`, `area:ui`, `area:a11y`, `area:performance`, `area:privacy`, `area:clinical-safety`, `platform:web`, `platform:android`, `type:bug`, `type:feature`, `type:research`, `type:docs`, `priority:p0`, `priority:p1`, `needs-evidence`.

## Automação

- issue nova → `Triage`;
- PR aberta → `Review`;
- PR merged → `Verify`;
- smoke test de deploy aprovado → `Done`;
- check falho → `needs-fix` e `In progress`.

Projects permite views Table/Board/Roadmap, campos, filtros, automações e insights. Um projeto existente pode ser copiado como template preservando views, campos, rascunhos, workflows e insights: [GitHub Docs](https://docs.github.com/en/issues/planning-and-tracking-with-projects/creating-projects/copying-an-existing-project).
