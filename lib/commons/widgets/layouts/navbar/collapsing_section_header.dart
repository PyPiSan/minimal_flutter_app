import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:minimal_flutter_app/utils/constants/colors.dart';

class CollapsingSectionHeader extends StatelessWidget {
  final String title;
  final AnimationController animationController;
  final String collapsedSvgIconPath, originalSvgIconPath;
  final bool isCollapsed;

  const CollapsingSectionHeader({
    super.key,
    required this.title,
    required this.animationController,
    required this.collapsedSvgIconPath,
    required this.isCollapsed,
    required this.originalSvgIconPath,
  });

  @override
  Widget build(BuildContext context) {
    final widthAnimation =
        Tween<double>(begin: 250.0, end: 70.0).animate(animationController);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
            width: widthAnimation.value,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            // decoration: BoxDecoration(
            //   color: Colors.transparent,
            //   border: Border(
            //     bottom: BorderSide(
            //       color: AppColors.darkGrey.withOpacity(0.2),
            //       width: 1,
            //     ),
            //   ),
            // ),
            child: isCollapsed
                ? SvgPicture.asset(
                    collapsedSvgIconPath,
                    width: 35,
                    height: 35,
                  )
                : SvgPicture.asset(
                    originalSvgIconPath,
                    width: 50,
                    height: 50,
                  ));
      },
    );
  }
}
