class Helpers {
  // 🔤 أول حرف كابيتال
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // 📧 تحقق من الإيميل
  static bool isValidEmail(String email) {
    return RegExp(r'\S+@\S+\.\S+').hasMatch(email);
  }

  // ⏰ تحويل تاريخ
  static String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
