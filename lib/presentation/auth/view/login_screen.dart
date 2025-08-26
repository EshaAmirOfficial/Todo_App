import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/services/auth_service.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/themes/app_text_style.dart';
import 'package:get/get.dart';
import 'package:todo_app/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  void login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Show a loading dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final response = await authService.signInWithEmailPassword(
        email,
        password,
      );
      if (response != null) {
        Get.toNamed(AppRoutes.homeScreen);
      }
    } catch (e) {
      // Dismiss the loading dialog on error
      Get.back();
      Get.snackbar(
        'Login Failed',
        'Error: ${e.toString()}',
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
                        'Have an other productive day !',
                        style: AppTextStyle.semiBold.copyWith(
                          fontSize: 20.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _buildlable('Email'),
                      SizedBox(height: 10.h),
                      _buildTextField(
                        'Enter email',
                        _emailController,
                        false, // isObscure is not applicable here
                      ),
                      SizedBox(height: 10.h),
                      _buildlable('Password'),
                      SizedBox(height: 10.h),
                      _buildTextField(
                        'Enter password',
                        _passwordController,
                        true, // this text field is for password
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Get.toNamed(AppRoutes.forgetPasswordScreen),
                         child:  Text(
                          'Forget Password',
                          style: AppTextStyle.semiBold.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        )
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 52.h,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Login',
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
                            text: "Don't have an account ?",
                            style: AppTextStyle.regular.copyWith(
                              fontSize: 16.sp,
                              color: const Color(0xFFA0A0A0),
                            ),
                            children: [
                              TextSpan(
                                text: " sign up ",
                                style: AppTextStyle.bold.copyWith(
                                  fontSize: 16.sp,
                                  color: AppColors.primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.signUpScreen);
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
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primaryColor,
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
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
