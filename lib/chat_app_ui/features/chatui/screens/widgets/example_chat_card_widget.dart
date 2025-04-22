import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/commons/widgets/containers/rounded_container.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class ExampleChatCardWidget extends StatelessWidget {
  const ExampleChatCardWidget(
      {super.key,
      required this.icon,
      required this.color,
      required this.title,
      required this.questions});
  final IconData icon;
  final Color color;
  final String title;
  final List<String> questions;

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
        ...questions.map(
          (question) => Padding(
            padding:
                const EdgeInsets.only(bottom: AppSizes.spaceBtwSections / 2),
            child: RoundedContainer(
              padding: const EdgeInsets.all(10),
              showBorder: true,
              showShadow: true,
              radius: 10.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth:
                      300, // You can adjust this as needed to control the width
                ),
                child: Text(
                  question,
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
