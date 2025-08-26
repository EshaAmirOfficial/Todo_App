import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/common/widgets/bottomNavbar.dart';
import 'package:todo_app/core/common/widgets/navbar.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/themes/app_text_style.dart';
import 'package:todo_app/presentation/analytics/charts/pie_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EFFF),
      body: SafeArea(
        child: Column(
          children: [
            Navbar(title: 'Analytics', subtitle: 'Your productivity insights'),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          // border: Border.all(
                          //   color: Color(0xFFA0A0A0),
                          //   width: 1.w,
                          // ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Overview',

                              style: AppTextStyle.bold.copyWith(
                                fontSize: 20.sp,
                                color: AppColors.headingColor,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            _buildSummaryRow(
                              'Total Tasks',
                              Colors.deepPurple,
                              '5',
                              'Completed',
                              Colors.green,
                              '2',
                            ),
                            SizedBox(height: 10.h),
                            _buildSummaryRow(
                              'Pending',
                              Colors.deepOrangeAccent,
                              '3',
                              'Completion Rate',
                              Colors.blue,
                              '40%',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TaskPieChart(),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          // border: Border.all(
                          //   color: Color(0xFFA0A0A0),
                          //   width: 1,
                          // ),
                        ),
                        child: Column(
                          //mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Priority',
                              style: AppTextStyle.bold.copyWith(
                                fontSize: 20.sp,
                                color: AppColors.headingColor,
                              ),
                            ),
                            SizedBox(height: 10.h,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Priority Distribution',
                                style: AppTextStyle.bold.copyWith(fontSize: 18.sp),
                              ),
                              SizedBox(height: 20.h),
                              _buildPriorityRow('Low', const Color(0xFF28B463), 2, 5),
                              SizedBox(height: 12.h),
                              _buildPriorityRow('Medium', const Color(0xFFF39C12), 2, 5),
                              SizedBox(height: 12.h),
                              _buildPriorityRow('High', const Color(0xFFE74C3C), 1, 5),
                            ],
                          ),
                        ),


                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Categories',
                              style: AppTextStyle.bold.copyWith(fontSize: 18.sp),
                            ),
                            SizedBox(height: 20.h),
                            _buildCategoryRow('Personal', const Color(0xFF3498DB), 2),
                            SizedBox(height: 15.h),
                            _buildCategoryRow('Work', const Color(0xFF8E44AD), 1),
                            SizedBox(height: 15.h),
                            _buildCategoryRow('Health', const Color(0xFF2ECC71), 1),
                            SizedBox(height: 15.h),
                            _buildCategoryRow('Family', const Color(0xFFE91E63), 1),
                          ],
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
      bottomNavigationBar: Bottomnavbar(),
    );
  }

  Widget _buildSummaryRow(
    String title1,
    Color color1,
    String number1,
    String title2,
    Color color2,
    String number2,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                number1,
                style: AppTextStyle.bold.copyWith(
                  fontSize: 22.sp,
                  color: color1,
                ),
              ),
              Text(
                title1,
                style: AppTextStyle.medium.copyWith(
                  fontSize: 16.sp,
                  color: Color(0xFFA0A0A0),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 7.w),
        Expanded(
          child: Column(
            children: [
              Text(
                number2,
                style: AppTextStyle.bold.copyWith(
                  fontSize: 22.sp,
                  color: color2,
                ),
              ),
              Text(
                title2,
                style: AppTextStyle.medium.copyWith(
                  fontSize: 16.sp,
                  color: Color(0xFFA0A0A0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildPriorityRow(
      String title, Color color, int value, int total) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: AppTextStyle.medium.copyWith(
            fontSize: 15.sp,
            color: Colors.grey.shade700,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 80.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: value / total,
              backgroundColor: Colors.grey.shade200,
              color: color,
              minHeight: 8.h,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          value.toString(),
          style: AppTextStyle.medium.copyWith(
            fontSize: 15.sp,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
  Widget _buildCategoryRow(String title, Color color, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: AppTextStyle.medium.copyWith(
                fontSize: 15.sp,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: AppTextStyle.medium.copyWith(
                fontSize: 14.sp,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
