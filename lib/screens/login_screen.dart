import 'package:appchat/theme/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,

            child: Stack(
              // clipBehavior:
              //     Clip.antiAlias, // Cho phép widget con vượt ra ngoài mà không bị cắt
              children: [
                Positioned(
                  top: -320,
                  right: 0,
                  left: 0,
                  child: FittedBox(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/auth/Header.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Spacer(flex: 3),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sign in",
                                style: GoogleFonts.rubik(
                                  color: Color(0xFF424242),
                                  fontSize: 38,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Divider(
                                color: Theme.of(context).primaryColor,
                                thickness: 3,
                                height: 2,
                                indent: 4,
                                endIndent: 300,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Expanded(
                          flex: 3,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: GoogleFonts.rubik(
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                    color: Color(0xFF424242),
                                  ),
                                ),

                                TextField(
                                  controller: _emailController,
                                  autofocus: false,

                                  style: GoogleFonts.rubik(
                                    fontSize: 14,
                                    letterSpacing: 0.2,
                                    color: Color(0xFFBDBDBD),
                                  ),
                                  decoration: InputDecoration(
                                    // 1) Icon ổ khoá
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Color(0xFFBDBDBD),
                                      size: 20,
                                    ),
                                    // Tuỳ chỉnh spacing giữa icon và prefixText

                                    // 2) Dấu '|' ngay sau icon
                                    prefixText: '| ',
                                    prefixStyle: TextStyle(
                                      color: Color(0xFFBDBDBD),
                                      fontSize: 14,
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 26,
                                      maxWidth: 26,
                                      minHeight: 36,
                                    ),
                                    hintText: 'Enter your email',
                                    hintStyle: GoogleFonts.rubik(
                                      fontSize: 14,
                                      letterSpacing: 0.2,
                                      color: Color(0xFFBDBDBD),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFBDBDBD),
                                        width: 1,
                                      ),
                                    ),

                                    // labelText: 'Email',
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Password',
                                  style: GoogleFonts.rubik(
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                    color: Color(0xFF424242),
                                  ),
                                ),
                                TextField(
                                  controller: _passwordController,
                                  autofocus: false,

                                  style: GoogleFonts.rubik(
                                    fontSize: 14,
                                    letterSpacing: 0.2,
                                    color: Color(0xFFBDBDBD),
                                  ),
                                  decoration: InputDecoration(
                                    // 1) Icon ổ khoá
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Color(0xFFBDBDBD),
                                      size: 20,
                                    ),
                                    // Tuỳ chỉnh spacing giữa icon và prefixText

                                    // 2) Dấu '|' ngay sau icon
                                    prefixText: '| ',
                                    prefixStyle: TextStyle(
                                      color: Color(0xFFBDBDBD),
                                      fontSize: 14,
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 26,
                                      maxWidth: 26,
                                      minHeight: 36,
                                    ),
                                    hintText: 'Enter your email',
                                    hintStyle: GoogleFonts.rubik(
                                      fontSize: 14,
                                      letterSpacing: 0.2,
                                      color: Color(0xFFBDBDBD),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFBDBDBD),
                                        width: 1,
                                      ),
                                    ),

                                    // labelText: 'Email',
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Divider(thickness: 1)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                    ),
                                    child: Text(
                                      "Or sign in with",
                                      style: GoogleFonts.rubik(
                                        fontSize: 16,
                                        letterSpacing: 0.2,
                                        color: Color(0xFFBDBDBD),
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Divider(thickness: 1)),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildSocialButton(
                                    LoginImages.kLogoFacebook,
                                    () {
                                      print('Apple Sign In');
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  _buildSocialButton(
                                    LoginImages.kLogoGoogle,
                                    () {
                                      print('Google Sign In');
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  _buildSocialButton(
                                    LoginImages.kLogoGithub,
                                    () {
                                      print('Facebook Sign In');
                                    },
                                  ),
                                ],
                              ),

                              Spacer(),
                              ElevatedButton(
                                onPressed: () => {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF8383),
                                  minimumSize: Size(343, 65),
                                ),
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.rubik(
                                    fontSize: 20,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),

                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Form
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSocialButton(String assetName, VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(28),

    child: Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: SvgPicture.asset(assetName),
    ),
  );
}
