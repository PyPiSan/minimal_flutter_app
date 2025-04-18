import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/controllers/chat_controller.dart';

Widget buildMessageList(ChatController controller) {
  return Obx(() => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final msg = controller.messages[index];
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                msg,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ));
}
