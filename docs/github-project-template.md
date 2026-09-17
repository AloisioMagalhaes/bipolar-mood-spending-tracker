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

## Índice documental e rastreabilidade

Este índice é a fonte de navegação do Project. Cada issue ou PR deve apontar para pelo menos um documento aplicável e registrar `Evidence URL`, impacto e critério de aceite. Documentos normativos prevalecem sobre rascunhos; alterações de requisitos, segurança, privacidade ou governança exigem atualização do documento correspondente no mesmo changeset.

### Entrada do produto e requisitos

- [README do produto](../README.md) — visão, capacidades, limites e fluxo de entrega.
- [Termo de requisitos do sistema (TRS)](01-TRS.md) — requisitos, decisões e referências.
- [Backlog](backlog.md) — trabalho planejado e rastreabilidade de pendências.
- [Prompt de produção](prompt-producao.md) — instruções operacionais para desenvolvimento assistido.
- [Limitações das ferramentas](tooling-limitations.md) — restrições conhecidas e impacto na evidência.

### UX, UI e acessibilidade

- [Auditoria UX/UI 2026-09](ux/audit-2026-09.md) — achados, prioridades e critérios de aceite.
- [Design system](ux/design-system.md) — Material 3, tokens, contraste e movimento reduzido.
- [Sketches UX mobile-first](ux/sketches.md) — fluxos, estados vazios, consentimento e timeline.

### Governança, processo e compliance

- [Regras de workflow](workflow-rules.md) — conflitos, PRs, automerge, rastreabilidade e CodeQL.
- [Gates de governança](governance-gates.md) — requisitos antes de backend ou sincronização.
- [Matriz de autorização](authorization-matrix.md) — papéis e acesso por recurso.
- [Privacidade e LGPD](privacy-lgpd.md) — minimização, consentimento e direitos do titular.
- [Checklist ético](research-ethics-checklist.md) — bloqueios e aprovações formais.
- [Política de segurança](../SECURITY.md) — reporte e tratamento de vulnerabilidades.

### Segurança e incidentes

- [Threat model](threat-model.md) — ativos, ameaças, fronteiras e controles.
- [CI de segurança](ci-security.md) — CodeQL, OSV, Gitleaks e gates automatizados.
- [Auditoria Sourcery](sourcery-audit.md) — classificação e resposta a sugestões automatizadas.
- [Incidente Gitleaks de 2026-09-15](incidents/2026-09-15-gitleaks.md) — causa, impacto e resolução registrada.

### Pesquisa, evidências e validação

- [Triagem da literatura](literature-screening.md) — escopo e limitações da busca bibliográfica.
- [Matriz de evidências](evidence-matrix.md) — afirmação → fonte → decisão.
- [Protocolo de validação](research-validation.md) — métricas e limites das conclusões.
- [Protocolo operacional do estudo](research-study-protocol.md) — desenho, participantes e gates éticos.
- [Plano de dados e análise](research-data-analysis.md) — variáveis, missingness e métricas pré-especificadas.

### Arquitetura e implantação

- [C4 — contexto](diagrams/c4/context.md)
- [C4 — contêineres](diagrams/c4/container.md)
- [C4 — componentes](diagrams/c4/component.md)
- [C4 — código](diagrams/c4/code.md)
- [C4 — implantação](diagrams/c4/deployment.md)
- [UML — índice e modelos](diagrams/uml/index.md) — casos de uso, classes, sequência, estados, atividades, componentes, implantação e pacotes.

## Convenção de gestão documental

1. Toda mudança começa em Issue com `Type`, `Area`, `Priority`, impacto, evidência e definição de pronto.
2. PR deve referenciar a Issue, atualizar documentos afetados e declarar itens não aplicáveis com justificativa.
3. `P0` bloqueia promoção; `P1` requer plano e responsável; `P2/P3` podem entrar no roadmap.
4. Código, testes, CI, diagramas, releases e documentação devem permanecer coerentes no mesmo changeset quando representam a mesma decisão.
5. Nunca registrar dados clínicos reais, tokens, credenciais ou identificadores pessoais em Issues, PRs, logs, screenshots ou artefatos.
6. Um documento deve indicar escopo, data, fonte, decisão, responsável e próxima revisão quando aplicável.
7. Fechamento de Issue exige evidência: teste, relatório, screenshot/trace sanitizado ou link para decisão aprovada.
