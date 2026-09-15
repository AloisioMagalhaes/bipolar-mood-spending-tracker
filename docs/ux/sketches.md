# MoodLedger — sketches UX mobile-first

## Princípios

Usar Material 3 nativo, toque primeiro, componentes pequenos `const`, `SafeArea`, `MediaQuery`/layouts adaptativos e sem bloquear orientação. Essas decisões seguem as recomendações oficiais de design adaptativo e acessibilidade do Flutter [F1–F3].

## Sketch 1 — paciente / início

```text
┌─────────────────────────┐
│ MoodLedger          🔒  │
│ Como você está hoje?    │
│ Humor       ○━━━━━━ 6/10│
│ Energia     ○━━━━━━ 7/10│
│ Sono        [  7 ] horas│
│                         │
│ [ Registrar estado ]     │
│ [ Registrar compra ]     │
│                         │
│ Linha do tempo           │
│ ● Humor 6 · energia 7   │
│ ● Alimentação R$ 89,90  │
└─────────────────────────┘
```

## Sketch 2 — compra contextual

```text
┌─────────────────────────┐
│ Registrar compra         │
│ Valor [             ]    │
│ Categoria [          ▼ ] │
│ O que motivou?           │
│ [                     ]  │
│ Foi impulsiva? [  ]      │
│ [Cancelar] [Salvar]      │
└─────────────────────────┘
```

## Sketch 3 — profissional

```text
┌──────────────┬──────────┐
│ Pacientes    │ Revisão  │
│ Ana • ativo  │ Humor ─╮  │
│ João • novo  │ Gastos ═╪│
│              │ Sono  ─╯ │
│              │ [Contexto]│
└──────────────┴──────────┘
```

## Representação emocional

O MVP usa escalas contínuas de humor/energia e linguagem do próprio paciente, inspiradas em estudos de EMA que usaram escalas visuais 0–100 [A1]. Emojis e cores serão complementares, nunca o único canal, pois podem carregar ambiguidades culturais e não devem rotular “fase bipolar”. O sistema exibirá “autorrelato” e “padrão para revisão”, não “mania/depressão”. Visualizações temporais favorecem comparação e autorreflexão [A2].

## Acesso e vinculação

1. Profissional cria conta verificada e gera código/QR de convite com expiração.
2. Paciente informa o código, lê o escopo e concede consentimento granular.
3. Profissional vê somente pacientes com vínculo ativo.
4. Paciente pode revogar o vínculo; ambos veem auditoria.
5. Alternativamente, paciente gera convite e o profissional aceita.

Nenhum vínculo deve ser criado unilateralmente sem aceite do outro lado.

Implementação atual: `LinkDialog` aceita um código informado pelo paciente e exige confirmação explícita antes de criar `ProfessionalLink`; “Revogar” remove o vínculo da sessão. Persistência remota, expiração criptográfica e auditoria server-side permanecem pendentes da issue #12.

## Referências

- **F1:** Flutter. *Adaptive and responsive design*. https://docs.flutter.dev/ui/adaptive-responsive.
- **F2:** Flutter. *Accessibility*. https://docs.flutter.dev/ui/accessibility.
- **F3:** Flutter. *Best practices for adaptive design*. https://docs.flutter.dev/ui/adaptive-responsive/best-practices.
- **A1:** Depp et al. *A Smartphone App to Monitor Mood Symptoms in Bipolar Disorder: Development and Usability Study*. JMIR, 2020. https://pmc.ncbi.nlm.nih.gov/articles/PMC7539167/.
- **A2:** Snyder; Chi. *Visually Encoding the Lived Experience of Bipolar Disorder*. CHI, 2019. https://stephen.voida.com/uploads/Publications/Publications/snyder-chi2019.pdf.
