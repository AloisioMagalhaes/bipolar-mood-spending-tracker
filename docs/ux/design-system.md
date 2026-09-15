# Design system nativo

O MoodLedger usa Material 3 e tokens locais em `lib/design_system.dart`. `MoodScaleTile` combina `Semantics`, `Slider` nativo e `AnimatedContainer` para feedback discreto, com duração curta e sem significado clínico. Componentes adaptativos e pequenos favorecem manutenção e rebuilds eficientes [F1–F3].

**Métrica inicial:** nenhuma tela deve exigir rolagem horizontal em 320 dp; componentes interativos devem ser operáveis por toque, teclado e leitor de tela; animações serão avaliadas em profile mode visando frames abaixo de 16 ms [F4].

Referências: Flutter, *Accessibility*, https://docs.flutter.dev/ui/accessibility; Flutter, *Best practices for adaptive design*, https://docs.flutter.dev/ui/adaptive-responsive/best-practices; Flutter, *Material Design*, https://docs.flutter.dev/ui/design/material; Flutter, *UI performance*, https://docs.flutter.dev/perf/ui-performance.

Issue #13 adiciona `TrendBar` com rótulo textual, `Semantics`, cor acompanhada de texto e preferência “Reduzir animações”, evitando que movimento ou cor sejam o único canal de informação.

O indicador de energia usa `Colors.deepOrange.shade700`, evitando o contraste insuficiente apontado pelo Sourcery no tema claro. A informação permanece redundante em texto e Semantics.
