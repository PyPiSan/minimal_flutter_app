import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minimal_flutter_app/chat_app_ui/data/api_service.dart';
import 'package:minimal_flutter_app/chat_app_ui/routes/route.dart';
import 'package:minimal_flutter_app/utils/helpers/network_manager.dart';
import 'package:minimal_flutter_app/utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final localStorage = GetStorage();
  final rememberme = false.obs;
  final email = TextEditingController();
  final otp = TextEditingController();
  final name = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final RxBool isOTPSent = false.obs;
  final RxBool isLoading = false.obs;
  final ApiService apiService = ApiService();
  late String userFullName;

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    super.onInit();
  }

  Future<void> sendOTPSignIn() async {
    // Validate the form
    if (!loginFormKey.currentState!.validate()) {
      return; // if invalid
    }

    isLoading.value = true;

    try {
      // 👉 Then check network
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppLoaders.errorSnackBar(
            title: 'No Internet', message: 'Please connect to the internet.');
        return;
      }

      // API call
      final result = await apiService.sendOtp(email.text.trim());
      if (result != null) {
        // print('Is User: ${result.isUser}');
        // print('OTP Sent Successfully: ${result.isOtpSuccess}');
        userFullName = result.name;
      }

      if (result!.isOtpSuccess) {
        isOTPSent.value = true;
      } else {
        Get.snackbar("Error", "Failed to send OTP");
      }
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> validateOTP() async {
    try {
      // Validate the form
      if (!otpFormKey.currentState!.validate()) {
        return; // if invalid
      }

      isLoading.value = true;

      // Network Check
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppLoaders.errorSnackBar(
            title: 'No Internet', message: 'Please connect to the internet.');
        return;
      }

      // Login the User
      // final result = await sendOtpToEmail(email.text.trim());
      final result = await apiService.validateOtp(
          email.text.trim(), otp.text.trim(), name.text.trim());
      // if (result != null) {
      //   // print('OTP Sent Successfully: ${result.isSuccess}');
      //   // print('message: ${result.message}');
      // }

      if (result?.isSuccess ?? false) {
        isLoading.value = false;
        screenredirect();
      } else {
        Get.snackbar("Error", "Incorrect OTP");
      }

      // // if success stop the loader
      // // FullScreenLoader.stopLoading();

      // // Redirect to page
      // AuthenticationRepository.instance.screenredirect();
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
    } finally {
      isLoading.value = false;
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

  // Future<bool> sendOtpToEmail(String email) async {
  //   await Future.delayed(const Duration(seconds: 2)); // simulate network
  //   return true; // mock
  // }

  void screenredirect() async {
    Get.offAllNamed(Routes.chat);
  }
}
