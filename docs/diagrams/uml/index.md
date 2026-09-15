# UML 2.x — catálogo inicial

Os 14 diagramas previstos e seus contratos estão registrados em `docs/01-TRS.md`. Cada artefato será separado em Mermaid conforme o backlog: casos de uso; classes; objetos; sequência de compra; sequência de humor; sequência de sincronização; comunicação; atividade do paciente; atividade clínica; estados do registro; estados do consentimento; componentes; implantação; pacotes.

Estado versionado: CI/CD possui pipeline de verificação, auditoria de dependências, detecção de segredos, builds Web/Android e publicação Pages. Falhas são P0 e devem atualizar este catálogo e o C4 de implantação antes do fechamento.

PR #16 adiciona StateLoader, SafeDecoder, PlatformGuard e ExportService como controles contra corrida, corrupção, persistência Web indevida e exportação sem mecanismo de transferência.
Modelo planejado: `PatientProfessionalLink`, `ConsentScope`, `MissingDataReason`, `AuditEvent` e `ExportPackage` serão entregues nas issues #11–#14.
O componente `MoodScaleTile` é a primeira unidade do design system: tokeniza escala, acessibilidade e animação de feedback, sem dependência externa.

## Artefatos baseados no código atual

1. [Casos de uso](01-use-case.mmd) · 2. [Classes](02-class.mmd) · 3. [Objetos](03-object.mmd) · 4. [Sequência compra](04-sequence-purchase.mmd) · 5. [Sequência humor](05-sequence-mood.mmd) · 6. [Sequência plataforma](06-sequence-sync.mmd) · 7. [Comunicação](07-communication.mmd) · 8. [Atividade paciente](08-activity-patient.mmd) · 9. [Atividade profissional](09-activity-clinician.mmd) · 10. [Estados registro](10-state-entry.mmd) · 11. [Estados consentimento](11-state-consent.mmd) · 12. [Componentes](12-component.mmd) · 13. [Implantação](13-deployment.mmd) · 14. [Pacotes](14-package.mmd).

Cada fonte representa somente classes, objetos e fluxos já implementados ou explicitamente marcados como plataforma/planejamento nos requisitos. Imagens SVG serão geradas no CI por Mermaid CLI quando o renderer estiver disponível.
