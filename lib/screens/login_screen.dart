import 'package:appchat/core/constants/app_texts.dart';
import 'package:appchat/core/constants/constants.dart';
import 'package:appchat/core/constants/sizes.dart';
import 'package:appchat/providers/auth_provider.dart' as app_auth;
import 'package:appchat/services/auth_service.dart';
import 'package:appchat/theme/colors.dart';
import 'package:appchat/theme/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isLoading = false;

  final AuthService _authService = AuthService();
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn(BuildContext context) async {
    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signOut();
      final user = await _authService.signInWithGoogle();
      if (!mounted) return;

      if (user != null) {
        await context.read<app_auth.AuthProvider>().loadUser();
        context.read<app_auth.AuthProvider>().setUser(user);

        context.go('/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Đăng nhập thất bại: $e')));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleFacebookSignIn(BuildContext context) async {
    setState(() => _isLoading = true);

    try {
      final user = await _authService.signInWithFacebook();
      if (!mounted) return;

      if (user != null) {
        await context.read<app_auth.AuthProvider>().loadUser();
        context.read<app_auth.AuthProvider>().setUser(user);
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng nhập Facebook thất bại: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<app_auth.AuthProvider>(
      context,
      listen: false,
    );
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,

            child:
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Stack(
                      // clipBehavior:
                      //     Clip.antiAlias, // Cho phép widget con vượt ra ngoài mà không bị cắt
                      children: [
                        _buildHeader(),
                        Positioned.fill(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: LoginConstants.horizontalPadding.h,
                            ),
                            child: Column(
                              children: [
                                Spacer(flex: 3),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppTexts.signInText,
                                        style: theme.textTheme.headlineMedium!
                                            .copyWith(fontSize: 38.sp),
                                      ),
                                      Divider(
                                        color: Theme.of(context).primaryColor,
                                        thickness: 3,
                                        height: 2,
                                        indent: 4,
                                        endIndent:
                                            LoginConstants.dividerEndIndent,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Sizes.HEIGHT_10.h),
                                _buildForm(),
                                _buildFooter(context),
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

  Expanded _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
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
                  horizontal: Sizes.HEIGHT_12,
                ),
                child: Text(
                  AppTexts.orSignInWithText,
                  style: theme.textTheme.labelMedium,
                ),
              ),
              Expanded(child: Divider(thickness: 1)),
            ],
          ),
          SizedBox(height: Sizes.HEIGHT_16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                LoginImages.kLogoFacebook,
                () => _handleFacebookSignIn(context),
              ),
              SizedBox(width: Sizes.WIDTH_16.w),
              _buildSocialButton(LoginImages.kLogoGoogle, () {
                _handleSignIn(context);
              }),
              SizedBox(width: Sizes.HEIGHT_16.w),
              _buildSocialButton(LoginImages.kLogoGithub, () {}),
            ],
          ),

          Spacer(),
          ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimary,
              minimumSize: Size(343, 65),
            ),
            child: Text('Login', style: theme.textTheme.labelLarge),
          ),

          SizedBox(height: Sizes.HEIGHT_30.h),
        ],
      ),
    );
  }

  Expanded _buildForm() {
    final theme = Theme.of(context);
    return Expanded(
      flex: 3,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email'),

            TextField(
              controller: _emailController,
              autofocus: false,

              style: theme.textTheme.labelLarge,
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
                prefixStyle: TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
                prefixIconConstraints: BoxConstraints(
                  minWidth: Sizes.WIDTH_16.w,
                  maxWidth: Sizes.WIDTH_16.w,
                  minHeight: Sizes.HEIGHT_36.h,
                ),
                hintText: AppTexts.emailHint,
                hintStyle: theme.textTheme.labelLarge!.copyWith(
                  color: Color.fromARGB(255, 215, 206, 206),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBDBDBD), width: 1),
                ),

                // labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: Sizes.HEIGHT_16.h),
            Text('Password', style: theme.textTheme.bodyMedium),
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
                  Icons.lock_outline,
                  color: Color(0xFFBDBDBD),
                  size: 20,
                ),
                // Tuỳ chỉnh spacing giữa icon và prefixText

                // 2) Dấu '|' ngay sau icon
                prefixText: '| ',
                prefixStyle: theme.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: Sizes.WIDTH_26.w,
                  maxWidth: Sizes.WIDTH_26.w,
                  minHeight: Sizes.HEIGHT_36.h,
                ),
                hintText: AppTexts.passwordHint,
                hintStyle: theme.textTheme.labelLarge!.copyWith(
                  color: Colors.grey[500],
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBDBDBD), width: 1),
                ),

                // labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildHeader() {
    return Positioned(
      top: LoginConstants.headerImageOffset,
      right: 0,
      left: 0,
      child: FittedBox(
        alignment: Alignment.topCenter,
        child: Image.asset(LoginImages.headerImg, fit: BoxFit.cover),
      ),
    );
  }
}

Widget _buildSocialButton(String assetName, VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(Sizes.RADIUS_32.r),

    child: Container(
      width: LoginConstants.socialButtonSize.w,
      height: LoginConstants.socialButtonSize.h,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: SvgPicture.asset(assetName),
    ),
  );
}
