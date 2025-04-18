import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/containers/rounded_container.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class ExampleChatCardWidget extends StatelessWidget {
  const ExampleChatCardWidget(
      {super.key,
      required this.icon,
      required this.color,
      required this.title});
  final IconData icon;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: AppSizes.iconLg,
        ),
        const SizedBox(
          height: AppSizes.spaceBtwSections / 2,
        ),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(
          height: AppSizes.spaceBtwSections,
        ),
        const RoundedContainer(
          child: Text("What are the worldbank's current project in Affrica"),
        ),
        const SizedBox(
          height: AppSizes.spaceBtwSections / 2,
        ),
        const RoundedContainer(
          child: Text("What are the worldbank's current project in Affrica"),
        ),
        const SizedBox(
          height: AppSizes.spaceBtwSections / 2,
        ),
        const RoundedContainer(
          child: Text("What are the worldbank's current project in Affrica"),
        ),
      ],
    );
  }
}
