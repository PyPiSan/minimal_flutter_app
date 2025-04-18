import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/example_chat_card_widget.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';
// import 'package:minimal_flutter_app/commons/widgets/containers/rounded_container.dart';

class ChatScreenDesktop extends StatelessWidget {
  const ChatScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
                    child: _buildInputBox(),
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
        ),
      ),
    );
  }

  Widget _buildInputBox() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            // controller: _controller,
            maxLines: null,
            onSubmitted: (_) => () {},
            decoration: const InputDecoration(
              hintText: "Send a message...",
              border: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Iconsax.send_24),
          onPressed: () {},
        ),
      ],
    );
  }
}
