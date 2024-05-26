import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/constants/strings/strings_all_app.dart';
import 'package:grocery_app/constants/theme/color_all_app.dart';
import 'package:grocery_app/core/lang/app_localizations.dart';
import 'package:grocery_app/core/lang/change_locale/change_locale_cubit.dart';

class SupportedLanguage {
  final String nameShow;
  final String value;

  SupportedLanguage({
    required this.nameShow,
    required this.value,
  });
}

List<SupportedLanguage> supportedLanguageList = [
  SupportedLanguage(nameShow: "languageArabic", value: "ar"),
  SupportedLanguage(nameShow: "languageEnglish", value: "en"),
];

class DropdownMenuItemLanguage extends StatelessWidget {
  const DropdownMenuItemLanguage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ResponsiveSize.defaultRadius(),
            ),
            color: ColorAllApp.grey.withOpacity(0.3),
          ),
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: ListTile(
            leading: const Icon(
              Icons.language,
              color: ColorAllApp.primary,
            ),
            title: Text(
              StringsAllApp.languageText.tr(context),
              style: TextStyle(
                color: ColorAllApp.primary,
                fontSize: getScreenWidth(14),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: SizedBox(
              width: 110,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<SupportedLanguage>(
                  iconSize: 20,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).textTheme.headlineLarge!.color,
                  ),
                  items: supportedLanguageList.map((SupportedLanguage items) {
                    return DropdownMenuItem<SupportedLanguage>(
                      value: items,
                      child: Text(
                        items.nameShow.tr(context),
                        style: TextStyle(
                          color: ColorAllApp.primary,
                          fontSize: getScreenWidth(14),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  value: state.locale.languageCode == 'ar'
                      ? supportedLanguageList[0]
                      : supportedLanguageList[1],
                  onChanged: (newValue) {
                    if (newValue != null) {
                      context
                          .read<ChangeLocaleCubit>()
                          .changeLanguage(newValue.value);
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
