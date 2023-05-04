
import 'package:auto_localized/auto_localized.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shemac_service_provider/home/home_screen.dart';
import 'package:shemac_service_provider/routes/auto_alocalizection.dart';
import 'auth/signIn.dart';
import 'config.dart';  
bool? iSlogin;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  // loader config
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
    
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(ui.window),
      child: Builder(builder: (context) {
        if (FirebaseAuth.instance.currentUser == null) {
  iSlogin = false;
}else {
  iSlogin = true;
}
        return AutoLocalizedApp(
          child: GetMaterialApp(
            supportedLocales: AutoLocalizedData.supportedLocales,
            localizationsDelegates: AutoLocalizedData.localizationsDelegates,
            locale: const Locale('ar'),
            fallbackLocale: const Locale('ar'),
            home:  iSlogin == false ? Sign() : HomeScreen(),
            title: 'SHEMAC SERVICE',
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            
            theme:ThemeData(
      appBarTheme: AppBarTheme(
        iconTheme:
            const IconThemeData().copyWith(size: 20, color: Colors.white),
        centerTitle: true,
      ),
      colorScheme: const ColorScheme.light().copyWith(
        
        primary: Kbackdrung,
        secondary: Colors.black,
      ),
      primaryColor: Kbackdrung,
      buttonTheme: ButtonThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: Kbackdrung,
        ),
      ),
      textTheme: const TextTheme(
        // headline4: TextStyle(fontFamily: "Almarai"),
        // headline5: TextStyle(fontFamily: "Almarai"),
        headline6: TextStyle( fontSize: 19),
      )),
          ),
        );
      }),
    );
  }
}
