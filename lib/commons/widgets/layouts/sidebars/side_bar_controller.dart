import 'package:get/get.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';
import 'package:minimal_flutter_app/utils/device/device_utility.dart';

class SideBarController extends GetxController {
  final activeItem = Routes.login.obs;
  final hoverItem = ''.obs;

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
}
