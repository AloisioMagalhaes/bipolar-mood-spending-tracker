import 'package:flutter_test/flutter_test.dart';
import 'package:moodledger/research_metrics.dart';

void main() {
  const participant = ResearchParticipant(
    expectedDays: 10,
    recordedDays: 8,
    expectedFields: 20,
    completedFields: 18,
    activeAtEnd: true,
  );

  test('calcula adesão e completude sem imputar estado mental', () {
    expect(adherence(participant), 0.8);
    expect(completeness(participant), 0.9);
  });

  test('calcula retenção apenas pela atividade observada', () {
    const inactive = ResearchParticipant(
      expectedDays: 10,
      recordedDays: 0,
      expectedFields: 20,
      completedFields: 0,
      activeAtEnd: false,
    );
    expect(retention([participant, inactive]), 0.5);
  });

  test('evita divisão por zero em amostras vazias', () {
    expect(
      adherence(
        const ResearchParticipant(
          expectedDays: 0,
          recordedDays: 0,
          expectedFields: 0,
          completedFields: 0,
          activeAtEnd: false,
        ),
      ),
      0,
    );
    expect(retention(const []), 0);
  });
}
