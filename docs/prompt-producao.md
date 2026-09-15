# Prompt operacional — produção MoodLedger

Use este prompt ao iniciar cada tarefa Codex:

```text
Trabalhe no MoodLedger usando Gitflow: issue -> feature/<slug> -> PR -> develop -> main -> tag SemVer. Use Conventional Commits. Nunca faça push direto em main sem checks verdes.

Antes de codificar, leia docs/01-TRS.md, docs/ux/sketches.md, docs/ci-security.md e os diagramas C4/UML. Toda afirmação não-código deve ter referência ABNT rastreável no mesmo documento ou na bibliografia.

Regra de dependências: usar apenas Dart/Flutter SDK e pacotes oficiais indispensáveis. Justifique cada dependência nova; preferir widgets Material 3, APIs nativas, `AnimatedBuilder`, `AnimatedContainer`, `Semantics`, `LayoutBuilder`, `SafeArea` e `MediaQuery`.

Planejamento obrigatório em ordem: (1) issue e critérios; (2) impacto no modelo; (3) sketch UX mobile-first; (4) atualização C4/UML; (5) implementação mínima; (6) testes unitários/widget/integração; (7) acessibilidade; (8) performance profile; (9) segurança; (10) PR com links; (11) merge; (12) tag/release.

Trate qualquer falha do GitHub Actions como P0: interrompa a promoção, abra/atualize issue, registre causa, impacto, correção e evidência, atualize C4/UML, corrija em branch própria e só prossiga após workflow verde.

Para saúde mental: não diagnostique, não classifique automaticamente fase bipolar, não recomende medicamento e não substitua profissional. Use “autorrelato”, “tendência” e “padrão para revisão”. Consentimento é granular, revogável e auditável.

Ao finalizar, informe arquivos, métricas, comandos, status, links para issue/PR/run/release e limitações.
```
