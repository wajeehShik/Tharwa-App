class ValidationHelper {
  ValidationHelper._();

  /// Check if email is valid
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.trim());
  }

  /// Check if a field is not empty
  static bool isNotEmpty(String value) => value.trim().isNotEmpty;

  /// Check minimum password length
  static bool isValidPassword(String password) => password.length >= 6;

  /// Format DateTime to dd/MM/yyyy
  static String formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';

  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // --- Form validator functions (return String? for TextFormField) ---

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'email_required';
    if (!isValidEmail(value)) return 'email_invalid';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'password_required';
    if (!isValidPassword(value)) return 'password_too_short';
    return null;
  }

  static String? validateNotEmpty(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'field'}_required';
    }
    return null;
  }
}
