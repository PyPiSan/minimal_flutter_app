import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/headers/headers.dart';

class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});
  final Widget? body;
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      drawer: const Drawer(),
      appBar: AppHeaders(
        scafoldKey: scafoldKey,
      ),
      body: body ?? const SizedBox(),
    );
  }
}
