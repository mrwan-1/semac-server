import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

  //! رسائل الشاشه
  class Varebl{
    void Function()? btnCancelOnPress,btnOkOnPress;
    
  }
  AwesomeDialog awesome(BuildContext context,[dynamic title, String? suptitle, DialogType? dialogType,
      Color? btnOkColor, String? btnOkText,btnOkOnPress,btnCancelOnPress]
) {
    return AwesomeDialog(
      dismissOnTouchOutside: true,
      btnOkText: btnOkText,
      btnOkColor: btnOkColor,
      context: context,
      dialogType: dialogType!,
      animType: AnimType.topSlide,
      title: title,
      desc: suptitle, descTextStyle: TextStyle(fontWeight: FontWeight.bold),
        btnCancelOnPress:btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
    )..show();
      }

      
  