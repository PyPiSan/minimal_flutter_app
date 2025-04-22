import 'package:carousel_slider/carousel_slider.dart';
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

class ChatScreenTablet extends StatelessWidget {
  ChatScreenTablet({super.key});
  final ChatController controller = Get.put(ChatController());
  final List<String> questions = [
    "This makes the width dynamic, so it can adapt to the available space in the parent widget.",
    "How is funding allocated in Sub-Saharan regions?",
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
                      constraints: const BoxConstraints(maxWidth: 800),
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
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: buildInputBox(controller),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 400.0, // Height of the carousel
                        enlargeCenterPage: true, // Enlarge center page
                        enableInfiniteScroll: true, // Infinite scrolling
                        autoPlay: true, // Enable auto-play
                        autoPlayInterval: const Duration(
                            seconds: 3), // Interval between auto-play slides
                        autoPlayAnimationDuration: const Duration(
                            milliseconds: 800), // Animation duration
                      ),
                      items: [
                        ExampleChatCardWidget(
                          icon: Iconsax.message_2,
                          color: Colors.black,
                          title: "Examples",
                          questions: questions,
                        ),
                        ExampleChatCardWidget(
                          icon: Iconsax.voice_cricle,
                          color: Colors.black,
                          title: "Capabilities",
                          questions: questions,
                        ),
                        ExampleChatCardWidget(
                          icon: Iconsax.voice_square,
                          color: Colors.black,
                          title: "Limitations",
                          questions: questions,
                        ),
                      ].map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: item,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
