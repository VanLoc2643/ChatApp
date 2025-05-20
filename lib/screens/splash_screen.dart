
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//
//     // Giả lập delay 2s hoặc xử lý check đăng nhập Firebase ở đây
//     Timer(const Duration(seconds: 2), () {
//       // Ví dụ: nếu đã đăng nhập thì chuyển Home, chưa thì Login
//       bool loggedIn = false; // giả lập, thay bằng check thật
//
//       if (loggedIn) {
//         context.go('/home');
//       } else {
//         context.go('/login');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Icon(Icons.message, size: 100, color: Colors.blue),
//             SizedBox(height: 20),
//             Text(
//               'ChatApp',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
// }
