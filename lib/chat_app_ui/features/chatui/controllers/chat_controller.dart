import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();
  final TextEditingController inputController = TextEditingController();
  final FocusNode inputFocusNode = FocusNode();
  final RxBool isChatStarted = false.obs;
  final RxBool isInputNotEmpty = false.obs;
  final RxList<String> messages = <String>[].obs;

  ChatController() {
    inputController.addListener(() {
      isInputNotEmpty.value = inputController.text.trim().isNotEmpty;
    });
  }

  void sendMessage() {
    isChatStarted.value = true;
    final text = inputController.text.trim();
    if (text.isEmpty) return;
    // Handle sending logic here
    messages.add(text);
    inputController.clear();

    // 🔥 Keep focus on input box
    Future.delayed(const Duration(milliseconds: 100), () {
      inputFocusNode.requestFocus();
    });
  }
}
