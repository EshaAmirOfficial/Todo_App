// lib/presentation/auth/view/signup_screen.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/services/auth_service.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_style.dart';
import '../../../routes/app_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final authService = AuthService();
  bool _isObscure = true;

  void signUp() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final response = await authService.signUpWithEmailPassword(
        fullName,
        email,
        password,
      );
      Get.back(); // Dismiss the loading dialog

      // Check if the signup was successful. The session will be in the response.
      if (response.user != null) {
        Get.snackbar(
          'Success!',
          'You have successfully signed up and are now logged in.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(AppRoutes.homeScreen);
      }
    } catch (e) {
      Get.back(); // Dismiss the loading dialog on error
      Get.snackbar(
        'Sign Up Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 150.h,
                          width: 150.w,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Welcome back to Do It',
                        style: AppTextStyle.bold.copyWith(
                          fontSize: 24.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        'Create an account to join us now!',
                        style: AppTextStyle.semiBold.copyWith(
                          fontSize: 20.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _buildlable('FullName'),
                      SizedBox(height: 10.h),
                      _buildTextField(
                        'Enter fullname',
                        _fullNameController,
                        false,
                      ),
                      SizedBox(height: 10.h),
                      _buildlable('Email'),
                      SizedBox(height: 10.h),
                      _buildTextField('Enter email', _emailController, false),
                      SizedBox(height: 10.h),
                      _buildlable('Password'),
                      SizedBox(height: 10.h),
                      _buildTextField(
                        'Enter password',
                        _passwordController,
                        true,
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 52.h,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: AppTextStyle.semiBold.copyWith(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account ?",
                            style: AppTextStyle.regular.copyWith(
                              fontSize: 16.sp,
                              color: const Color(0xFFA0A0A0),
                            ),
                            children: [
                              TextSpan(
                                text: " sign in ",
                                style: AppTextStyle.bold.copyWith(
                                  fontSize: 16.sp,
                                  color: AppColors.primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.loginScreen);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildlable(String label) {
    return Text(
      label,
      style: AppTextStyle.regular.copyWith(
        fontSize: 16.sp,
        color: AppColors.headingColor,
      ),
    );
  }

  Widget _buildTextField(
    String hintText,
    TextEditingController controller,
    bool isPassword,
  ) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _isObscure : false,
      decoration: InputDecoration(
        fillColor: AppColors.filledColor,
        filled: true,
        hintText: hintText,
        hintStyle: AppTextStyle.regular.copyWith(
          fontSize: 16.sp,
          color: const Color(0xFFFFFFFF),
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primaryColor,
                  size: 22,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }
}
