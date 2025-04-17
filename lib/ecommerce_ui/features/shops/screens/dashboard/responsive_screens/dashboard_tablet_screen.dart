import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/ecommerce_ui/features/shops/screens/dashboard/widgets/dashboard_card_widget.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(
                width: AppSizes.spaceBtwSections,
              ),
              const Row(
                children: [
                  Expanded(
                    child: DashboardCardWidget(
                      stats: 25,
                      title: 'Sales total',
                      subTitle: '\$356.25',
                    ),
                  ),
                  SizedBox(
                    width: AppSizes.spaceBtwSections,
                  ),
                  Expanded(
                    child: DashboardCardWidget(
                      stats: 15,
                      title: 'Avg Order total',
                      subTitle: '\$356.25',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              const Row(
                children: [
                  Expanded(
                    child: DashboardCardWidget(
                      stats: 35,
                      title: 'Order total',
                      subTitle: '\$356.25',
                    ),
                  ),
                  SizedBox(
                    width: AppSizes.spaceBtwSections,
                  ),
                  Expanded(
                    child: DashboardCardWidget(
                      stats: 36,
                      title: 'Revenue total',
                      subTitle: '\$356.25',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
