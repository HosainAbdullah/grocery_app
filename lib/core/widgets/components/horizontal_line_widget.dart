import 'package:flutter/material.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/constants/theme/color_all_app.dart';

class HorizontalLineWidget extends StatelessWidget {
  const HorizontalLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: getScreenWidth(40),
        height: getScreenHeight(5),
        decoration: BoxDecoration(
          color: ColorAllApp.grey,
          borderRadius: BorderRadius.circular(
            getScreenWidth(100),
          ),
        ),
      ),
    );
  }
}
