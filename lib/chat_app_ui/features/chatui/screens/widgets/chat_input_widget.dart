import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/controllers/chat_controller.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';
import 'package:minimal_flutter_app/utils/constants/text_strings.dart';

Widget buildInputBox(ChatController controller) {
  return Obx(
    () => Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.inputController,
            focusNode: controller.inputFocusNode,
            autofocus: true,
            onSubmitted: controller.isInputNotEmpty.value
                ? (_) => controller.sendMessage()
                : null,
            decoration: const InputDecoration(
              hintText: TTexts.startChat,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        ElevatedButton(
          onPressed: () => controller.isInputNotEmpty.value
              ? controller.sendMessage()
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4C9FA7),
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Icon(Iconsax.send_24),
        )
      ],
    ),
  );
}
