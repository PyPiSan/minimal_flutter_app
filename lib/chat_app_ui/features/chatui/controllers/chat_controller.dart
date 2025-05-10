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

    // Add user's message
    messages.add(CoversationModel(text: text, sender: Sender.user));
    final String lowerCaseText = text.toLowerCase();
    inputController.clear();
    // Request focus immediately after clearing, before any potential async operations
    Future.delayed(const Duration(milliseconds: 50), () {
        inputFocusNode.requestFocus();
    });


    // Check for chart requests
    if (lowerCaseText.contains("show me a bar chart")) {
      isLoading.value = true;
      scrollToBottom(); // Scroll after user message is added

      await Future.delayed(const Duration(seconds: 1)); // Simulate AI thinking

      messages.add(CoversationModel(
        text: "Here is your bar chart:",
        sender: Sender.ai,
        chartData: {
          'type': 'bar',
          'labels': ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
          'datasets': [
            {
              'label': 'Sales',
              'data': [120, 180, 150, 210, 160],
              'backgroundColor': 'rgba(54, 162, 235, 0.5)', // Example color
              'borderColor': 'rgba(54, 162, 235, 1)',      // Example border
              'borderWidth': 1
            }
          ]
        },
      ));
      isLoading.value = false;
      scrollToBottom();
      return; // Skip normal API call
    } else if (lowerCaseText.contains("display pie chart")) {
      isLoading.value = true;
      scrollToBottom(); // Scroll after user message is added

      await Future.delayed(const Duration(seconds: 1)); // Simulate AI thinking

      messages.add(CoversationModel(
        text: "Certainly, here's a pie chart:",
        sender: Sender.ai,
        chartData: {
          'type': 'pie',
          'labels': ['Red', 'Blue', 'Yellow', 'Green', 'Purple'],
          'datasets': [
            {
              'label': 'Votes',
              'data': [300, 50, 100, 40, 120],
              'backgroundColor': [ // Example colors
                'rgba(255, 99, 132, 0.5)',
                'rgba(54, 162, 235, 0.5)',
                'rgba(255, 206, 86, 0.5)',
                'rgba(75, 192, 192, 0.5)',
                'rgba(153, 102, 255, 0.5)'
              ],
              'borderColor': [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)'
              ],
              'borderWidth': 1
            }
          ]
        },
      ));
      isLoading.value = false;
      scrollToBottom();
      return; // Skip normal API call
    }

    // If no chart request, proceed with normal message handling
    isLoading.value = true;
    scrollToBottom(); // Scroll after user message is added, before API call

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
      // Focus request was moved up
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        // No need for an additional delay here if we just want it to scroll ASAP
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), // Faster animation
          curve: Curves.easeOut, // Smoother easing for quick scrolls
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
