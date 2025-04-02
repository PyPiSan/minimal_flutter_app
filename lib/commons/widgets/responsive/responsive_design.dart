import 'package:flutter/material.dart';

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
      if (constraints.maxWidth >= 1234) {
        return desktop;
      } else if (constraints.maxWidth < 1234 && constraints.maxWidth >= 123) {
        return tablet;
      } else {
        return mobile;
      }
    });
  }
}
