import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/login_template.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/login/widgets/login_form.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/login/widgets/login_header.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemplate(
        child: Column(
      children: [
        LoginHeader(),
        // Form
        LoginForm()
      ],
    ));
  }
}
