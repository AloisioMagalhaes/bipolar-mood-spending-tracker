import 'package:flutter_test/flutter_test.dart';
import 'package:moodledger/main.dart';
void main() { testWidgets('dashboard acessível e visualização reduzida', (tester) async { await tester.pumpWidget(const MoodLedgerApp()); expect(find.text('Resumo visual'), findsOneWidget); expect(find.text('Humor autorrelatado'), findsOneWidget); final toggle = find.text('Reduzir animações'); expect(toggle, findsOneWidget); await tester.tap(toggle); await tester.pump(); expect(toggle, findsOneWidget); }); }
