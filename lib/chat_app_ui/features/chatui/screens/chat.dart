import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/responsive_screens/chat_screen_desktop.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/responsive_screens/chat_screen_tablet.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/headers/minimal_headers.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/collapsing_navbar_drawer.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/site_layout.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteTemplate(
      useLayout: true,
      desktop: ChatScreenDesktop(),
      sidebar: CollapsingNavbarDrawer(),
      appHeader: const MinimalAppHeaders(),
      tablet: ChatScreenTablet(),
      mobile: ChatScreenTablet(),
    );
  }
}
