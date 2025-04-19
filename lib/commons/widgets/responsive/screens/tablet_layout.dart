import 'package:flutter/material.dart';
// import 'package:minimal_flutter_app/commons/widgets/layouts/headers/headers.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/headers/minimal_headers.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_navbar_drawer.dart';
// import 'package:minimal_flutter_app/commons/widgets/layouts/sidebars/sidebar.dart';

class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});
  final Widget? body;
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      // drawer: const Sidebar(),
      drawer: CollapsingNavbarDrawer(),
      appBar: MinimalAppHeaders(
        scafoldKey: scafoldKey,
      ),
      // appBar: AppHeaders(
      //   scafoldKey: scafoldKey,
      // ),
      body: body ?? const SizedBox(),
    );
  }
}
