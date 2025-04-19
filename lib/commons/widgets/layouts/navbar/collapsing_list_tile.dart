import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/navbar_controller.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';
// import 'package:minimal_flutter_app/utils/theme/theme.dart';

class CollapsingListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isCollapsed;
  final String route;

  const CollapsingListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.animationController,
    required this.isCollapsed,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final sidebarController = Get.put(NavbarController());
    final widthAnimation =
        Tween<double>(begin: 250.0, end: 70.0).animate(animationController);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return InkWell(
          onTap: () => sidebarController.menuOnTap(route),
          onHover: (hovering) {
            if (hovering) {
              sidebarController.changeHoverItem(route);
            } else {
              sidebarController.changeHoverItem('');
            }
          },
          child: Obx(() {
            final isActive = sidebarController.isActive(route);
            final isHover = sidebarController.isHover(route);

            final backgroundColor =
                isActive || isHover ? AppColors.primary : Colors.transparent;
            final iconColor = isActive
                ? AppColors.white
                : isHover
                    ? AppColors.white
                    : AppColors.darkGrey;
            final textColor =
                isActive || isHover ? AppColors.white : AppColors.darkerGrey;

            return Container(
              width: widthAnimation.value,
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(AppSizes.cardRadiusSm),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.sm),
                    child: Icon(icon, size: 22, color: iconColor),
                  ),
                  if (widthAnimation.value > 200)
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(color: textColor),
                      ),
                    ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
