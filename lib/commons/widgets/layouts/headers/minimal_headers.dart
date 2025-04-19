import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/commons/widgets/images/t_rounded_image.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';
import 'package:minimal_flutter_app/utils/constants/enums.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';
import 'package:minimal_flutter_app/utils/device/device_utility.dart';

class MinimalAppHeaders extends StatelessWidget implements PreferredSizeWidget {
  const MinimalAppHeaders({super.key, this.scafoldKey});
  final GlobalKey<ScaffoldState>? scafoldKey;
  @override
  Widget build(BuildContext context) {
    // final controller = UserController.instance;
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(bottom: BorderSide(color: AppColors.grey, width: 1))),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md, vertical: AppSizes.sm),
      child: AppBar(
        // Disabel back button
        automaticallyImplyLeading: false,
        // Mobile Menu
        leading: !DeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scafoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu))
            : null,
        // Search Field
        // title: DeviceUtils.isDesktopScreen(context)
        //     ? SizedBox(
        //         width: 400,
        //         child: TextFormField(
        //           decoration: const InputDecoration(
        //               prefixIcon: Icon(Iconsax.search_normal),
        //               hintText: "Type to search..."),
        //         ),
        //       )
        //     : null,
        actions: [
          // Search Icon for Mobile
          // if (!DeviceUtils.isDesktopScreen(context))
          //   IconButton(
          //       onPressed: () {}, icon: const Icon(Iconsax.search_normal)),
          // Stting icon
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.setting)),
          const SizedBox(
            width: AppSizes.spaceBtwItems / 2,
          ),
          // User Data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const RoundedImage(
                width: 40,
                height: 40,
                padding: 2,
                imageType: ImageType.asset,
                image: Images.user,
              ),
              const SizedBox(
                width: AppSizes.sm,
              ),
              if (!DeviceUtils.isDesktopScreen(context))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AgriData AI Lab",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                )
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight() + 15);
}
