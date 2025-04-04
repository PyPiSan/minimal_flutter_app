import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final SharedPreferences prefs;
  AuthenticationRepository(this.prefs);

  String? getToken() => prefs.getString('authToken');

  bool get isAuthenticated {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  void onReady() {
    // Redirect to appropriate screen
    prefs.setString('authToken', '');
  }
}
