import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:moodledger/main.dart';
void main() {
  testWidgets('dashboard acessível e visualização reduzida', (tester) async {
    await tester.pumpWidget(const MoodLedgerApp());
    expect(find.text('Resumo visual'), findsOneWidget);
    expect(find.text('Humor autorrelatado'), findsOneWidget);
    final toggle = find.text('Reduzir animações');
    expect(toggle, findsOneWidget);
    await tester.tap(toggle);
    await tester.pump();
    expect(toggle, findsOneWidget);
  });

  testWidgets('consentimentos são granulares e exportação exige escopo', (tester) async {
    await tester.pumpWidget(const MoodLedgerApp());
    expect(find.text('Consentimentos'), findsOneWidget);
    expect(find.text('Autorrelatos'), findsOneWidget);
    expect(find.text('Gastos'), findsOneWidget);
    expect(find.text('Vínculo profissional'), findsOneWidget);
    expect(find.text('Exportação JSON'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.download));
    await tester.pump();
    expect(find.text('Ative o consentimento de exportação antes de continuar.'), findsOneWidget);
  });
}
