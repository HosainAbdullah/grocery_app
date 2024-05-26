import 'package:flutter/material.dart';
import 'package:grocery_app/constants/path_const/assets_list.dart';
import 'package:grocery_app/constants/path_const/local_path.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsPath.assetsImages + AssetsListName.images[0],
            width: 300,
            height: 300,
            filterQuality: FilterQuality.none,
          ),
          SizedBox(
            height: getScreenHeight(20),
          ),
          const Text("ليس لديك منتجات في السلة حالياً")
        ],
      ),
    );
  }
}
