// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unnecessary_const, constant_identifier_names

// **************************************************************************
// AutoLocalizedGenerator
// **************************************************************************

import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@immutable
class AutoLocalizedData {
  static const supportedLocales = <Locale>[
    Locale('ar'),
  ];

  static const delegate = AutoLocalizationDelegate(supportedLocales);

  static const localizationsDelegates = [
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    delegate,
  ];
}

extension AutoLocalizedContextExtension on BuildContext {
  List<Locale> get supportedLocales => AutoLocalizedData.supportedLocales;

  List<LocalizationsDelegate> get localizationsDelegates =>
      AutoLocalizedData.localizationsDelegates;

  String translate(
    LocalizedString string, [
    String arg1 = "",
    String arg2 = "",
    String arg3 = "",
    String arg4 = "",
    String arg5 = "",
  ]) =>
      string.when(
        plain: (string) => string.get(this),
        arg1: (string) => string.get(arg1, this),
        arg2: (string) => string.get(arg1, arg2, this),
        arg3: (string) => string.get(arg1, arg2, arg3, this),
        arg4: (string) => string.get(arg1, arg2, arg3, arg4, this),
        arg5: (string) => string.get(arg1, arg2, arg3, arg4, arg5, this),
      );
}

@immutable
class Strings {
  const Strings._();
  static const signIn = PlainLocalizedString(
    key: 'signIn',
    values: {
      'ar': '''تسجيل الدخول''',
    },
  );


  static const addImage = PlainLocalizedString(
    key: 'addImage',
    values: {
      'ar': '''إضافة صورة''',
    },
  );



  static const pleaseWait = PlainLocalizedString(
    key: 'please_wait',
    values: {
      'ar': '''يرجى الأنتظار''',
    },
  );

  static const successfulOperation = PlainLocalizedString(
    key: 'successful_operation',
    values: {
      'ar': '''عملية ناجحة''',
    },
  );

  static const unsuccessfulOperation = PlainLocalizedString(
    key: 'unsuccessful_operation',
    values: {
      'ar': '''عملية غير ناجحة''',
    },
  );

  static const pleaseTryAgain = PlainLocalizedString(
    key: 'please_try_again',
    values: {
      'ar': '''الرجاء إعادة المحاولة''',
    },
  );

  static const imageUploadedSuccessfully = PlainLocalizedString(
    key: 'imageUploadedSuccessfully',
    values: {
      'ar': '''تم رفع الصور بنجاح''',
    },
  );



}
