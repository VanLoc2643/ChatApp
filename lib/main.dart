import 'package:appchat/app.dart';
import 'package:appchat/providers/auth_provider.dart';
import 'package:appchat/providers/locale_provider.dart';
import 'package:appchat/providers/theme_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // chỉ cho xoay dọc
  ]);

  runApp(
    DevicePreview(
      enabled: true,
      builder:
          (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => LocaleProvider()),
            ],
            child: const App(),
          ),
    ),
  );
}
