import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/headers/minimal_headers.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_navbar_drawer.dart';
// import 'package:minimal_flutter_app/commons/widgets/layouts/headers/headers.dart';
// import 'package:minimal_flutter_app/commons/widgets/layouts/sidebars/sidebar.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key, this.body});
  final Widget? body;
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      // drawer: const Sidebar(),
      // appBar: AppHeaders(
      //   scafoldKey: scafoldKey,
      // ),
      drawer: CollapsingNavbarDrawer(),
      appBar: MinimalAppHeaders(
        scafoldKey: scafoldKey,
      ),
      body: body ?? const SizedBox(),
    );
  }
}
