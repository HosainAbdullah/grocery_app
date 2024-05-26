import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/path_const/assets_list.dart';
import 'package:grocery_app/constants/path_const/local_path.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/constants/strings/strings_all_app.dart';
import 'package:grocery_app/core/lang/app_localizations.dart';

class ShowErrorInSearchWidget extends StatelessWidget {
  const ShowErrorInSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffF1F1F5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: ResponsiveSize.horizontalPadding(size: 16),
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                AssetsPath.assetsIcons + AssetsListName.icons[1],
                height: getScreenHeight(120),
              ),
              SizedBox(
                height: getScreenHeight(10),
              ),
              Text(StringsAllApp.somethingWentWrongText.tr(context)),
            ],
          ),
        ),
      ),
    );
  }
}
