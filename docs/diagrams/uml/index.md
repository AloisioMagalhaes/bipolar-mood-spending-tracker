# UML 2.x — catálogo inicial

Os 14 diagramas previstos e seus contratos estão registrados em `docs/01-TRS.md`. Cada artefato será separado em Mermaid conforme o backlog: casos de uso; classes; objetos; sequência de compra; sequência de humor; sequência de sincronização; comunicação; atividade do paciente; atividade clínica; estados do registro; estados do consentimento; componentes; implantação; pacotes.

Estado versionado: CI/CD possui pipeline de verificação, auditoria de dependências, detecção de segredos, builds Web/Android e publicação Pages. Falhas são P0 e devem atualizar este catálogo e o C4 de implantação antes do fechamento.

PR #16 adiciona StateLoader, SafeDecoder, PlatformGuard e ExportService como controles contra corrida, corrupção, persistência Web indevida e exportação sem mecanismo de transferência.
