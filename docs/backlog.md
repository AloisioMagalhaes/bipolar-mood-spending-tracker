# Backlog rastreável — MoodLedger

| Prioridade | Issue | Entrega |
|---|---|---|
| P0 | qualquer falha Actions | incidente, correção e C4/UML |
| P1 | #11 | persistência, ausência explícita e exportação |
| P1 | #12 | convite bilateral, consentimento e auditoria |
| P1 | #13 | visualização acessível e modo sem animação |
| P1 | #14 | protocolo de usabilidade, adesão e segurança |
| P1 | #59 | autorrelatos completos, sinais de revisão e exportação auditável |
| P1 | #56 | persistência offline e dados ausentes explícitos |
| P1 | #57 | timeline, filtros e padrões informativos |
| P1 | #58 | autenticação, autorização por recurso e auditoria server-side |
| P1 | #76/#77/#79 | gates formais e técnicos antes de backend, vínculo ou sincronização |
| P2 | #60 | corrigir descrição do pipeline Android |
| P1 | #65 | estado vazio seguro após exclusão local |
| P2 | futuro | sincronização e sensores passivos opt-in |
| P3 | futuro | modelos preditivos após validação externa |

Fluxo: issue → `feature/<slug>` → PR/develop → main → tag SemVer. Todo PR atualiza documentação e diagramas.

O gate automatizado está detalhado em [`docs/governance-gates.md`](governance-gates.md)
e mantém #76, #77 e #58 bloqueadas até as evidências formais de LGPD, ética e
threat model existirem.
