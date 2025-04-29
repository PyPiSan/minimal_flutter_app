import 'package:flutter/material.dart';
// Imports for Scaffold, AppBar, Drawer are removed as they are no longer used directly here.

class TabletLayout extends StatelessWidget {
  // Make body required and non-nullable
  const TabletLayout({super.key, required this.body});
  final Widget body;
  // final GlobalKey<ScaffoldState> scafoldKey = GlobalKey(); // Removed Scaffold Key

  @override
  Widget build(BuildContext context) {
    // Return the body directly, removing Scaffold, AppBar, Drawer
    return body;
  }
}
