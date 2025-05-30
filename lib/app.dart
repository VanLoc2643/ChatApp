import 'package:appchat/providers/locale_provider.dart';
import 'package:appchat/providers/theme_provider.dart';
import 'package:appchat/routes.dart';
import 'package:appchat/theme/app_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context); // T
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Thiết kế chuẩn iPhone X
      minTextAdapt: true,
      splitScreenMode: true,

      builder:
          (_, child) => MaterialApp.router(
            localizationsDelegates: const [
              AppLocalizations.delegate, // Add this line
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales:
                AppLocalizations.supportedLocales, // Các ngôn ngữ được hỗ trợ
            title: "Chat App",
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            // locale: DevicePreview.locale(context),
            locale: localeProvider.locale,
            builder: DevicePreview.appBuilder,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: router,
          ),
    );
  }
}
