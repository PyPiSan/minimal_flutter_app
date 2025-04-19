import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/chat_app_ui/routes/route.dart' show Routes;
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_list_tile.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_section_header.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/navbar_controller.dart';
// import 'package:minimal_flutter_app/model/collapsing_navbar_drawer_model.dart';
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

        return Container(
          width: width,
          color: AppColors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              CollapsingSectionHeader(
                  title: 'AgriData AI Lab',
                  originalSvgIconPath: Images.chatLogo,
                  animationController: sidebarController.animationController,
                  isCollapsed: sidebarController.isCollapsed.value,
                  collapsedSvgIconPath: Images.chatIcon),
              const SizedBox(
                height: AppSizes.spaceBtwSections / 2,
              ),
              CollapsingListTile(
                  title: 'Chat',
                  icon: Iconsax.message,
                  animationController: sidebarController.animationController,
                  isCollapsed: isCollapsed,
                  route: Routes.chat),
              const SizedBox(
                height: AppSizes.spaceBtwSections / 2,
              ),
              CollapsingListTile(
                  title: 'Portfolio',
                  icon: Iconsax.diagram,
                  animationController: sidebarController.animationController,
                  isCollapsed: isCollapsed,
                  route: Routes.portfolio),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              InkWell(
                onTap: sidebarController.toggleSidebar,
                child: AnimatedIcon(
                  icon: AnimatedIcons.arrow_menu,
                  progress: sidebarController.animationController,
                  color: AppColors.white,
                  size: 50.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
