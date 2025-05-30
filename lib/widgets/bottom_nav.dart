import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNav extends StatelessWidget {
  final currentIndex;
  const BottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == 0) {
      context.go('/home');
    } else if (index == 1) {
      context.go('/friendRequests');
    } else if (index == 2) {
      context.go('/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return SalomonBottomBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      items: [
        SalomonBottomBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          title: Text(appLocalizations.chat),
          selectedColor: Colors.pink[300],
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.people_alt),
          title: Text(appLocalizations.friends),
          selectedColor: Colors.purple[300],
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.settings),
          title: Text(appLocalizations.settings),
          selectedColor: Colors.indigoAccent[300],
        ),
      ],
    );
  }
}
