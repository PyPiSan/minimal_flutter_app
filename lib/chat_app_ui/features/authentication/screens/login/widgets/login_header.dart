import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';
import 'package:minimal_flutter_app/utils/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SvgPicture.asset(
          Images.chatLogo,
          width: 70,
          height: 70,
        ),
        const SizedBox(
          height: AppSizes.spaceBtwSections,
        ),
        Text(
          TTexts.chatAppLoginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // const SizedBox(
        //   height: AppSizes.sm,
        // ),
        // Text(
        //   TTexts.loginSubTitle,
        //   style: Theme.of(context).textTheme.bodyMedium,
        // ),
      ]),
    );
  }
}
