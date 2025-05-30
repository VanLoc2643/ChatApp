import 'package:appchat/Repository/user_repository.dart';
import 'package:appchat/core/constants/sizes.dart';
import 'package:appchat/model/AppUser.dart';
import 'package:appchat/providers/locale_provider.dart';
import 'package:appchat/providers/theme_provider.dart';
import 'package:appchat/services/auth_service.dart';
import 'package:appchat/theme/images.dart';
import 'package:appchat/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Move these variables outside build method
  final AuthService _authService = AuthService();
  final UserRepository _userRe = UserRepository();
  AppUser? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_authService.currentUser != null) {
      final user = await _userRe.getUserById(_authService.currentUser!.uid);
      if (mounted) {
        setState(() {
          _currentUser = user;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isTablet = width > 600.w;
    final avtRadius = isTablet ? 50.r : 70.r;
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final List<Map<String, dynamic>> languages = [
      {'locale': const Locale('vi'), 'name': 'Tiếng Việt'},
      {'locale': const Locale('en'), 'name': 'English'},
      {'locale': const Locale('zh'), 'name': '日本語'},
      {'locale': const Locale('de'), 'name': 'Deutsch'},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          appLocalizations.settings,
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: Sizes.HEIGHT_20.h),
        children: [
          SizedBox(height: Sizes.HEIGHT_10.h),
          Center(
            child: FittedBox(
              fit: BoxFit.cover,
              child: CircleAvatar(
                radius: avtRadius,
                backgroundImage: NetworkImage(
                  _currentUser?.photoUrl ?? DummyImages.kAvatarImage,
                ),
              ),
            ),
          ),
          SizedBox(height: Sizes.HEIGHT_10.h),
          Center(
            child: Text(
              _currentUser?.name ?? "Loading...",
              style: theme.textTheme.headlineMedium,
            ),
          ),
          SizedBox(height: Sizes.HEIGHT_30.h),

          // Settings Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.HEIGHT_10),
            child: Card(
              elevation: 0,
              color: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.RADIUS_12),
              ),
              margin: const EdgeInsets.symmetric(vertical: Sizes.WIDTH_8),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 0),
                child: Column(
                  children: [
                    _buildSettingTile(
                      context,
                      icon: Icons.dark_mode,
                      iconColor: Colors.white,
                      backgroundColor: Colors.black,
                      title: appLocalizations.darkMode,
                      trailing: Switch(
                        activeColor: Colors.white,
                        activeTrackColor: theme.colorScheme.onTertiary,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                        value: themeProvider.themeMode == ThemeMode.dark,
                        onChanged: (bool value) {
                          themeProvider.toggleTheme(value);
                        },
                        trackOutlineColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                    ),
                    _buildDivider(),
                    _buildSettingTile(
                      context,
                      icon: Icons.language,
                      iconColor: Colors.white,
                      backgroundColor: Colors.blue,
                      title: appLocalizations.language,
                      trailing: DropdownButton<Locale>(
                        value: localeProvider.locale,
                        underline: const SizedBox(),
                        items:
                            languages.map((item) {
                              return DropdownMenuItem(
                                value: item['locale'] as Locale,
                                child: Text(item['name'] as String),
                              );
                            }).toList(),
                        onChanged: (Locale? value) {
                          if (value != null) {
                            localeProvider.setLocale(value);
                          }
                        },
                      ),
                    ),
                    _buildDivider(),
                    _buildSettingTile(
                      context,
                      icon: Icons.notifications,
                      iconColor: Colors.white,
                      backgroundColor: const Color(0xFF09B5FF),
                      title: appLocalizations.notify,
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    _buildDivider(),
                    _buildSettingTile(
                      context,
                      icon: Icons.people,
                      iconColor: Colors.white,
                      backgroundColor: const Color(0xFFC706FD),
                      title: appLocalizations.friends,
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        if (_currentUser != null) {
                          context.push(
                            '/friends',
                            extra: _currentUser!.friends,
                          );
                        }
                      },
                    ),
                    _buildDivider(),
                    _buildSettingTile(
                      context,
                      icon: Icons.email,
                      iconColor: Colors.white,
                      backgroundColor: Colors.red,
                      title: appLocalizations.email,
                      trailing: SizedBox(
                        width: 150,
                        child: Text(
                          _currentUser?.email ?? 'Loading...',
                          style: theme.textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(currentIndex: 2),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget trailing,
    Color iconColor = Colors.black,
    Color backgroundColor = Colors.black,
    VoidCallback? onTap, // Thêm tham số onTap
  }) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      dense: true,
      leading: CircleAvatar(
        backgroundColor: backgroundColor,
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: theme.textTheme.bodyLarge),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      endIndent: 40,
      indent: 40,
      color: Color(0x42000000),
    );
  }
}
