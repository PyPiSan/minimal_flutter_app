import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/controllers/chat_controller.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/chat_input_widget.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/example_chat_card_widget.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/message_list_widget.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class ChatScreenDesktop extends StatelessWidget {
  ChatScreenDesktop({super.key});
  final ChatController controller = Get.put(ChatController());
  final List<String> questions = [
    "What datasets are available for rice, wheat, and maize pest identification?",
    "Develop an AI-powered value chain analytics system for mango and guava production in targeted districts.",
    "Share 3-5 global examples of AI-driven climate-resilient farming system that could be adapted for drought-prone areas."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isChatStarted.value
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: SizedBox(
                        height: constraints.maxHeight,
                        child: Column(
                          children: [
                            Expanded(
                              child: buildMessageList(
                                  controller, controller.scrollController),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: buildInputBox(controller),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Images.chatLogo,
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: buildInputBox(controller),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ExampleChatCardWidget(
                          icon: Iconsax.message_2,
                          color: Colors.black,
                          title: "Examples",
                          questions: questions,
                        ),
                        const SizedBox(width: AppSizes.spaceBtwSections),
                        ExampleChatCardWidget(
                            icon: Iconsax.voice_cricle,
                            color: Colors.black,
                            title: "Capabilities",
                            questions: questions),
                        const SizedBox(width: AppSizes.spaceBtwSections),
                        ExampleChatCardWidget(
                            icon: Iconsax.voice_square,
                            color: Colors.black,
                            title: "Limitations",
                            questions: questions),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
