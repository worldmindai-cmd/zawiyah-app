// ============================================================
// Zawiyah — User Role
// lib/features/onboarding/domain/user_role.dart
//
// Matches Constitution Article IV exactly (adopted from ChatGPT's
// role list, which aligned to the Constitution better than Claude's
// original 5-role draft). Role affects suggested content only, never
// theological access. Can be changed later in Settings.
// ============================================================

enum UserRole { beginner, child, parent, teen, adult, student, scholar }

extension UserRoleInfo on UserRole {
  String get label {
    switch (this) {
      case UserRole.beginner:
        return 'Beginning my journey';
      case UserRole.child:
        return 'Child / Young Zawiyah';
      case UserRole.parent:
        return 'Parent / Family';
      case UserRole.teen:
        return 'Teenager';
      case UserRole.adult:
        return 'Daily worshipper';
      case UserRole.student:
        return 'Student of knowledge';
      case UserRole.scholar:
        return 'Scholar / researcher';
    }
  }

  String get subtitle {
    switch (this) {
      case UserRole.beginner:
        return 'A gentle teacher, one step at a time.';
      case UserRole.child:
        return 'Age-appropriate learning with a parent or guardian.';
      case UserRole.parent:
        return 'Shared worship, stories and family learning.';
      case UserRole.teen:
        return 'Questions, learning and habits for life.';
      case UserRole.adult:
        return 'A practical spiritual companion.';
      case UserRole.student:
        return 'Structured learning and transparent sources.';
      case UserRole.scholar:
        return 'An organised reference companion.';
    }
  }

  String get storageKey => name;

  static UserRole fromStorageKey(String? key) {
    return UserRole.values.firstWhere(
      (r) => r.storageKey == key,
      orElse: () => UserRole.adult,
    );
  }
}
