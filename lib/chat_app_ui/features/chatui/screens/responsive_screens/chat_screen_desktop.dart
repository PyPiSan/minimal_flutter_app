import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/controllers/chat_controller.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/chat_input.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/example_chat_card_widget.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class ChatScreenDesktop extends StatelessWidget {
  ChatScreenDesktop({super.key});
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
            child: controller.isChatStarted.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: buildInputBox(controller),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Images.chatLogo,
                        width: 70,
                        height: 70,
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwSections,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: buildInputBox(controller),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwSections,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ExampleChatCardWidget(
                            icon: Iconsax.message_2,
                            color: Colors.black,
                            title: "Examples",
                          ),
                          SizedBox(
                            width: AppSizes.spaceBtwSections,
                          ),
                          ExampleChatCardWidget(
                              icon: Iconsax.voice_cricle,
                              color: Colors.black,
                              title: "Capabilities"),
                          SizedBox(
                            width: AppSizes.spaceBtwSections,
                          ),
                          ExampleChatCardWidget(
                              icon: Iconsax.voice_square,
                              color: Colors.black,
                              title: "Limitations"),
                        ],
                      )
                    ],
                  )),
      ),
    );
  }
}
