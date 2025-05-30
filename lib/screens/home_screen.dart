import 'dart:io';

import 'package:appchat/Repository/user_repository.dart';
import 'package:appchat/core/widgets/logout.dart';
import 'package:appchat/model/AppUser.dart';
import 'package:appchat/providers/auth_provider.dart';
import 'package:appchat/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _capturedImage;
  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _capturedImage = File(pickedFile.path);
      });
      // Bạn có thể xử lý ảnh ở đây (upload, crop, v.v.)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đã chụp ảnh thành công!')));
    }
  }

  List<AppUser> _searchResults = [];
  bool _isSearching = false;
  bool _isSearchMode = false;

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
        _isSearchMode = false;
      });
      return;
    }
    setState(() {
      _isSearching = true;
      _isSearchMode = true;
    });
    try {
      final userRepository = UserRepository();
      final results = await userRepository.searchUsersByName(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _handleSendRequest(AppUser targetUser) async {
    final currentUser =
        Provider.of<AuthProvider>(context, listen: false).appUser;
    if (currentUser == null) return;
    try {
      await UserRepository().sendFriendRequest(currentUser.uid, targetUser.uid);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Friend request sent to ${targetUser.name}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error sending request: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(
        onTapLogOut: () async {
          final shouldLogout = await showDialog<bool>(
            context: context,
            builder: (context) => Logout(),
          );
          if (shouldLogout == true) {
            await authProvider.signOut();
            context.go('/login');
          }
        },
        onSearchChanged: _searchUsers,
        onSearchTap: () {
          setState(() {
            _isSearchMode = true;
          });
        },
        onCameraTap: _openCamera,
      ),
      body:
          _isSearchMode
              ? _isSearching
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                  ? const Center(child: Text('No users found'))
                  : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final user = _searchResults[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.photoUrl),
                        ),
                        title: Text(user.name),

                        trailing: ElevatedButton(
                          onPressed: () async {
                            await _handleSendRequest(user);
                          },
                          child: const Text('Thêm bạn bè'),
                        ),
                      );
                    },
                  )
              : _buildChatInterface(),
      bottomNavigationBar: BottomNav(currentIndex: 0),
    );
  }

  Widget _buildChatInterface() {
    final currentUser = Provider.of<AuthProvider>(context).appUser;
    if (currentUser == null)
      return const Center(child: Text('User chưa đăng nhập'));
    if (currentUser.friends.isEmpty)
      return const Center(child: Text('Chưa có bạn bè'));
    return FutureBuilder<List<AppUser>>(
      future: UserRepository().getFriends(currentUser.friends),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());
        final friends = snapshot.data!;
        return ListView.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final friend = friends[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(friend.photoUrl),
              ),
              title: Text(friend.name),
              subtitle: Text(friend.email),
              onTap: () {
                context.go('/chat', extra: friend);
              },
            );
          },
        );
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.onTapLogOut,
    required this.onSearchChanged,
    required this.onSearchTap,
    required this.onCameraTap,
  });

  final VoidCallback onTapLogOut;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchTap;
  final VoidCallback onCameraTap;
  @override
  Widget build(BuildContext context) {
    final applocalizations = AppLocalizations.of(context)!;
    final currentUser = Provider.of<AuthProvider>(context).appUser;
    if (currentUser == null) {
      return AppBar(title: Text(applocalizations.chat), centerTitle: true);
    }
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(currentUser!.photoUrl),
                    ),
                    SizedBox(width: 12),
                    Text(
                      applocalizations.chat,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _iconButton(Icons.camera_alt, onTap: onCameraTap),
                    const SizedBox(width: 10),
                    _iconButton(Icons.logout, onTap: onTapLogOut),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search ',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      onTap: onSearchTap,
                      onChanged: onSearchChanged,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF0F0F0),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
