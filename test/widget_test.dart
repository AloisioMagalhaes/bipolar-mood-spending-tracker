import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodledger/main.dart';
void main() { testWidgets('dashboard e vínculo profissional com consentimento', (tester) async { await tester.pumpWidget(const MoodLedgerApp()); expect(find.text('Linha do tempo'), findsOneWidget); await tester.tap(find.byTooltip('Vincular profissional')); await tester.pumpAndSettle(); expect(find.text('Vincular profissional'), findsOneWidget); await tester.enterText(find.byType(TextField).first, 'ABC123'); await tester.tap(find.byType(CheckboxListTile)); await tester.pump(); await tester.tap(find.text('Vincular')); await tester.pumpAndSettle(); expect(find.textContaining('Código ABC123'), findsOneWidget); }); }
