import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';
import 'package:minimal_flutter_app/utils/constants/text_strings.dart';

import '../../../../../routes/route.dart';

class ResetPasswordTemplate extends StatelessWidget {
  const ResetPasswordTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Row(
          children: [
            IconButton(
                onPressed: () => Get.offAllNamed(Routes.login),
                icon: const Icon(CupertinoIcons.clear)),
          ],
        ),
        const SizedBox(
          height: AppSizes.spaceBtwItems,
        ),
        const Image(
          image: AssetImage(Images.deliveredEmailIllustration),
          width: 300,
          height: 300,
        ),
        const SizedBox(
          height: AppSizes.spaceBtwItems,
        ),

        Text(
          TTexts.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: AppSizes.spaceBtwItems,
        ),
        Text(
          TTexts.changeYourPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: AppSizes.spaceBtwItems,
        ),

        // Sumbit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.back(), child: const Text(TTexts.done)),
        ),
        const SizedBox(
          height: AppSizes.spaceBtwItems,
        ),
        // Resend Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {}, child: const Text(TTexts.resendEmail)),
        ),
        const SizedBox(
          height: AppSizes.spaceBtwItems,
        )
      ],
    );
  }
}
