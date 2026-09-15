import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodledger/main.dart';
void main() { testWidgets('dashboard acessível e visualização reduzida', (tester) async { await tester.pumpWidget(const MoodLedgerApp()); expect(find.text('Resumo visual'), findsOneWidget); expect(find.text('Humor autorrelatado'), findsOneWidget); expect(find.text('Reduzir animações'), findsOneWidget); await tester.tap(find.text('Reduzir animações')); await tester.pump(); expect(find.text('Linha do tempo'), findsOneWidget); }); }
