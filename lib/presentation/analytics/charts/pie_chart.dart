import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_style.dart';

class TaskPieChart extends StatefulWidget {
  const TaskPieChart({super.key});

  @override
  State<TaskPieChart> createState() => _TaskPieChartState();
}

class _TaskPieChartState extends State<TaskPieChart> {
  int _touchedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
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
          Text('Task Status',style: AppTextStyle.bold.copyWith(
            fontSize: 20.sp,
            color: AppColors.headingColor,
          ),),
          Container(
            height: 250,
            child:PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 40,
                    color: Colors.orangeAccent,
                    //index=0 that is written in radius
                    radius: _touchedIndex == 0? 120:100,
                    titleStyle: AppTextStyle.medium.copyWith(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                  PieChartSectionData(
                    value: 60,
                    color: Colors.green,
                    //index=1 that is written in radius
                    radius: _touchedIndex == 1? 120:100,
                    titleStyle: AppTextStyle.medium.copyWith(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
                centerSpaceRadius: 0.r,
                pieTouchData: PieTouchData(
                  touchCallback:
                      (FlTouchEvent e, PieTouchResponse? r) {
                    if (r != null &&
                        r.touchedSection != null) {
                      setState(() {
                        _touchedIndex = r
                            .touchedSection!
                            .touchedSectionIndex;
                      });
                    }
                  },
                ),

              ),

              swapAnimationDuration: Duration(milliseconds: 300),
              swapAnimationCurve: Curves.easeInOut,
            )

          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.green, size: 16),
                  SizedBox(width: 4),
                  Text("Completed 40%"),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.orangeAccent, size: 16),
                  SizedBox(width: 4),
                  Text("Pending 60%"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
