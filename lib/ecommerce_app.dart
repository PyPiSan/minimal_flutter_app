import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/site_layout.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: Desktop(),
      tablet: Tablet(),
      mobile: Mobile(),
    );
  }
}

class Desktop extends StatelessWidget {
  const Desktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Tablet extends StatelessWidget {
  const Tablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Mobile extends StatelessWidget {
  const Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
