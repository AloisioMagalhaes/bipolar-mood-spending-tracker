import 'package:flutter_test/flutter_test.dart';
import 'package:moodledger/main.dart';
void main() { testWidgets('dashboard e formulário de compra', (tester) async { await tester.pumpWidget(const MoodLedgerApp()); expect(find.text('MoodLedger'), findsOneWidget); expect(find.text('Linha do tempo'), findsOneWidget); await tester.tap(find.text('Registrar compra')); await tester.pumpAndSettle(); expect(find.text('Motivo da compra'), findsOneWidget); }); }
