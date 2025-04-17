import 'package:get/get.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/models/order_model.dart';
import 'package:minimal_flutter_app/utils/helpers/helper_functions.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;
  static final List<OrderModel> orders = [];

  @override
  void onInit() {
    _calculateWeeklySales();
    super.onInit();
  }

  void _calculateWeeklySales() {
    // Reset Weekly Sales to zero
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orders) {
      // final DateTime orderWeekStart =
      //     HelperFunctions.getStartOfWeek(order.orderDate);
    }
  }
}
