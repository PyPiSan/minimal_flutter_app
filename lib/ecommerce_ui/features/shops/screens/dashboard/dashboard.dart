import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/responsive/responsive_design.dart'; // Import ResponsiveDesign
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/responsive_screens/dashboard_desktop_screen.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/responsive_screens/dashboard_mobile_screen.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/responsive_screens/dashboard_tablet_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveDesign( // Return ResponsiveDesign directly
      desktop: DashboardDesktopScreen(),
      mobile: DashboardMobileScreen(),
      tablet: DashboardTabletScreen(),
    );
  }
}
