import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/authentication/controllers/login_controller.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';
import 'package:minimal_flutter_app/utils/constants/text_strings.dart';
import 'package:minimal_flutter_app/utils/validators/validation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
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
              // Password
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) =>
                      Validator.validateEmptyText('Password', value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                      labelText: TTexts.password),
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields / 2,
              ),

              // remember me/ forgot password
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
                  // Forget password
                  TextButton(
                      onPressed: () => Get.toNamed(Routes.forgetPassword),
                      child: const Text(TTexts.forgetPassword))
                ],
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              // Sign In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.emailAndPasswordSignIn(),
                    child: const Text(TTexts.signIn)),
              )
            ],
          ),
        ));
  }
}
