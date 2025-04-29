import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:minimal_flutter_app/chat_app_ui/routes/route.dart'; // Removed ChatApp routes
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart'; // Added Ecommerce routes
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_list_tile.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_section_header.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/navbar_controller.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/navbar_toggle_button.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class CollapsingNavbarDrawer extends StatelessWidget {
  CollapsingNavbarDrawer({super.key});
  final NavbarController sidebarController = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sidebarController.animationController,
      builder: (context, child) {
        final isCollapsed = sidebarController.isCollapsed.value;
        final width = sidebarController.widthAnimation.value;

        return Stack(
          children: [
            Container(
              width: width,
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  CollapsingSectionHeader(
                    title: 'AgriData AI Lab',
                    originalSvgIconPath: Images.chatLogo,
                    animationController: sidebarController.animationController,
                    isCollapsed: isCollapsed,
                    collapsedSvgIconPath: Images.cartIcon, // Changed icon to ecommerce related
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections / 2),
                  // --- Removed ChatApp Tiles ---
                  // --- Added Ecommerce Tiles ---
                   CollapsingListTile(
                      title: 'Dashboard',
                      icon: Iconsax.element_3, // Example icon
                      animationController: sidebarController.animationController,
                      isCollapsed: isCollapsed,
                      route: Routes.dashboard, // Use Ecommerce route constant
                      isEnabled: true,
                    ),
                   const SizedBox(height: AppSizes.spaceBtwSections / 2),
                   CollapsingListTile(
                    title: 'Settings',
                    icon: Iconsax.setting_2, // Example icon
                    animationController: sidebarController.animationController,
                    isCollapsed: isCollapsed,
                    route: Routes.settings, // Use Ecommerce route constant
                    isEnabled: true,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections / 2),
                  // Add more Ecommerce related tiles here if needed
                ],
              ),
            ),

            // Toggle button pinned at bottom
            Positioned(
              bottom: 12,
              left: width - 40, // aligns with sidebar edge
              child: const NavbarToggleButton(),
            ),
          ],
        );
      },
    );
  }
}
