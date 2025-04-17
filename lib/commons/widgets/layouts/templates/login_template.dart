import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/styles/spacing_styles.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class LoginTemplate extends StatelessWidget {
  const LoginTemplate({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Container(
              padding: SpacingStyle.paddingWithAppBarHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                  color: AppColors.white),
              child: child),
        ),
      ),
    );
  }
}
