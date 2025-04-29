import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:minimal_flutter_app/chat_app_ui/routes/route.dart'; // Removed old route import
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart'; // Added Ecommerce route import
import 'package:minimal_flutter_app/utils/device/device_utility.dart';
import 'package:minimal_flutter_app/controllers/main_layout_controller.dart'; // Import MainLayoutController
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/dashboard.dart'; // Import Dashboard
import 'package:minimal_flutter_app/ecommerce_ui/features/settings/screens/settings_screen.dart'; // Import SettingsScreen

class NavbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static NavbarController get instance => Get.find();
  // Initialize activeItem with the dashboard route
  final activeItem = Routes.dashboard.obs; // Changed initial route
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

  // Helper method to get the widget based on the route
  Widget _getWidgetForRoute(String route) {
    switch (route) {
      case Routes.dashboard: // Use route constants
        return const Dashboard();
      case Routes.settings: // Use route constants
        return const SettingsScreen();
      default:
        return const Dashboard(); // Default to Dashboard
    }
  }

  void menuOnTap(String route) {
    if (!isActive(route)) {
      changeActiveItem(route);
      // Find the MainLayoutController
      final mainLayoutController = Get.find<MainLayoutController>();
      // Update the body using the controller
      mainLayoutController.updateBody(_getWidgetForRoute(route));

      // Close drawer on mobile after selection
      if (DeviceUtils.isMobileScreen(Get.context!)) Get.back();
      // Get.toNamed(route); // Removed navigation via Get.toNamed
    } else {
      // If already active and on mobile, just close the drawer
      if (DeviceUtils.isMobileScreen(Get.context!)) Get.back();
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
