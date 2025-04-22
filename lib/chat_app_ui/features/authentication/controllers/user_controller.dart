import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final localStorage = GetStorage();
  var name = 'AgriData AI Lab'.obs;
  var email = ''.obs;
  var photoUrl = ''.obs;

  @override
  void onInit() {
    email.value = localStorage.read('email') ?? '';
    name.value = localStorage.read('name') ?? 'AgriData AI Lab';
    photoUrl.value = localStorage.read('photoUrl') ?? '';
    super.onInit();
  }
}
