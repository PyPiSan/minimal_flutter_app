import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/forgot_password/widgets/header_and_form.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class ForgotPasswordScreenMobile extends StatelessWidget {
  const ForgotPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: HeaderAndForm(),
      ),
    ));
  }
}
