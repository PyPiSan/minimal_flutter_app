import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/styles/spacing_styles.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/widgets/login_form.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/widgets/login_header.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: SpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                color: AppColors.white),
            child: const Column(
              // Header
              children: [
                LoginHeader(),
                // Form
                LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
