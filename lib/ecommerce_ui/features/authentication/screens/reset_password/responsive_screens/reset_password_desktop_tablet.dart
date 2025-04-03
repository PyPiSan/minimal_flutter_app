import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/login_template.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/reset_password/widgets/reset_password_template.dart';

class ResetPasswordScreenDesktopTablet extends StatelessWidget {
  const ResetPasswordScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemplate(child: ResetPasswordTemplate());
  }
}
