import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/headers/minimal_headers.dart'; // Import MinimalAppHeaders
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_navbar_drawer.dart'; // Import CollapsingNavbarDrawer
import 'package:minimal_flutter_app/commons/widgets/responsive/responsive_design.dart'; // Import ResponsiveDesign
import 'package:minimal_flutter_app/commons/widgets/responsive/screens/desktop_layout.dart'; // Import DesktopLayout
import 'package:minimal_flutter_app/commons/widgets/responsive/screens/mobile_layout.dart'; // Import MobileLayout (though body is passed directly)
import 'package:minimal_flutter_app/commons/widgets/responsive/screens/tablet_layout.dart'; // Import TabletLayout (though body is passed directly)
import 'package:minimal_flutter_app/controllers/main_layout_controller.dart';
// Dashboard import is not strictly needed here if controller initializes it, but good for clarity if used directly
// import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/dashboard.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // Find the existing controller instance instead of putting a new one
  final MainLayoutController controller = Get.find<MainLayoutController>();
  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  // No need for initState to update body if controller initializes it.

  @override
  Widget build(BuildContext context) {
    // Use Obx to rebuild when controller.currentBody changes
    return Obx(
      () => Scaffold(
        key: scaffoldKey, // Assign the key
        // Responsive AppBar: Minimal header for mobile/tablet, none for desktop
        appBar: ResponsiveDesign.isDesktop(context)
            ? null // No AppBar on desktop (handled by DesktopLayout's header)
            : MinimalAppHeaders(scaffoldKey: scaffoldKey), // Minimal header otherwise
        // Responsive Drawer: Collapsing drawer for mobile/tablet, none for desktop
        drawer: ResponsiveDesign.isDesktop(context)
            ? null // No drawer needed on desktop (sidebar is part of DesktopLayout)
            : CollapsingNavbarDrawer(), // Drawer for smaller screens
        // Responsive Body: Use different layouts based on screen size
        body: ResponsiveDesign(
          // Desktop: Use DesktopLayout, passing the current body and sidebar
          desktop: DesktopLayout(
             body: controller.currentBody.value, // Pass the reactive body
             sidebar: CollapsingNavbarDrawer(), // Provide the sidebar for DesktopLayout
             // appHeader: AppHeaders(), // Optional: Provide a specific desktop header if needed
           ),
          // Mobile & Tablet: Use the current body directly (Mobile/TabletLayout removed Scaffold)
          mobile: MobileLayout(body: controller.currentBody.value), // Pass body to MobileLayout wrapper
          tablet: TabletLayout(body: controller.currentBody.value), // Pass body to TabletLayout wrapper
        ),
      ),
    );
  }
}
