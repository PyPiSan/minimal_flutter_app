import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/sidebars/side_bar_controller.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';

class RouteObserver extends GetObserver {
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SideBarController());
    if (previousRoute != null) {
      // check the route name and active the item in sidebar accordingly
      for (var routeName in Routes.sideBarMenuItems) {
        if (previousRoute.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }

  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SideBarController());
    if (route != null) {
      // check the route name and active the item in sidebar accordingly
      for (var routeName in Routes.sideBarMenuItems) {
        if (route.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }
}
