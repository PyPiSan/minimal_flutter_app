import 'package:get/get_navigation/get_navigation.dart' show GetPage;
import 'package:minimal_flutter_app/chat_app_ui/features/authentication/screens/login/login.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/chat.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/portfolio/screens/portfolio.dart';
import 'package:minimal_flutter_app/chat_app_ui/routes/route.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(
      name: Routes.chat,
      page: () => const ChatScreen(),
      // middlewares: [RouteMiddleware()]
    ),
    GetPage(
      name: Routes.portfolio,
      page: () => const Portfolio(),
      // middlewares: [RouteMiddleware()]
    )
  ];
}
