import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukebox_teste/pages/splash/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(
    GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
    ),
  );
}
