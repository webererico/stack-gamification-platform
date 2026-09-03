/// Deterministic Firestore-safe document id derived from a skill's display
/// name, e.g. "Gerenciamento de Estado" -> "gerenciamento-de-estado".
abstract class SkillId {
  static String fromName(String name) {
    final slug = name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    return slug.isEmpty ? 'skill' : slug;
  }
}
