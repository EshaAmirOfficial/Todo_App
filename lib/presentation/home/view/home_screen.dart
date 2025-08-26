import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:todo_app/core/common/widgets/bottomNavbar.dart';
import 'package:todo_app/core/common/widgets/navbar.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/themes/app_text_style.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/presentation/home/controller/task_controller.dart';
import 'package:todo_app/presentation/home/widget/edit_task.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TaskController controller = Get.put(TaskController());

  void _showEditTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => EditTask(),
    );
  }

  List<TodoModel> todos = [
    TodoModel(
      title: "Buy groceries",
      description: "Milk, eggs, bread",
      category: "Shopping",
      priority: "High",
      time: DateTime.now(),
      isCompleted: TaskStatus.completed,
    ),
    TodoModel(
      title: "Meeting with boss",
      description: "Project update meeting",
      category: "Work",
      priority: "Medium",
      time: DateTime.now(),
      isCompleted: TaskStatus.pending,
    ),
    TodoModel(
      title: "Meeting with boss",
      description: "Project update meeting",
      category: "Work",
      priority: "low",
      time: DateTime.now(),
      isCompleted: TaskStatus.pending,
    ),
    TodoModel(
      title: "Meeting with boss",
      description: "Project update meeting",
      category: "Work",
      priority: "Medium",
      time: DateTime.now(),
      isCompleted: TaskStatus.pending,
    ),
    TodoModel(
      title: "Meeting with boss",
      description: "Project update meeting",
      category: "Work",
      priority: "low",
      time: DateTime.now(),
      isCompleted: TaskStatus.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Navbar(title:'My Tasks', subtitle: '3 pending,2 competed',),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildFilterChip(TaskStatus.all, 'All'),
                    _buildFilterChip(TaskStatus.pending, 'Pending'),
                    _buildFilterChip(TaskStatus.completed, 'Completed'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return _buildTaskCards(todos[index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }

  Widget _buildTaskCards(final TodoModel todo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(8.r),
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(2, 4),
        //     blurRadius: 5,
        //     color: Color(0xFF748DAE),
        //   ),
        // ],
        border: Border(
          left: BorderSide(width: 5.w, color: AppColors.primaryColor),

        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio(
            value: '1',
            groupValue: true,
            onChanged: (value) {},
            fillColor: MaterialStateProperty.all(Color(0xFFA0A0A0)),
            visualDensity: VisualDensity.compact,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: AppTextStyle.semiBold.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.headingColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  todo.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.medium.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.hintTextColor,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: todo.priority == 'High'
                            ? Color(0xFF16D39A).withOpacity(0.1)
                            : todo.priority == 'Medium'
                            ? Color(0xFFFFC107).withOpacity(0.1)
                            : Color(0xFFC24040).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: todo.priority == 'High'
                              ? Color(0xFF16D39A)
                              : todo.priority == 'Medium'
                              ? Color(0xFFFFC107)
                              : Color(0xFFC24040),
                        ),
                      ),
                      child: Text(
                        todo.priority,
                        style: AppTextStyle.regular.copyWith(
                          fontSize: 12.sp,
                          color: todo.priority == 'High'
                              ? Color(0xFF16D39A)
                              : todo.priority == 'Medium'
                              ? Color(0xFFFFC107)
                              : Color(0xFFC24040),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.calendar_month,
                      size: 16,
                      color: AppColors.headingColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${todo.time.year}-${todo.time.month}-${todo.time.day}',
                      style: AppTextStyle.regular.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.headingColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => _showEditTaskSheet(Get.context!),
                  child: Icon(Icons.edit, color: AppColors.primaryColor)),
              SizedBox(width: 8.w),
              Icon(Icons.delete, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(TaskStatus status, String label) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChoiceChip(
          label: Text(label),
          showCheckmark: false,
          labelStyle: AppTextStyle.medium.copyWith(
            fontSize: 14.sp,
            color: controller.selectedStatus.value == status
                ? Colors.white
                : AppColors.primaryColor,
          ),
          selected: controller.selectedStatus.value == status,
          onSelected: (selected) {
            controller.ChangeStatus(status);
          },
          disabledColor: Color(0xFFC1C6D5),
          selectedColor: AppColors.primaryColor,
          backgroundColor: Color(0xFFD7D8DD),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
