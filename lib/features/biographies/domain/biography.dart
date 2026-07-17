// ============================================================
// Zawiyah — Biography Model
// lib/features/biographies/domain/biography.dart
//
// Who/What/When/Where/Why/How structure per Master Spec 4.8.
// needsReview=true means content is placeholder pending sourcing --
// per spec: "use clearly labelled sample/placeholder content and
// prevent unsupported religious claims." No fabricated historical
// detail should ever be added without this flag being cleared after
// genuine sourcing/review.
// ============================================================

class Biography {
  final String id;
  final String name;
  final String who;
  final String what;
  final String when;
  final String where;
  final String why;
  final String how;
  final bool needsReview;

  const Biography({
    required this.id,
    required this.name,
    required this.who,
    required this.what,
    required this.when,
    required this.where,
    required this.why,
    required this.how,
    this.needsReview = true,
  });
}
