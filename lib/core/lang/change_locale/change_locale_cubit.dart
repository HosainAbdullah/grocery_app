import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/settings/keys_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_locale_state.dart';

class ChangeLocaleCubit extends Cubit<ChangeLocaleState> {
  final SharedPreferences sharedPreferences;

  String langType = 'ar';

  ChangeLocaleCubit({
    required this.sharedPreferences,
  }) : super(const ChangeLocaleState(locale: Locale('ar')));

  void getSavedLanguage() {
    final cachedLanguageCode = sharedPreferences.getString(
      KeysSharedPreferences.keyLocaleText,
    );
    if (cachedLanguageCode != null) {
      langType = cachedLanguageCode;
      emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
    } else {
      final String deviceLanguage = Platform.localeName;
      final String languageCode = deviceLanguage.substring(0, 2);
      langType = languageCode;
      emit(ChangeLocaleState(locale: Locale(languageCode)));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    await sharedPreferences.setString(
        KeysSharedPreferences.keyLocaleText, languageCode);
    langType = languageCode;
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }
}
