import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/utils/constants/sizes.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // LoginHeader(),
              // // Form
              // LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
