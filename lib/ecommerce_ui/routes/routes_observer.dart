import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';

class RouteObserver extends GetObserver {
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());
    if (previousRoute != null) {
      // check the route name and active the item in sidebar accordingly
      for (var routeName in Routes.SidemenuItems) {
        if (previousRoute.settings.name == routeName) {
          sidebarController.actieItem.value = routeName;
        }
      }
    }
  }

  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());
    if (route != null) {
      // check the route name and active the item in sidebar accordingly
      for (var routeName in Routes.SidemenuItems) {
        if (route.settings.name == routeName) {
          sidebarController.actieItem.value = routeName;
        }
      }
    }
  }
}
