import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/responsive_screens/chat_screen_desktop.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/templates/site_layout.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteTemplate(
      useLayout: true,
      desktop: ChatScreenDesktop(),
      // mobile: LoginScreenMobile(),
    );
  }
}
