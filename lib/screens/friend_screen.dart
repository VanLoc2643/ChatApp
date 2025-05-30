import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../Repository/user_repository.dart';
import '../model/AppUser.dart';
import '../widgets/bottom_nav.dart';

class FriendsScreen extends StatefulWidget {
  final List<String> friendIds;

  const FriendsScreen({super.key, required this.friendIds});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final UserRepository _userRepository = UserRepository();
  List<AppUser> _friends = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    setState(() => _isLoading = true);
    try {
      final friends = await _userRepository.getUsersByIds(widget.friendIds);
      if (mounted) {
        setState(() {
          _friends = friends;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bạn bè', style: theme.textTheme.headlineSmall),
        centerTitle: true,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _friends.isEmpty
              ? Center(
                child: Text('Chưa có bạn bè', style: theme.textTheme.bodyLarge),
              )
              : ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemCount: _friends.length,
                separatorBuilder:
                    (context, index) =>
                        Divider(height: 1, indent: 70.w, endIndent: 20.w),
                itemBuilder: (context, index) {
                  final friend = _friends[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(friend.photoUrl),
                    ),
                    title: Text(
                      friend.name,
                      style: theme.textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      friend.email,
                      style: theme.textTheme.bodyMedium,
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.blue,
                      ),
                      onPressed: () => context.push('/chat', extra: friend),
                    ),
                  );
                },
              ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}
