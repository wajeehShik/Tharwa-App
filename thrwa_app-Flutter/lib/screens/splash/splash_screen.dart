import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/utils/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // 3-second timer for navigation to Onboarding
    Timer(const Duration(seconds: 3), () {
      // Using named route to ensure OnboardingBinding is triggered
      Get.offNamed(AppRoutes.onboarding);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular Logo Emblem
              Image.asset(
                'assets/images/logo.png',
                width: 180.w,
                height: 180.w,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10.h),
              // Arabic App Name
              Text(
                'ثروة',
                style: GoogleFonts.cairo(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3E50),
                  height: 1.2,
                ),
              ),
              // English App Name
              Text(
                'THARWA',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2D3E50),
                  letterSpacing: 4,
                ),
              ),
              SizedBox(height: 15.h),
              // Tagline
              Text(
                tr('tagline'),
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
