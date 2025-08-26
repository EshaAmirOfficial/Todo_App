import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/services/auth_service.dart';
import 'package:todo_app/core/themes/app_colors.dart';

import 'package:todo_app/core/themes/app_text_style.dart';
import 'package:todo_app/routes/app_routes.dart';

class LogoutBottomSheet extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onLogout;

  LogoutBottomSheet({Key? key, required this.onCancel, required this.onLogout})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 300.h),
      padding: EdgeInsets.fromLTRB(
        16.w,
        26.h,
        16.w,
        MediaQuery.of(context).padding.bottom + 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Yeh content ke hisab se height lega
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title aur Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Do you want to logout?',
                style: AppTextStyle.bold.copyWith(fontSize: 18.sp),
              ),
              SizedBox(
                height: 29.31.h,
                width: 29.31.w,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    icon: Icon(
                      Icons.close,
                      size: 19.sp,
                      color: const Color(0xFF1C1B1F),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Description
          Text(
            'Stay login to make your daily task .',
            style: AppTextStyle.regular.copyWith(
              color: const Color(0xFF9C9C9C),
              fontSize: 16.sp, // Thora chota font
            ),
          ),
          SizedBox(height: 34.h),
          // Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5F5F5),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyle.medium.copyWith(
                        color: Colors.grey[500],
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SizedBox(
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: onLogout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: AppTextStyle.medium.copyWith(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
