import 'package:flutter_test/flutter_test.dart';
import 'package:moodledger/local_authorization.dart';

void main() {
  LocalAuthorizationRequest request({
    ActorRole actor = ActorRole.clinician,
    ProtectedResource resource = ProtectedResource.mood,
    bool owner = false,
    bool link = true,
    bool consent = true,
  }) => LocalAuthorizationRequest(
    actor: actor,
    resource: resource,
    isOwner: owner,
    linkActive: link,
    consentActive: consent,
  );

  test('permite paciente acessar o próprio autorrelato', () {
    expect(
      mayAccessLocally(request(actor: ActorRole.patient, owner: true)),
      isTrue,
    );
  });

  test('nega profissional sem vínculo ou consentimento vigente', () {
    expect(mayAccessLocally(request(link: false)), isFalse);
    expect(mayAccessLocally(request(consent: false)), isFalse);
  });

  test('nega administrador e paciente em recurso de terceiro', () {
    expect(mayAccessLocally(request(actor: ActorRole.administrator)), isFalse);
    expect(mayAccessLocally(request(actor: ActorRole.patient)), isFalse);
  });

  test('profissional não altera consentimento ou vínculo', () {
    expect(
      mayAccessLocally(request(resource: ProtectedResource.consent)),
      isFalse,
    );
    expect(
      mayAccessLocally(request(resource: ProtectedResource.link)),
      isFalse,
    );
  });
}
