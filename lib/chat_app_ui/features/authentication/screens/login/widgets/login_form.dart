import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/authentication/controllers/login_controller.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/authentication/screens/login/widgets/email_form.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/authentication/screens/login/widgets/user_form.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        // Fade Transistion
        // transitionBuilder: (Widget child, Animation<double> animation) {
        //   return FadeTransition(opacity: animation, child: child);
        // },
        // Slide Transistion
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0), // Slide in from right
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: controller.isOTPSent.value
            ? UserForm(controller: controller) // OTP Form
            : EmailForm(controller: controller), // Email Form
      );
    });
  }
}
