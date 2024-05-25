import 'package:flutter/material.dart';
import 'package:grocery_app/constants/theme/color_all_app.dart';

class CircularProgressLoading extends StatelessWidget {
  const CircularProgressLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: ColorAllApp.primary,
        valueColor: AlwaysStoppedAnimation(ColorAllApp.backGroundColor),
      ),
    );
  }
}
