import 'package:get/route_manager.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/forgot_password/forgot_password.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/login/login.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/reset_password/reset_password.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/dashboard.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';
// import 'package:minimal_flutter_app/ecommerce_ui/routes/routes_middleware.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(
        name: Routes.forgetPassword, page: () => const ForgotPasswordScreen()),
    GetPage(
        name: Routes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(
      name: Routes.dashboard,
      page: () => const Dashboard(),
      // middlewares: [RouteMiddleware()]
    ),
  ];
}
