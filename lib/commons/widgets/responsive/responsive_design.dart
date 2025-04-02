import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/utils/device/device_utility.dart';

class ResponsiveDesign extends StatelessWidget {
  const ResponsiveDesign(
      {super.key,
      required this.desktop,
      required this.mobile,
      required this.tablet});
  final Widget desktop;
  final Widget mobile;
  final Widget tablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      if (DeviceUtils.isDesktopScreen(context)) {
        return desktop;
      } else if (DeviceUtils.isTabletScreen(context)) {
        return tablet;
      } else {
        return mobile;
      }
    });
  }
}
