import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:minimal_flutter_app/app.dart';

Future<void> main() async {
  // Ensure that the widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Use Path based Strategy
  usePathUrlStrategy();
  runApp(const App());
}
