import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();
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

    // Wait for message to be added, then scroll to bottom
    scrollToBottom();
    // Keep focus on input box
    Future.delayed(const Duration(milliseconds: 100), () {
      inputFocusNode.requestFocus();
    });
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose(); // Important to dispose!
    super.dispose();
  }
}
