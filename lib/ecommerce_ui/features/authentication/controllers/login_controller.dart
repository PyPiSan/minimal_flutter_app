import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimal_flutter_app/ecommerce_ui/data/repository/authentication/authentication_repository.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/constants/text_strings.dart';
import 'package:minimal_flutter_app/utils/helpers/network_manager.dart';
import 'package:minimal_flutter_app/utils/popups/full_screen_loader.dart';
import 'package:minimal_flutter_app/utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberme = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      // Loading Animation
      FullScreenLoader.openLoadingDialog(
          'Siging In ...', Images.docerAnimation);

      // Network Check
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save data, if remember me
      if (rememberme.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      // Login the User
      await AuthenticationRepository.instance
          .loginWithEmailAndpassword(TTexts.adminEmail, TTexts.adminPassword);

      // if success stop the loader
      // FullScreenLoader.stopLoading();

      // Redirect to page
      AuthenticationRepository.instance.screenredirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
    }
  }
}
