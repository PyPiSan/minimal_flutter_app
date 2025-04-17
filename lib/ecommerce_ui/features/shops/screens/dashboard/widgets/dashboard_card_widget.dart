import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee/marquee.dart';
import 'package:minimal_flutter_app/commons/widgets/containers/rounded_container.dart';
import 'package:minimal_flutter_app/commons/widgets/texts/section_heading.dart';
import 'package:minimal_flutter_app/utils/constants/colors.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class DashboardCardWidget extends StatelessWidget {
  const DashboardCardWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.icon = Iconsax.arrow_up_3,
      this.color = AppColors.success,
      required this.stats,
      this.tap});
  final String title, subTitle;
  final IconData icon;
  final Color color;
  final int stats;
  final void Function()? tap;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      onTap: tap,
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        children: [
          AppSectionHeading(
            title: title,
            textColor: AppColors.textSecondary,
          ),
          const SizedBox(
            height: AppSizes.spaceBtwSections,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          color: color,
                          size: AppSizes.iconSm,
                        ),
                        Text(
                          '$stats%',
                          style: Theme.of(context).textTheme.titleLarge!.apply(
                              color: color, overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 135,
                    height: 20,
                    child: Marquee(
                      text: 'Compared to Apr of 2024',
                      style: Theme.of(context).textTheme.labelMedium,
                      scrollAxis: Axis.horizontal,
                      blankSpace: 20.0,
                      velocity: 30.0,
                      pauseAfterRound: const Duration(seconds: 1),
                      startPadding: 10.0,
                      accelerationDuration: const Duration(seconds: 1),
                      decelerationDuration: const Duration(milliseconds: 500),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
