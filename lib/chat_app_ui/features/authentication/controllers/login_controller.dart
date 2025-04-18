import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minimal_flutter_app/utils/constants/image_strings.dart';
import 'package:minimal_flutter_app/utils/helpers/network_manager.dart';
import 'package:minimal_flutter_app/utils/popups/full_screen_loader.dart';
import 'package:minimal_flutter_app/utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final localStorage = GetStorage();

  final email = TextEditingController();
  final otp = TextEditingController();
  final name = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final RxBool isOTPSent = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    super.onInit();
  }

  Future<void> sendOTPSignIn() async {
    try {
      // Validation
      print("clicked");
      if (!loginFormKey.currentState!.validate()) return;
      isLoading.value = true;
      // // Loading Animation
      // FullScreenLoader.openLoadingDialog(
      //     'Siging In ...', Images.docerAnimation);

      // Network Check
      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      // Form Validation
      // if (!loginFormKey.currentState!.validate()) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      // Save data, if remember me
      // if (rememberme.value) {
      //   localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      //   localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      // }
      // Login the User
      // simulate API call
      final result = await sendOtpToEmail(email.text); // your API call here

      if (result) {
        isOTPSent.value = true;
        isLoading.value = false;
      } else {
        Get.snackbar("Error", "Failed to send OTP");
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> validateOTP() async {
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
      // if (rememberme.value) {
      //   localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      //   localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      // }
      // Login the User
      // await AuthenticationRepository.instance
      //     .loginWithEmailAndpassword(TTexts.adminEmail, TTexts.adminPassword);

      // // if success stop the loader
      // // FullScreenLoader.stopLoading();

      // // Redirect to page
      // AuthenticationRepository.instance.screenredirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
    }
  }

  signInWithGoogle() async {
    // begin Inetractive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn(
      clientId: dotenv.env['GOOGLE_CLIENT_ID'] ?? '',
    ).signIn();
    // final GoogleSignIn googleSignIn = GoogleSignIn(
    //   clientId: dotenv.env['GOOGLE_CLIENT_ID'] ?? '',
    // );
    // // Use signInSilently for web sign-in
    // try {
    //   await googleSignIn.signInSilently();
    //   print('User signed in: ${googleSignIn.currentUser}');
    // } catch (error) {
    //   print('Error signing in: $error');
    // }

    // googleSignIn.onCurrentUserChanged.listen((account) {
    //   if (account != null) {
    //     // User signed in
    //     print('User info: ${account.displayName}');
    //     print('ID Token: ${account.id}');
    //   } else {
    //     // User signed out
    //     print('User signed out');
    //   }
    // });

    // get auth detail from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for the user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<bool> sendOtpToEmail(String email) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate network
    return true; // mock
  }
}
