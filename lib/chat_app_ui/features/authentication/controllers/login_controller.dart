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

      if (result?.isSuccess ?? false) {
        isLoading.value = false;
        saveUser(name.text.trim(), email.text.trim(), '');
        screenredirect(name.text.trim(), email.text.trim(), '');
      } else {
        Get.snackbar("Error", "Incorrect OTP");
      }
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleClientId = dotenv.env['GOOGLE_CLIENT_ID'] ?? '';
      // begin Inetractive sign in process

      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>['email'],
        clientId: googleClientId,
      );

      // Listen for current user changes
      googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        if (account != null) {
          // print('User signed in: ${account.displayName}');
          saveUser(
              account.displayName ?? '', account.email, account.photoUrl ?? '');
          screenredirect(
              account.displayName ?? '', account.email, account.photoUrl ?? '');
        }
      });
      // Sign the user in if they haven't signed in yet
      googleSignIn.signIn().then((GoogleSignInAccount? account) {
        if (account != null) {
          // print('User signed in later: ${account.displayName}');
          // print('User signed in later: ${account.email}');
          // print('User signed in later: ${account.photoUrl}');
          saveUser(
              account.displayName ?? '', account.email, account.photoUrl ?? '');
          screenredirect(
              account.displayName ?? '', account.email, account.photoUrl ?? '');
        } else {
          AppLoaders.errorSnackBar(
              title: "Oh! Snap, Sign-in failed or was cancelled");
        }
      });
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
      return;
    }
  }

  // Dummy method
  // Future<bool> sendOtpToEmail(String email) async {
  //   await Future.delayed(const Duration(seconds: 2)); // simulate network
  //   return true; // mock
  // }

  // to redirect
  void screenredirect(String displayName, String email, String photoUrl) async {
    Get.offAllNamed(
      Routes.chat,
      arguments: {
        'name': displayName,
        'email': email,
        'photoUrl': photoUrl,
      },
    );
  }

  void saveUser(String displayName, String email, String photoUrl) {
    localStorage.write('name', displayName);
    localStorage.write('email', email);
    localStorage.write('photoUrl', photoUrl);
  }
}
