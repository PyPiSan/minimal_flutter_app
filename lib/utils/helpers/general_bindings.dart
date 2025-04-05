import 'package:get/get.dart';
import 'package:minimal_flutter_app/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    // Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    // Get.lazyPut(() => UserController(), fenix: true);
  }
}
