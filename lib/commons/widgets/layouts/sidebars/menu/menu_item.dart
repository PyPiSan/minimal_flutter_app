import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/sidebars/side_bar_controller.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.route,
      required this.itemName,
      required this.icon});
  final String route;
  final String itemName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SideBarController());
    return InkWell(
      onTap: () => menuController.menuOnTap(route),
      onHover: (hovering) => hovering
          ? menuController.changeHoverItem(route)
          : menuController.changeActiveItem(''),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
          child: Container(
            decoration: BoxDecoration(
                color: menuController.isActive(route) ||
                        menuController.isHover(route)
                    ? AppColors.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppSizes.lg,
                      top: AppSizes.md,
                      bottom: AppSizes.md,
                      right: AppSizes.md),
                  child: menuController.isActive(route)
                      ? Icon(
                          icon,
                          size: 22,
                          color: AppColors.white,
                        )
                      : Icon(
                          icon,
                          size: 22,
                          color: menuController.isHover(route)
                              ? AppColors.white
                              : AppColors.darkGrey,
                        ),
                ),
                // Text
                if (menuController.isActive(route) ||
                    menuController.isHover(route))
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: AppColors.white),
                    ),
                  )
                else
                  Flexible(
                      child: Text(
                    itemName,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: AppColors.darkerGrey),
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
