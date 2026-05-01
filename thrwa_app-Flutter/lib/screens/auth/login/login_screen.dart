import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:thrawa_app/controllers/auth/auth_controller.dart';
import 'package:thrawa_app/utils/routes/app_routes.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:thrawa_app/utils/validators/validation_helper.dart';
import 'package:thrawa_app/widgets/custom_button.dart';
import 'package:thrawa_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  AuthController get _controller => Get.find<AuthController>();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _controller.login(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    // 3D Safe Icon
                    Center(
                      child: Image.asset(
                        'assets/images/safe_icon.png',
                        height: 180.h,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.lock_person,
                            size: 100.sp,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Title
                    Text(
                      tr('welcome_back'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // Subtitle
                    Text(
                      tr('login_subtitle'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // Form Container
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(25.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: tr('email_or_phone'),
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.person_outline,
                            validator: ValidationHelper.validateEmail,
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            hint: tr('password'),
                            controller: _passwordCtrl,
                            obscureText: _obscure,
                            prefixIcon: Icons.lock_outline,
                            validator: ValidationHelper.validatePassword,
                            textInputAction: TextInputAction.done,
                            suffix: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.textSecondary,
                                size: 20.sp,
                              ),
                              onPressed:
                                  () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Obx(
                            () => CustomButton(
                              label: tr('login'),
                              onTap: _submit,
                              isLoading: _controller.isLoading.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Fingerprint Icon (Visual only)
                    Icon(
                      Icons.fingerprint,
                      size: 50.sp,
                      color: AppColors.textSecondary.withOpacity(0.5),
                    ),
                    SizedBox(height: 20.h),
                    // Links
                    TextButton(
                      onPressed: () {
                        // Forgot password logic
                      },
                      child: Text(
                        tr('forgot_password'),
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.register),
                      child: Text(
                        tr('create_new_account'),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
