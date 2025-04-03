import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/site_layout.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/reset_password/responsive_screens/reset_password_desktop_tablet.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/screens/reset_password/responsive_screens/reset_password_mobile.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: false,
      desktop: ResetPasswordScreenDesktopTablet(),
      mobile: ResetPasswordScreenMobile(),
    );
  }
}
