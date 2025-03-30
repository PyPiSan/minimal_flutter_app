import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/ecommerce_ui/commons/widgets/containers/rounded_container.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: Drawer()),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  const RoundedContainer(
                    width: double.infinity,
                    height: 500,
                    backgroundColor: Colors.yellow,
                  ),
                  // body
                  body ?? const SizedBox()
                ],
              ))
        ],
      ),
    );
  }
}
