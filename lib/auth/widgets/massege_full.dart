import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

 //! رسائل الشاشه
  AwesomeDialog awesome(
      BuildContext context,
      var title,
      String suptitle,
      DialogType dialogType,
      Color btnOkColor,
      String btnOkText,
      void Function()? btnOkOnPress,
      void Function()? btnCancelOnPress,
      String btnCancelText) {
    return AwesomeDialog(
      dismissOnTouchOutside: false,
      btnOkColor: btnOkColor,
      btnOkText: btnOkText,
      context: context,
      dialogType: dialogType,
      animType: AnimType.topSlide,
      title: '$title',
      desc: suptitle,
      descTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      btnOkOnPress: btnOkOnPress,
      btnCancelOnPress: btnCancelOnPress,
      btnCancelText: btnCancelText,
    )..show();
  }

