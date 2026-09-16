import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:moodledger/main.dart';

void main() {
  test(
    'MoodEntry serializa os campos de autorrelato sem classificação clínica',
    () {
      final entry = const MoodEntry(
        mood: 6,
        energy: 7,
        sleep: 8,
        irritability: 2,
        impulsivity: 3,
        medicationTaken: true,
      );
      expect(entry.toJson(), {
        'mood': 6,
        'energy': 7,
        'sleep': 8,
        'irritability': 2,
        'impulsivity': 3,
        'medicationTaken': true,
      });
    },
  );

  testWidgets('dashboard acessível e visualização reduzida', (tester) async {
    await tester.pumpWidget(const MoodLedgerApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.scrollUntilVisible(
      find.text('Resumo visual'),
      300,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('Resumo visual'), findsOneWidget);
    expect(find.text('Humor autorrelatado'), findsOneWidget);
    final toggle = find.text('Reduzir animações');
    await tester.scrollUntilVisible(
      toggle,
      300,
      scrollable: find.byType(Scrollable),
    );
    expect(toggle, findsOneWidget);
    await tester.tap(toggle);
    await tester.pump();
    expect(toggle, findsOneWidget);
  });

  testWidgets('consentimentos são granulares e exportação exige escopo', (
    tester,
  ) async {
    await tester.pumpWidget(const MoodLedgerApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.download));
    await tester.pump();
    expect(
      find.text('Ative o consentimento de exportação antes de continuar.'),
      findsOneWidget,
    );
  });

  testWidgets('exclusão local remove registros e preserva estado navegável', (
    tester,
  ) async {
    await tester.pumpWidget(const MoodLedgerApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Excluir dados locais?'), findsOneWidget);
    await tester.tap(find.text('Excluir'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Excluir dados locais?'), findsNothing);
  });

  testWidgets('vínculo exige consentimento específico', (tester) async {
    await tester.pumpWidget(const MoodLedgerApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.people_outline));
    await tester.pump();
    expect(
      find.text('Ative o consentimento de vínculo antes de continuar.'),
      findsOneWidget,
    );
  });
}
