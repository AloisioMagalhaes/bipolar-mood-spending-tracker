/// Policy contract for the local prototype only.
///
/// This does not authenticate identities or protect a remote resource. A real
/// backend must enforce the same decisions server-side with RLS and audit.
enum ActorRole { patient, clinician, administrator }

enum ProtectedResource { mood, spending, consent, link }

class LocalAuthorizationRequest {
  const LocalAuthorizationRequest({
    required this.actor,
    required this.resource,
    required this.isOwner,
    required this.linkActive,
    required this.consentActive,
  });
  final ActorRole actor;
  final ProtectedResource resource;
  final bool isOwner;
  final bool linkActive;
  final bool consentActive;
}

bool mayAccessLocally(LocalAuthorizationRequest request) {
  if (request.actor == ActorRole.administrator) return false;
  if (request.actor == ActorRole.patient && request.isOwner) return true;
  return request.actor == ActorRole.clinician &&
      request.linkActive &&
      request.consentActive &&
      (request.resource == ProtectedResource.mood ||
          request.resource == ProtectedResource.spending);
}
