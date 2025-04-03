import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/reset_password/widgets/reset_password_template.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class ResetPasswordScreenMobile extends StatelessWidget {
  const ResetPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace),
            child: ResetPasswordTemplate()),
      ),
    );
  }
}
