import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();
  final TextEditingController inputController = TextEditingController();
  final RxBool isChatStarted = false.obs;
  final RxBool isInputNotEmpty = false.obs;

  ChatController() {
    inputController.addListener(() {
      isInputNotEmpty.value = inputController.text.trim().isNotEmpty;
    });
  }

  void sendMessage() {
    print("Sent");
    isChatStarted.value = true;
    final text = inputController.text.trim();
    if (text.isEmpty) return;
    // Handle sending logic here
    print("Sent: $text");
    inputController.clear();
  }
}
