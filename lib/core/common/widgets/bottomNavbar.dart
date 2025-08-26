import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/routes/app_routes.dart';

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: Color(0xFFB2B0E8),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 4),
              blurRadius: 4,
              color: Color(0xFF748DAE),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.homeScreen),
              child: Icon(Icons.home, size: 35, color: AppColors.primaryColor),
            ),
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.analyticsScreen),
              child: Icon(
                Icons.analytics,
                size: 35,
                color: AppColors.primaryColor,
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.settingsScreen),
              child: Icon(
                Icons.settings,
                size: 35,
                color: AppColors.primaryColor,
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.createTaskScreen),
              child: Icon(Icons.add, size: 35, color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
