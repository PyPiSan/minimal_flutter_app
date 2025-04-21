import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/authentication/controllers/login_controller.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';
import 'package:minimal_flutter_app/utils/constants/text_strings.dart';
import 'package:minimal_flutter_app/utils/validators/validation.dart';

class EmailForm extends StatelessWidget {
  const EmailForm({
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
              // Email
              TextFormField(
                controller: controller.email,
                validator: Validator.validateEmail,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.email),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              // remember me
              Row(
                children: [
                  // remember me
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Checkbox(
                            value: controller.rememberme.value,
                            onChanged: (value) =>
                                controller.rememberme.value = value!),
                      ),
                      const Text(TTexts.rememberMe)
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              // Sign In Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.sendOTPSignIn(),
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
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Row(
                              mainAxisSize: MainAxisSize
                                  .min, // 👈 so it wraps content tightly
                              children: [
                                Text(TTexts.chatAppLoginContinue),
                                SizedBox(
                                    width: AppSizes
                                        .spaceBtwItems), // spacing between text and icon
                                Icon(Iconsax
                                    .arrow_right_1), // 👈 your suffix icon
                              ],
                            )),
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields / 2,
              ),
              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        TTexts.or,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields / 2,
              ),
              // Google Sign In
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.signInWithGoogle(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // 👈 background color
                      foregroundColor: Colors.black, // 👈 text/icon color
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(Images.google),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: AppSizes.spaceBtwItems,
                        ),
                        Text(TTexts.loginWithGoogle)
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
