// ============================================================
// Zawiyah — Collection Model
// lib/features/collections/domain/collection.dart
// ============================================================

class Collection {
  final String id;
  final String title;
  final DateTime createdAt;
  final bool isSharedAnonymously;
  final List<String> contentIds;

  const Collection({
    required this.id,
    required this.title,
    required this.createdAt,
    this.isSharedAnonymously = false,
    this.contentIds = const [],
  });

  Collection copyWith({List<String>? contentIds}) => Collection(
        id: id,
        title: title,
        createdAt: createdAt,
        isSharedAnonymously: isSharedAnonymously,
        contentIds: contentIds ?? this.contentIds,
      );
}
