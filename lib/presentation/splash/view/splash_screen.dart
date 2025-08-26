import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//import 'package:get/get.dart';
import 'package:todo_app/core/themes/app_colors.dart';

import 'package:todo_app/core/themes/app_text_style.dart';
import 'package:todo_app/routes/app_routes.dart';
//import 'package:todo_app/presentation/splash/controller/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //final SplashScreenController controller=Get.put(SplashScreenController());
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 2)); // splash delay
    final session = supabase.auth.currentSession;
    if (session != null) {
      // already logged in
      Get.toNamed(AppRoutes.homeScreen);
    } else {
      Get.toNamed(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200.h,
                  width: 200.w,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Do It',
                style: AppTextStyle.bold.copyWith(
                  fontSize: 40.sp,
                  color: AppColors.primaryColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
