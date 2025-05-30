import 'package:appchat/model/AppUser.dart';
import 'package:appchat/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final AppUser friend;
  const ChatScreen({Key? key, required this.friend}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  static const int PAGE_SIZE = 20;
  bool _isLoadingMore = false;
  DocumentSnapshot? _lastDocument;
  bool _isFocused = false;
  bool _hasMore = true;

  String get chatId {
    final currentUser =
        Provider.of<AuthProvider>(context, listen: false).appUser;
    if (currentUser == null) return '';
    List<String> ids = [currentUser.uid, widget.friend.uid];
    ids.sort();
    return ids.join('_');
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    _scrollController.addListener(_handleScroll);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.minScrollExtent) {
      _loadMoreMessages();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreMessages() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      Query query = FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(PAGE_SIZE);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      final snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
        _hasMore = snapshot.docs.length == PAGE_SIZE;
      } else {
        _hasMore = false;
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading messages: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final currentUser =
        Provider.of<AuthProvider>(context, listen: false).appUser;
    if (currentUser == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
            'senderId': currentUser.uid,
            'text': text,
            'timestamp': FieldValue.serverTimestamp(),
          });

      _messageController.clear();
      _scrollToBottom();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error sending message: $e')));
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance
                      .collection('chats')
                      .doc(chatId)
                      .collection('messages')
                      .orderBy('timestamp', descending: true)
                      .limit(PAGE_SIZE)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No messages yet',
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: docs.length + (_isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == 0 && _isLoadingMore) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final actualIndex = _isLoadingMore ? index - 1 : index;
                    final data =
                        docs[actualIndex].data() as Map<String, dynamic>;
                    final isMe =
                        data['senderId'] ==
                        Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        ).appUser!.uid;

                    return _buildMessageBubble(data, isMe);
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          _buildInputBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      leading: IconButton(
        onPressed: () => context.go('/home'),
        icon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.arrow_back, size: 24),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Icon(
            Icons.phone,
            color: theme.colorScheme.secondary,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Icon(
            Icons.videocam_sharp,
            color: theme.colorScheme.secondary,
            size: 30,
          ),
        ),
      ],
      leadingWidth: 40,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: NetworkImage(widget.friend.photoUrl),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              widget.friend.name,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> data, bool isMe) {
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          data['text'] ?? '',
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          if (!_isFocused)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
              onPressed: () {},
            ),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Aa',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      minLines: 1,
                      maxLines: 5,
                    ),
                  ),
                  if (!_isFocused)
                    const Icon(Icons.emoji_emotions, color: Colors.blue),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child:
                _isFocused
                    ? CircleAvatar(
                      key: const ValueKey('send'),
                      radius: 22,
                      backgroundColor: Colors.blueAccent,
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: _sendMessage,
                      ),
                    )
                    : const Icon(
                      Icons.thumb_up,
                      key: ValueKey('like'),
                      color: Colors.blue,
                    ),
          ),
        ],
      ),
    );
  }
}
