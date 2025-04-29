import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/dashboard.dart'; // Import Dashboard
import 'package:minimal_flutter_app/commons/widgets/loaders/body_loader.dart'; // Import the loader

class MainLayoutController extends GetxController {
  // Rx variable to hold the current widget to display in the body, initialized with Dashboard
  final Rx<Widget> currentBody = Rx<Widget>(const Dashboard());

  // Method to update the body widget with a loader
  void updateBody(Widget newBody) {
    // Show loader first
    currentBody.value = const BodyLoader();

    // Allow the UI to update, then set the actual body
    Future.delayed(const Duration(milliseconds: 50), () {
      currentBody.value = newBody;
    });
  }

  @override
  void onInit() {
    super.onInit();
    // Initial body is set directly in the declaration now
  }
}
