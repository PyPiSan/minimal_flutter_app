import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/site_layout.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features.authentication/screens/responsive_screens/login_desktop_tablet.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features.authentication/screens/responsive_screens/login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: false,
      desktop: LoginScreenDesktopTablet(),
      mobile: LoginScreenMobile(),
    );
  }
}
