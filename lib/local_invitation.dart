/// In-memory bilateral invitation contract for the prototype.
///
/// It is not an identity provider and must not be used for clinical sharing.
class LocalInvitation {
  LocalInvitation({required this.code, required this.expiresAt});
  final String code;
  final DateTime expiresAt;
  bool patientAccepted = false;
  bool clinicianAccepted = false;
  bool revoked = false;
  bool used = false;

  bool accept({required bool byPatient, required DateTime now}) {
    if (revoked || used || now.isAfter(expiresAt)) return false;
    if (byPatient) {
      if (patientAccepted) return false;
      patientAccepted = true;
    } else {
      if (clinicianAccepted) return false;
      clinicianAccepted = true;
    }
    if (patientAccepted && clinicianAccepted) used = true;
    return true;
  }

  void revoke() => revoked = true;
  bool get active => !revoked && !used;
}
