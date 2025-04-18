import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/controllers/chat_controller.dart';

Widget buildInputBox(ChatController controller) {
  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: controller.inputController,
          onSubmitted: (_) => controller.sendMessage(),
          decoration: const InputDecoration(
            hintText: "Send a message...",
            border: InputBorder.none,
          ),
        ),
      ),
      IconButton(
        icon: const Icon(Iconsax.send_24),
        onPressed: () => controller.sendMessage(),
      ),
    ],
  );
}
