import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/path_const/assets_list.dart';
import 'package:grocery_app/constants/path_const/local_path.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';

class NotSearchWidget extends StatelessWidget {
  const NotSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsiveSize.horizontalPadding(size: 16),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              AssetsPath.assetsIcons + AssetsListName.icons[1],
              height: getScreenHeight(120),
            ),
            SizedBox(
              height: getScreenHeight(8),
            ),
            const Text("لم تقم ب البحث بعد"),
            SizedBox(
              height: getScreenHeight(8),
            ),
          ],
        ),
      ),
    );
  }
}
