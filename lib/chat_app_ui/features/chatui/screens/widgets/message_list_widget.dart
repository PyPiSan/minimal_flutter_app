import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/controllers/chat_controller.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/models/conversation_model.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/messgae_action_bar.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/typing_loader.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildMessageList(
    ChatController controller, ScrollController scrollController) {
  return Obx(() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: controller.messages.length +
          (controller.isLoading.value ? 1 : 0), // Add 1 for the loading item
      controller: scrollController,
      itemBuilder: (context, index) {
        // If it's the last item and isLoading is true, show the loader
        if (controller.isLoading.value && index == controller.messages.length) {
          return const TypingLoader();
        }

        // Otherwise, show the messages
        final message = controller.messages[index];
        final isUser = message.sender == Sender.user;
        return Align(
          alignment: isUser
              ? Alignment.centerRight
              : Alignment.centerLeft, // Aligning user messages to the right
          child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isUser
                            ? const Radius.circular(16)
                            : const Radius.circular(0),
                        bottomRight: isUser
                            ? const Radius.circular(0)
                            : const Radius.circular(16),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: MarkdownBody(
                      data: message.text,
                      onTapLink: (text, href, title) async {
                        if (href != null &&
                            await canLaunchUrl(Uri.parse(href))) {
                          await launchUrl(Uri.parse(href),
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(fontSize: 16),
                        code: TextStyle(
                          fontFamily: 'monospace',
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                    )),
                if (!isUser)
                  MessageActionBar(
                    messageText: message.text,
                    onThumbsUp: () {
                      // Handle thumbs up
                    },
                    onThumbsDown: () {
                      // Handle thumbs down
                    },
                  ),
              ]),
        );
      },
    );
  });
}
