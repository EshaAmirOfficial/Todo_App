import 'package:get/get.dart';
import 'package:todo_app/core/services/auth_gate.dart';
import 'package:todo_app/presentation/analytics/view/analytics_screen.dart';
import 'package:todo_app/presentation/auth/view/forget_password.dart';
import 'package:todo_app/presentation/auth/view/login_screen.dart';
import 'package:todo_app/presentation/auth/view/singup_screen.dart';
import 'package:todo_app/presentation/home/view/home_screen.dart';
import 'package:todo_app/presentation/splash/view/splash_screen.dart';
import 'package:todo_app/presentation/task/view/create_task_screen.dart';

import '../presentation/settings/view/settings_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes =[
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen(),),
    GetPage(
      name: AppRoutes.authGate, 
      page: () => AuthGate(),
    ),
    GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
     GetPage(name: AppRoutes.forgetPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(name: AppRoutes.homeScreen, page:() => HomeScreen()),
    GetPage(name: AppRoutes.settingsScreen, page:() => SettingsScreen()),
    GetPage(name: AppRoutes.analyticsScreen, page:() => AnalyticsScreen()),
    GetPage(name: AppRoutes.createTaskScreen, page:() => CreateTaskScreen()),
  ];
}