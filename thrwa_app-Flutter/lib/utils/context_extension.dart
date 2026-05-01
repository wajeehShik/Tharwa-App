import 'package:flutter/material.dart';

/// Localization helpers only.
/// Theme → AppTheme, Routes → AppRoutes/AppPages, Snackbar → SnackbarHelper
extension ContextExtension on BuildContext {
  List<LocalizationsDelegate<dynamic>> get localizationDelegates =>
      Localizations.of<dynamic>(this, dynamic) != null ? [] : [];
}
