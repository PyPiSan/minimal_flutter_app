import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/commons/widgets/layouts/navbar/navbar_controller.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';

class NavbarToggleButton extends StatefulWidget {
  const NavbarToggleButton({super.key});

  @override
  State<NavbarToggleButton> createState() => _NavbarToggleButtonState();
}

class _NavbarToggleButtonState extends State<NavbarToggleButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final Animation<double> _rotationAnimation;

  final sidebarController = Get.put(NavbarController());

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut));
  }

  void _onTap() {
    if (sidebarController.isCollapsed.value) {
      _rotationController.reverse();
    } else {
      _rotationController.forward();
    }
    sidebarController.toggleSidebar();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: _onTap,
        // hoverColor: AppColors.primary.withOpacity(0.1),
        // splashColor: AppColors.primary.withOpacity(0.2),
        child: Container(
          width: 55,
          height: 40,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: AppColors.primaryBackground,
          ),
          child: AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (_, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: const Icon(
                  Icons.arrow_left_outlined,
                  color: Colors.black,
                  size: 24,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
}
