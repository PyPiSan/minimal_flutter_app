import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Keep Get for Obx
import 'package:minimal_flutter_app/commons/widgets/layouts/headers/headers.dart'; // Keep for default header
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_navbar_drawer.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/navbar_controller.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/sidebars/sidebar.dart'; // Keep for alternative sidebar

class DesktopLayout extends StatelessWidget {
  // Require body, make sidebar and appHeader nullable
  const DesktopLayout({super.key, required this.body, this.sidebar, this.appHeader});
  final Widget body; // Changed to required Widget
  final Widget? sidebar;
  final Widget? appHeader;
  // final GlobalKey<ScaffoldState> scafoldKey = GlobalKey(); // Removed Scaffold Key
  // final NavbarController sidebarController = Get.put(NavbarController()); // Removed Get.put

  @override
  Widget build(BuildContext context) {
    // Find the controller instead of putting it
    final NavbarController sidebarController = Get.find<NavbarController>();

    // Return the Row structure directly
    return sidebar != null
        ? Obx(
            () =>
                // This rebuilds the layout when isCollapsed changes
                Row(
              children: [
                sidebar ?? CollapsingNavbarDrawer(), // Use provided sidebar or default
                Expanded(
                  // Use flex based on controller state
                  flex: sidebarController.isCollapsed.value ? 6 : 5,
                  child: Column(
                    children: [
                      // Use provided appHeader or default AppHeaders
                      appHeader ?? const AppHeaders(),
                      // Use the required body parameter
                      Expanded(child: body),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Row( // Fallback if no specific sidebar is provided (e.g., using legacy Sidebar)
            children: [
              const Expanded(child: Sidebar()), // Example legacy sidebar
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                       // Use provided appHeader or default AppHeaders
                      appHeader ?? const AppHeaders(),
                       // Use the required body parameter
                      Expanded(child: body)
                    ],
                  ))
            ],
          );
  }
}
