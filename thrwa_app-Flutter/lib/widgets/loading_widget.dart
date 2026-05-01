import 'package:flutter/material.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;

  const LoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
      ),
    );
  }
}
