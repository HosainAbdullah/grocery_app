import 'package:flutter/material.dart';
import 'package:grocery_app/constants/path_const/assets_list.dart';
import 'package:grocery_app/constants/path_const/local_path.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AssetsPath.assetsIcons + AssetsListName.images[0],
        width: 300,
        height: 300,
        filterQuality: FilterQuality.none,
      ),
    );
  }
}
