import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/plugins/mac_plugins.dart'
    if (dart.library.html) 'package:minimal_flutter_app/plugins/web_plugins.dart';
import 'package:minimal_flutter_app/app.dart';

Future<void> main() async {
  // Ensure that the widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Use different plugins
  configureApp();
  runApp(const App());
}
