import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minimal_flutter_app/chat_app.dart';
// import 'package:minimal_flutter_app/ecommerce_app.dart';
import 'package:minimal_flutter_app/ecommerce_ui/data/repository/authentication/authentication_repository.dart';
import 'package:minimal_flutter_app/plugins/mac_plugins.dart'
    if (dart.library.html) 'package:minimal_flutter_app/plugins/web_plugins.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:minimal_flutter_app/app.dart';

Future<void> main() async {
  // Ensure that the widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // load env
  await dotenv.load();
  // Use different plugins
  configureApp();
  // Initialize GetX storage
  await GetStorage.init();
  // Authenticate Repository
  final prefs = await SharedPreferences.getInstance();
  Get.put(AuthenticationRepository(prefs)); // Inject into GetX

  runApp(const ChatApp());
}
