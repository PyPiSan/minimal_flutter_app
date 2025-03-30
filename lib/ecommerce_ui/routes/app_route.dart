import 'package:get/route_manager.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(name: Routes.login, page: () => const ()),
  ]
}