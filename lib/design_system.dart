import 'package:flutter/material.dart';

/// Tokens e componentes locais do MoodLedger; sem dependências externas.
abstract final class MoodLedgerTheme {
  static ThemeData data() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4055A8)),
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}

class MoodScaleTile extends StatelessWidget {
  const MoodScaleTile({super.key, required this.label, required this.value, required this.onChanged});
  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  @override
  Widget build(BuildContext context) => Semantics(
        label: '$label, valor ${value.round()} de 10',
        value: '${value.round()} de 10',
        slider: true,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
          child: Column(children: [Text('$label: ${value.round()}/10'), Slider(value: value, min: 0, max: 10, divisions: 10, onChanged: onChanged)]),
        ),
      );
}
