import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/site_layout.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/responsive_screens/dashboard_desktop_screen.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/responsive_screens/dashboard_mobile_screen.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/responsive_screens/dashboard_tablet_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: true,
      desktop: DashboardDesktopScreen(),
      mobile: DashboardMobileScreen(),
      tablet: DashboardTabletScreen(),
    );
  }
}
