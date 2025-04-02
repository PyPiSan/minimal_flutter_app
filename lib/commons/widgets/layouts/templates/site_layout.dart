import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/responsive/responsive_design.dart';
import 'package:minimal_flutter_app/commons/widgets/responsive/screens/desktop_layout.dart';
import 'package:minimal_flutter_app/commons/widgets/responsive/screens/mobile_layout.dart';
import 'package:minimal_flutter_app/commons/widgets/responsive/screens/tablet_layout.dart';

class SiteTemplate extends StatelessWidget {
  const SiteTemplate(
      {super.key,
      this.desktop,
      this.mobile,
      this.tablet,
      this.useLayout = true});
  final Widget? desktop;
  final Widget? mobile;
  final Widget? tablet;
  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ResponsiveDesign(
          desktop:
              useLayout ? DesktopLayout(body: desktop) : desktop ?? Container(),
          tablet: useLayout
              ? TabletLayout(
                  body: tablet ?? desktop,
                )
              : tablet ?? desktop ?? Container(),
          mobile: useLayout
              ? MobileLayout(
                  body: mobile ?? desktop,
                )
              : mobile ?? desktop ?? Container(),
        ));
  }
}
