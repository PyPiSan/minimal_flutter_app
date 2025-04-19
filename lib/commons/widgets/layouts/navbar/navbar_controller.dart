import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/chat_app_ui/routes/route.dart';
import 'package:minimal_flutter_app/utils/device/device_utility.dart';

class NavbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static NavbarController get instance => Get.find();
  final activeItem = Routes.chat.obs;
  final hoverItem = ''.obs;
  late AnimationController animationController;
  late Animation<double> widthAnimation;

  final RxBool isCollapsed = false.obs;
  final RxDouble sidebarWidth = 250.0.obs;

  void changeActiveItem(String route) => activeItem.value = route;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    widthAnimation =
        Tween<double>(begin: 250.0, end: 70.0).animate(animationController);
  }

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
    // isCollapsed.value = !isCollapsed.value;
    if (isCollapsed.value) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    isCollapsed.toggle();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
