import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/login_template.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/forgot_password/widgets/header_and_form.dart';

class ForgotPasswordScreenDesktopTablet extends StatelessWidget {
  const ForgotPasswordScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemplate(child: HeaderAndForm());
  }
}
