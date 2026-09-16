import 'package:flutter_test/flutter_test.dart';
import 'package:moodledger/local_invitation.dart';

void main() {
  final now = DateTime(2026, 9, 16, 12);

  test('exige aceite bilateral e torna o convite de uso único', () {
    final invitation = LocalInvitation(
      code: 'demo-123',
      expiresAt: now.add(const Duration(minutes: 10)),
    );
    expect(invitation.accept(byPatient: true, now: now), isTrue);
    expect(invitation.used, isFalse);
    expect(invitation.accept(byPatient: false, now: now), isTrue);
    expect(invitation.used, isTrue);
    expect(invitation.accept(byPatient: true, now: now), isFalse);
  });

  test('rejeita convite expirado ou revogado', () {
    final expired = LocalInvitation(code: 'expired', expiresAt: now);
    expect(
      expired.accept(byPatient: true, now: now.add(const Duration(seconds: 1))),
      isFalse,
    );
    final revoked = LocalInvitation(
      code: 'revoked',
      expiresAt: now.add(const Duration(minutes: 10)),
    )..revoke();
    expect(revoked.accept(byPatient: true, now: now), isFalse);
  });

  test('não permite o mesmo participante aceitar duas vezes', () {
    final invitation = LocalInvitation(
      code: 'repeat',
      expiresAt: now.add(const Duration(minutes: 10)),
    );
    expect(invitation.accept(byPatient: true, now: now), isTrue);
    expect(invitation.accept(byPatient: true, now: now), isFalse);
  });
}
