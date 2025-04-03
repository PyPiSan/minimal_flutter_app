import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';
import 'package:minimal_flutter_app/utils/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Iconsax.eye_slash)),
                labelText: TTexts.password),
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
                  Checkbox(value: true, onChanged: (value) {}),
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
                onPressed: () {}, child: const Text(TTexts.signIn)),
          )
        ],
      ),
    ));
  }
}
