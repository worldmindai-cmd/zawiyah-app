// ============================================================
// Zawiyah — A'mal Content Model
// lib/features/morning_aamal/domain/amal_models.dart
//
// Structured content model so A'mal routines are DATA, not hardcoded
// per-screen widgets -- matching the "everything becomes reusable
// objects" architecture principle. The same AmalBlock/AmalSection
// types will serve Friday A'mal, Muharram mode, etc. later, not just
// Morning A'mal.
// ============================================================

enum AmalBlockKind { action, note, list, textItem, group }

/// A single block within a section. Only the fields relevant to
/// `kind` are populated -- e.g. a `textItem` block uses arabic/
/// transliteration/translation/maxCount/contentId, while a `list`
/// block only uses `listItems`.
class AmalBlock {
  final AmalBlockKind kind;
  final String? label;
  final String? text; // for action / note
  final List<String>? listItems; // for list
  final String? arabic; // for textItem
  final String? transliteration; // for textItem
  final String? translation; // for textItem
  final int? maxCount; // for textItem -- null means no counter, just a du'a
  final String? contentId; // required if maxCount is set (persistence key)
  final bool isRed; // for textItem -- e.g. the La'nat block
  final List<AmalBlock>? children; // for group -- nested textItems

  const AmalBlock._({
    required this.kind,
    this.label,
    this.text,
    this.listItems,
    this.arabic,
    this.transliteration,
    this.translation,
    this.maxCount,
    this.contentId,
    this.isRed = false,
    this.children,
  });

  const AmalBlock.action(String text)
      : this._(kind: AmalBlockKind.action, text: text);

  const AmalBlock.note(String text)
      : this._(kind: AmalBlockKind.note, text: text);

  const AmalBlock.list(List<String> items)
      : this._(kind: AmalBlockKind.list, listItems: items);

  const AmalBlock.textItem({
    String? label,
    required String arabic,
    required String transliteration,
    String? translation,
    int? maxCount,
    String? contentId,
    bool isRed = false,
  }) : this._(
          kind: AmalBlockKind.textItem,
          label: label,
          arabic: arabic,
          transliteration: transliteration,
          translation: translation,
          maxCount: maxCount,
          contentId: contentId,
          isRed: isRed,
        );

  const AmalBlock.group(String label, List<AmalBlock> children)
      : this._(kind: AmalBlockKind.group, label: label, children: children);
}

class AmalSection {
  final String id;
  final String title;
  final List<AmalBlock> blocks;
  final bool initiallyOpen;

  const AmalSection({
    required this.id,
    required this.title,
    required this.blocks,
    this.initiallyOpen = false,
  });
}

/// Flattens every textItem block (including those nested inside
/// groups) across a list of sections, keyed by contentId. Used by
/// Collections to look up and render a specific item by ID, since a
/// collection only stores content IDs, never duplicating the content
/// itself (per the Offline Content Architecture decision).
Map<String, AmalBlock> flattenTextItemsById(List<AmalSection> sections) {
  final result = <String, AmalBlock>{};
  void visit(AmalBlock block) {
    if (block.kind == AmalBlockKind.textItem && block.contentId != null) {
      result[block.contentId!] = block;
    }
    if (block.kind == AmalBlockKind.group && block.children != null) {
      for (final child in block.children!) {
        visit(child);
      }
    }
  }

  for (final section in sections) {
    for (final block in section.blocks) {
      visit(block);
    }
  }
  return result;
}
