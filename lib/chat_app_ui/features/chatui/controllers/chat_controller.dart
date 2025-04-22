import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimal_flutter_app/chat_app_ui/data/api_service.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/models/conversation_model.dart';
import 'package:minimal_flutter_app/utils/popups/loaders.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  final localStorage = GetStorage();
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode inputFocusNode = FocusNode();
  final RxBool isChatStarted = false.obs;
  final RxBool isInputNotEmpty = false.obs;
  final ApiService apiService = ApiService();
  var messages = <CoversationModel>[].obs;
  var isLoading = false.obs;
  var objectId = ObjectId();
  late String email;
  late bool isNewChat = true;
  late String conversationId = objectId.oid;

  ChatController() {
    inputController.addListener(() {
      isInputNotEmpty.value = inputController.text.trim().isNotEmpty;
    });
  }

  @override
  void onInit() {
    email = localStorage.read('email') ?? '';
    super.onInit();
  }

  Future<void> sendMessage() async {
    isChatStarted.value = true;
    final text = inputController.text.trim();
    if (text.isEmpty) return;

    messages.add(CoversationModel(text: text, sender: Sender.user));
    inputController.clear();
    isLoading.value = true;

    try {
      final response =
          await apiService.askQuestion(text, email, conversationId, isNewChat);

      isNewChat = false;
      messages
          .add(CoversationModel(text: response!.response, sender: Sender.ai));
      messages
          .add(CoversationModel(text: response.followUps, sender: Sender.ai));
    } catch (e) {
      // error message
      messages.add(CoversationModel(
          text: '⚠️ Something went wrong. Please try again.',
          sender: Sender.ai));

      // Snackbar
      AppLoaders.errorSnackBar(
          title: 'Oh! Snap',
          message: "Something went wrong while getting response.");
    } finally {
      isLoading.value = false;
      scrollToBottom();
      Future.delayed(const Duration(milliseconds: 100), () {
        inputFocusNode.requestFocus();
      });
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (scrollController.hasClients) {
          scrollController
              .animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(seconds: 1), // slower animation
            curve: Curves.easeInOutCubic, // smoother easing
          )
              .then((_) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose(); // Important to dispose!
    super.dispose();
  }
}
