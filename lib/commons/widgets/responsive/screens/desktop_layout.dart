import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/headers/headers.dart';

class DesktopLayout extends StatelessWidget {
  DesktopLayout({super.key, this.body});
  final Widget? body;
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scafoldKey,
      body: Row(
        children: [
          const Expanded(child: Drawer()),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  // const RoundedContainer(
                  //   width: double.infinity,
                  //   height: 500,
                  //   backgroundColor: Colors.yellow,
                  // ),
                  // body
                  const AppHeaders(
                      // scafoldKey: scafoldKey,
                      ),
                  body ?? const SizedBox()
                ],
              ))
        ],
      ),
    );
  }
}
