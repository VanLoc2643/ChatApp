import 'package:appchat/Repository/user_repository.dart';
import 'package:appchat/providers/auth_provider.dart';
import 'package:appchat/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FriendRequestsScreen extends StatefulWidget {
  const FriendRequestsScreen({Key? key}) : super(key: key);

  @override
  _FriendRequestsScreenState createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> {
  List<String> _requests = [];
  bool _isLoading = true;

  Future<void> _fetchRequests() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.appUser;
    if (user != null) {
      // Giả sử user.requests chứa danh sách uid của lời mời kết bạn
      setState(() {
        _requests = user.requests;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleAcceptRequest(String requestUid) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.appUser;
    if (currentUser == null) return;
    try {
      await UserRepository().acceptFriendRequest(currentUser.uid, requestUid);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Friend added successfully')));
      // Reload thông tin user để cập nhật danh sách bạn bè
      await authProvider.loadUser();
      // Cập nhật lại danh sách lời mời
      _fetchRequests();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error accepting friend request: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friend Requests')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _requests.isEmpty
              ? const Center(child: Text('No friend requests'))
              : ListView.builder(
                itemCount: _requests.length,
                itemBuilder: (context, index) {
                  final requestUid = _requests[index];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text('User: $requestUid'),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        await _handleAcceptRequest(requestUid);
                      },
                      child: const Text('Accept'),
                    ),
                  );
                },
              ),
      bottomNavigationBar: BottomNav(currentIndex: 1),
    );
  }
}
