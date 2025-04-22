import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/chat_app_ui/data/api_service.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/models/conversation_model.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode inputFocusNode = FocusNode();
  final RxBool isChatStarted = false.obs;
  final RxBool isInputNotEmpty = false.obs;
  // final RxList<String> messages = <String>[].obs;
  final ApiService apiService = ApiService();
  var messages = <CoversationModel>[].obs;
  var isLoading = false.obs;

  ChatController() {
    inputController.addListener(() {
      isInputNotEmpty.value = inputController.text.trim().isNotEmpty;
    });
  }

  Future<void> sendMessage() async {
    isChatStarted.value = true;
    final text = inputController.text.trim();
    if (text.isEmpty) return;
    // Handle sending logic here
    messages.add(CoversationModel(text: text, sender: Sender.user));
    inputController.clear();
    // Set loading to true when waiting for response
    isLoading.value = true;
    // making an api call to get answer
    final response = await apiService.askQuestion(
        text, "test@digitalgreen.org", "1234567", false);

    // Set loading to false once the response is received
    isLoading.value = false;
    messages.add(CoversationModel(text: response!.response, sender: Sender.ai));
    messages.add(CoversationModel(text: response.followUps, sender: Sender.ai));

    // Keep focus on input box
    Future.delayed(const Duration(milliseconds: 100), () {
      inputFocusNode.requestFocus();
      // Wait for message to be added, then scroll to bottom
      scrollToBottom();
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
