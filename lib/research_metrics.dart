/// Descriptive metrics for synthetic usability/feasibility exercises only.
/// These functions do not estimate clinical outcomes or mental states.
class ResearchParticipant {
  const ResearchParticipant({
    required this.expectedDays,
    required this.recordedDays,
    required this.expectedFields,
    required this.completedFields,
    required this.activeAtEnd,
  });
  final int expectedDays, recordedDays, expectedFields, completedFields;
  final bool activeAtEnd;
}

double adherence(ResearchParticipant p) =>
    p.expectedDays == 0 ? 0 : p.recordedDays / p.expectedDays;

double completeness(ResearchParticipant p) =>
    p.expectedFields == 0 ? 0 : p.completedFields / p.expectedFields;

double retention(List<ResearchParticipant> participants) {
  if (participants.isEmpty) return 0;
  return participants.where((p) => p.activeAtEnd).length / participants.length;
}
