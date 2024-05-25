import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/constants/strings/strings_all_app.dart';
import 'package:grocery_app/constants/theme/app_theme.dart';
import 'package:grocery_app/core/lang/app_localizations.dart';
import 'package:grocery_app/core/lang/change_locale/change_locale_cubit.dart';
import 'package:grocery_app/features/home/presentation/screens/home.dart';
import 'package:grocery_app/root_app_widget/bloc_import_all_app.dart';

class GroceryRootApp extends StatelessWidget {
  const GroceryRootApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveSize().init(context: context);
    return BlocImportAllApp(
      rootAppWidget: BlocBuilder<ChangeLocaleCubit, ChangeLocaleState>(
        builder: (changeLocaleContext, changeLocaleState) {
          final langType =
              changeLocaleContext.read<ChangeLocaleCubit>().langType;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: changeLocaleState.locale,
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            title: langType == 'ar'
                ? StringsAllApp.appNameAr
                : StringsAllApp.appNameEn,
            theme: AppThemes.lightTheme(),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
