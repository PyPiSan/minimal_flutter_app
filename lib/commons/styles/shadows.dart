import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';

class ShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: AppColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
  static final horizontalProductShadow = BoxShadow(
      color: AppColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
