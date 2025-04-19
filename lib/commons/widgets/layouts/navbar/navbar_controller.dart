import 'package:get/get.dart';
import 'package:minimal_flutter_app/chat_app_ui/routes/route.dart';
import 'package:minimal_flutter_app/utils/device/device_utility.dart';

class NavbarController extends GetxController {
  static NavbarController get instance => Get.find();
  final activeItem = Routes.login.obs;
  final hoverItem = ''.obs;

  final isCollapsed = false.obs;
  final sidebarWidth = 250.0.obs;

  void changeActiveItem(String route) => activeItem.value = route;

  void changeHoverItem(String route) {
    if (!isActive(route)) {
      hoverItem.value = route;
    }
  }

  bool isActive(String route) => activeItem.value == route;
  bool isHover(String route) => hoverItem.value == route;

  void menuOnTap(String route) {
    if (!isActive(route)) {
      changeActiveItem(route);
      if (DeviceUtils.isMobileScreen(Get.context!)) Get.back();
      Get.toNamed(route);
    }
  }

  void toggleSidebar() {
    isCollapsed.value = !isCollapsed.value;
    sidebarWidth.value = isCollapsed.value ? 70.0 : 250.0;
  }
}
