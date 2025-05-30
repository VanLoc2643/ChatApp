import 'package:appchat/model/AppUser.dart';
import 'package:appchat/providers/auth_provider.dart';
import 'package:appchat/screens/chat_screen.dart';
import 'package:appchat/screens/friend_requests.dart';
import 'package:appchat/screens/friend_screen.dart';
import 'package:appchat/screens/home_screen.dart';
import 'package:appchat/screens/login_screen.dart';
import 'package:appchat/screens/settings_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final userProvider = context.read<AuthProvider>();
        if (userProvider.appUser == null) {
          return LoginScreen();
        } else {
          return HomeScreen();
        }
      },
    ),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
    GoRoute(
      path: '/chat',
      builder: (context, state) {
        final friend = state.extra as AppUser;
        return ChatScreen(friend: friend);
      },
    ),
    GoRoute(
      path: '/friends',
      builder:
          (context, state) =>
              FriendsScreen(friendIds: state.extra as List<String>),
    ),
    GoRoute(
      path: '/friendRequests',
      builder: (context, state) => FriendRequestsScreen(),
    ),
  ],
);
