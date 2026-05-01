import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isOutlined;
  final Color? color;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.isOutlined = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: (color ?? AppColors.primary).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child:
          isOutlined
              ? OutlinedButton(
                onPressed: isLoading ? null : onTap,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: color ?? AppColors.primary,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: _child(color ?? AppColors.primary),
              )
              : ElevatedButton(
                onPressed: isLoading ? null : onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color ?? AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: _child(Colors.white),
              ),
    );
  }

  Widget _child(Color textColor) {
    if (isLoading) {
      return SizedBox(
        width: 22.w,
        height: 22.h,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }
    return Text(
      label,
      style: GoogleFonts.cairo(
        color: textColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
