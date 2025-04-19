import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/headers/headers.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_navbar_drawer.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/navbar_controller.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/sidebars/sidebar.dart';

class DesktopLayout extends StatelessWidget {
  DesktopLayout({super.key, this.body, this.sidebar, this.appHeader});
  final Widget? body;
  final Widget? sidebar;
  final Widget? appHeader;
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  final NavbarController sidebarController = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scafoldKey,
      body: sidebar != null
          ? Obx(
              () =>
                  // This rebuilds the layout when isCollapsed changes
                  Row(
                children: [
                  sidebar ?? const CollapsingNavbarDrawer(),
                  Expanded(
                    flex: sidebarController.isCollapsed.value ? 6 : 5,
                    child: Column(
                      children: [
                        if (appHeader != null)
                          appHeader!
                        else
                          const AppHeaders(),
                        Expanded(child: body ?? const SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Row(
              children: [
                const Expanded(child: Sidebar()),
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        if (appHeader != null)
                          appHeader!
                        else
                          const AppHeaders(),
                        Expanded(child: body ?? const SizedBox())
                      ],
                    ))
              ],
            ),
    );
  }
}
