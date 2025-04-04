import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:minimal_flutter_app/ecommerce_ui/data/repository/authentication/authentication_repository.dart';
import 'package:minimal_flutter_app/ecommerce_ui/routes/route.dart';

class RouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepository.instance.isAuthenticated
        ? null
        : const RouteSettings(name: Routes.login);
  }
}
