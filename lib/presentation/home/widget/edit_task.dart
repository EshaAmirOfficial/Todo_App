import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_style.dart';
import '../../task/controller/create_task_controller.dart';
import '../../task/widget/custom_drop_down.dart';

class EditTask extends StatelessWidget {
  EditTask({super.key});
  final CreateTaskController controller = Get.put(CreateTaskController());
  final TextEditingController _editTaskController = TextEditingController();
  final TextEditingController _editDescriptionController =
      TextEditingController();
  final TextEditingController _editTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Task',
                  style: AppTextStyle.medium.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.headingColor,
                  ),
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.close,
                    size: 22,
                    color: AppColors.headingColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            _buildLabel('Task title'),
            SizedBox(height: 10.h),
            _buildTextFormField(
              'Enter Task title',
              null,
              _editTaskController,
              null,
            ),
            SizedBox(height: 10.h),
            _buildLabel('Description'),
            SizedBox(height: 10.h),
            _buildTextFormField(
              'Add Description (optional)',
              4,
              _editDescriptionController,
              null,
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildLabel('Priority'),
                      SizedBox(height: 10.h),
                      Obx(
                        () => CustomDropDown(
                          hintText: "Select Priority",
                          options: controller.priorities,
                          selectedValue: controller.selectedPriority.value,
                          onChanged: (value) =>
                              controller.selectPriority(value),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 7.h),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildLabel('Category'),
                      SizedBox(height: 10.h),
                      Obx(
                        () => CustomDropDown(
                          hintText: "Select Category",
                          options: controller.categories,
                          selectedValue: controller.selectedCategory.value,
                          onChanged: (value) =>
                              controller.selectCategory(value),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _buildLabel('Due Date'),
            SizedBox(height: 10.h),
            _buildTextFormField(
              'mm-dd-yyyy',
              null,
              _editTimeController,
              Icons.calendar_month,
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.note_add, size: 20, color: Colors.white),
                    SizedBox(width: 5.h),
                    Text(
                      'Update Task',
                      style: AppTextStyle.semiBold.copyWith(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: AppTextStyle.medium.copyWith(
        fontSize: 18.sp,
        color: AppColors.headingColor,
      ),
    );
  }

  Widget _buildTextFormField(
    String hintText,
    int? size,
    final TextEditingController controller,
    IconData? icon,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.regular.copyWith(
          color: Color(0xFFA0A0A0),
          fontSize: 16.sp,
        ),
        suffixIcon: Icon(icon, size: 20, color: Color(0xFFA0A0A0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Color(0xFFD9D9D9), width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.red, width: 1.w),
        ),
      ),
      maxLines: size,
    );
  }
}
