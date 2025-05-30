import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class ThemeModeState {
  final ThemeMode mode;
  final ValueNotifier<bool> isDark;
  final Function(bool) toggleTheme;

  ThemeModeState({
    required this.mode,
    required this.isDark,
    required this.toggleTheme,
  });
}

ThemeModeState useThemeMode() {
  final isDark = useState(false);
  final mode = useState(ThemeMode.system);


  useEffect(() {
    SharedPreferences.getInstance().then((prefs) {
      final themeStr = prefs.getString('themeMode');
      if (themeStr != null) {
        switch (themeStr) {
          case 'dark':
            mode.value = ThemeMode.dark;
            isDark.value = true;
            break;
          case 'light':
            mode.value = ThemeMode.light;
            isDark.value = false;
            break;
          default:
            mode.value = ThemeMode.system;
            isDark.value = false;
        }
      }
    });
    return null;
  }, []);


  void toggleTheme(bool value) {
    isDark.value = value;
    mode.value = value ? ThemeMode.dark : ThemeMode.light;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('themeMode', mode.value.name);
    });
  }

  return ThemeModeState(
    mode: mode.value,
    isDark: isDark,
    toggleTheme: toggleTheme,
  );
}
