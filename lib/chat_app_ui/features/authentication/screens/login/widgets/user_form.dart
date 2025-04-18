import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/authentication/controllers/login_controller.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';
import 'package:minimal_flutter_app/utils/constants/text_strings.dart';
import 'package:minimal_flutter_app/utils/validators/validation.dart';

class UserForm extends StatelessWidget {
  const UserForm({
    super.key,
    required this.controller,
  });
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppSizes.spaceBtwSections / 2),
          child: Column(
            children: [
              // Name
              TextFormField(
                controller: controller.name,
                validator: Validator.validateUsername,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.name),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              // OTP
              TextFormField(
                controller: controller.otp,
                validator: Validator.validateOTP,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6)
                ],
                obscureText: true,
                obscuringCharacter: '●',
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.otp),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              // Enter Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.validateOTP(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF4C9FA7), // 👈 background color
                      foregroundColor: Colors.black, // 👈 text/icon color
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize:
                          MainAxisSize.min, // 👈 so it wraps content tightly
                      children: [
                        Text(TTexts.chatAppLoginEnter),
                        SizedBox(
                            width: AppSizes
                                .spaceBtwItems), // spacing between text and icon
                        Icon(Iconsax.arrow_right_1), // 👈 your suffix icon
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
