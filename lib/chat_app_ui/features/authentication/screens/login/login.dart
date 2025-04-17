import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/authentication/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/authentication/screens/login/responsive_screens/login_mobile.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/site_layout.dart';

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
