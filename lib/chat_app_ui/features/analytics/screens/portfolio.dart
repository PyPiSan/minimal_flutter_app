import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/analytics/screens/responsive_screens/portfolio_desktop_screen.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/headers/minimal_headers.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_navbar_drawer.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/site_layout.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteTemplate(
        useLayout: true,
        desktop: const PortfolioDesktopScreen(),
        sidebar: CollapsingNavbarDrawer(),
        appHeader: const MinimalAppHeaders()
        // mobile: LoginScreenMobile(),
        );
  }
}
