import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/common/widgets/bottomNavbar.dart';
import 'package:todo_app/core/common/widgets/navbar.dart';
import 'package:todo_app/core/services/auth_service.dart';
import 'package:todo_app/presentation/settings/widgets/logout_bottom_sheet.dart';
import 'package:todo_app/routes/app_routes.dart';
import '../controller/theme_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final authService = AuthService();
void onLogout() async {
  try {
    await authService.signOut();
    Get.toNamed(AppRoutes.loginScreen);
  } catch (e) {
    Get.snackbar('Logout', 'Logout Successfully');
  }
}

void _showlogoutSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => LogoutBottomSheet(
      onCancel: () {
        Get.back();
      },
      onLogout: onLogout,
    ),
  );
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Navbar(title: 'Settings', subtitle: ''),
            SizedBox(height: 10.h),
            // YAHAN BADLAV KIYA GAYA HAI
            Expanded(
              child: ListView(
                // SingleChildScrollView aur Column ko ListView se replace kiya
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ), // Padding yahan add karein
                children: [
                  _buildSettingsGroup(
                    title: 'Appearance',
                    children: [
                      _buildSettingsTile(
                        title: 'Dark Mode',
                        icon: CupertinoIcons.moon_stars_fill,
                        iconColor: Colors.deepPurple.shade300,
                        trailing: SizedBox(
                          height: 30,
                          child: Obx(
                            () => CupertinoSwitch(
                              value:
                                  themeController.theme.value == ThemeMode.dark,
                              onChanged: (value) {
                                themeController.switchTheme();
                              },
                              activeColor: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildSettingsGroup(
                    title: 'Logout',
                    children: [
                      _buildSettingsTile(
                        title: 'Logout from app',
                        icon: Icons.logout,
                        iconColor: Colors.red.shade400,
                        trailing: IconButton(
                          onPressed: () => _showlogoutSheet(context),
                          icon: Icon(Icons.chevron_right),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildSettingsGroup(
                    title: 'Data Management',
                    children: [
                      _buildSettingsTile(
                        title: 'Clear Completed Tasks',
                        icon: CupertinoIcons.trash_fill,
                        iconColor: Colors.red.shade400,
                        onTap: () {
                          Get.defaultDialog(
                            title: "Confirm",
                            middleText:
                                "Are you sure you want to clear all completed tasks?",
                            backgroundColor: isDarkMode
                                ? const Color(0xFF2A2A3E)
                                : Colors.white,
                            titleStyle: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            middleTextStyle: TextStyle(
                              color: isDarkMode
                                  ? Colors.white70
                                  : Colors.black87,
                            ),
                            textCancel: "Cancel",
                            textConfirm: "Clear",
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              Get.back();
                              Get.snackbar(
                                'Success',
                                'All completed tasks have been cleared.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildSettingsGroup(
                    title: 'About',
                    children: [
                      _buildSettingsTile(
                        title: 'Rate The App',
                        icon: CupertinoIcons.star_fill,
                        iconColor: Colors.amber.shade500,
                        onTap: () {},
                      ),
                      _buildSettingsTile(
                        title: 'Share With Friends',
                        icon: CupertinoIcons.share_up,
                        iconColor: Colors.blue.shade400,
                        onTap: () {},
                      ),
                      _buildSettingsTile(
                        title: 'Version',
                        icon: CupertinoIcons.info_circle_fill,
                        iconColor: Colors.grey.shade500,
                        trailing: Text(
                          "1.0.0",
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }

  Widget _buildSettingsGroup({
    required String title,
    required List<Widget> children,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF2A2A3E) : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required IconData icon,
    required Color iconColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: iconColor, size: 20.sp),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
      ),
      trailing:
          trailing ??
          (onTap != null
              ? const Icon(CupertinoIcons.chevron_forward, size: 18)
              : null),
    );
  }
}
