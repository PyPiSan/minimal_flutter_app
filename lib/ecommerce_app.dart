import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/app_route.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';
import 'package:minimal_flutter_app/utils/helpers/general_bindings.dart';
import 'package:minimal_flutter_app/utils/theme/theme.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Minimal Flutter Ecommerce App',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      // debug mode switch
      debugShowCheckedModeBanner: false,
      getPages: AppRoute.pages,
      initialBinding: GeneralBindings(),
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
