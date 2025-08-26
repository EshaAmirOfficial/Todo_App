import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class Navbar extends StatelessWidget {
  final String title;
  final String? subtitle;

  const Navbar( {super.key, required this.title,this.subtitle}   );


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 3,
            spreadRadius: 1,
            color: AppColors.filledColor,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: AppTextStyle.bold.copyWith(
                fontSize: 28.sp,
                color: AppColors.primaryColor,
              ),
            ),
            Text(
              subtitle!,
              style: AppTextStyle.regular.copyWith(
                fontSize: 16.sp,
                color: AppColors.headingColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


