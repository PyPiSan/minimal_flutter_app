import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/app_route.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';
import 'package:minimal_flutter_app/ecommerce_ui/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Minimal Flutter',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      getPages: AppRoute.pages,
      initialRoute: Routes.login,
      unknownRoute: GetPage(
        name: '/page-not-found',
        page: () => const Scaffold(
          body: Center(
            child: Text("Route Not Found"),
          ),
        ),
      ),
      home: const Scaffold(
        body: Center(
          child: Text("Admin Panel"),
        ),
      ),
    );
  }
}
