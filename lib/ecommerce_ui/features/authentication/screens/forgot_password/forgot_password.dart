import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/site_layout.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/forgot_password/responsive_screens/forgot_password_desktop_tablet.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/forgot_password/responsive_screens/forgot_password_mobile.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: false,
      desktop: ForgotPasswordScreenDesktopTablet(),
      mobile: ForgotPasswordScreenMobile(),
    );
  }
}
