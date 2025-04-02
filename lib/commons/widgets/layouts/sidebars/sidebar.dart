import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/commons/widgets/images/t_circular_image.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(right: BorderSide(color: AppColors.grey, width: 1))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CircularImage(
                width: 100,
                height: 100,
                image: Images.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                width: AppSizes.spaceBtwSections,
              ),
              Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MENU',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),
                    const MenuItem(
                      route: Routes.login,
                      icon: Iconsax.status,
                      itemName: "Dashboard",
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
