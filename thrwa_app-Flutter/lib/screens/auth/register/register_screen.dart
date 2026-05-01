import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:thrawa_app/controllers/auth/auth_controller.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:thrawa_app/utils/validators/validation_helper.dart';
import 'package:thrawa_app/widgets/custom_button.dart';
import 'package:thrawa_app/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  bool _obscure = true;

  AuthController get _controller => Get.find<AuthController>();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_passwordCtrl.text != _confirmPasswordCtrl.text) {
      Get.snackbar(tr('error'), tr('passwords_not_match'));
      return;
    }
    _controller.register(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: Get.back,
        ),
      ),
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
                    SizedBox(height: 20.h),
                    // Title
                    Text(
                      tr('register'),
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
                      tr('create_new_account'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 32.h),
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
                            hint: tr('full_name'),
                            controller: _nameCtrl,
                            prefixIcon: Icons.person_outline,
                            validator:
                                (v) => ValidationHelper.validateNotEmpty(
                                  v,
                                  fieldName: tr('full_name'),
                                ),
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            hint: tr('email_or_phone'),
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.email_outlined,
                            validator: ValidationHelper.validateEmail,
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            hint: tr('password'),
                            controller: _passwordCtrl,
                            obscureText: _obscure,
                            prefixIcon: Icons.lock_outline,
                            validator: ValidationHelper.validatePassword,
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
                          SizedBox(height: 16.h),
                          CustomTextField(
                            hint: tr('confirm_password'),
                            controller: _confirmPasswordCtrl,
                            obscureText: _obscure,
                            prefixIcon: Icons.lock_reset_outlined,
                            textInputAction: TextInputAction.done,
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return tr('confirm_password_required');
                              if (v != _passwordCtrl.text)
                                return tr('passwords_not_match');
                              return null;
                            },
                          ),
                          SizedBox(height: 24.h),
                          Obx(
                            () => CustomButton(
                              label: tr('register'),
                              onTap: _submit,
                              isLoading: _controller.isLoading.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr('already_have_account'),
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: Get.back,
                          child: Text(
                            tr('login'),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
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
