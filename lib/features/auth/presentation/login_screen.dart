import 'package:breathe/core/router/routes.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/profile/data/profile_repository.dart';
import 'package:breathe/features/profile/data/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/auth_repository.dart';
import '../../../core/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, AuthRepository? authRepository})
    : authRepository = authRepository;

  final AuthRepository? authRepository;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthRepository _auth = widget.authRepository ?? AuthRepository();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isRegisted = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  //-------------------- FUNCTIONS --------------------
  Future<void> _loginWithEmail() async {
    if (!_isRegisted &&
        _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords don't match"),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (_isRegisted) {
        await _auth.signInWithEmail(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (mounted) context.go(AppRoute.homePath);
      } else {
        final response = await _auth.registerWithEmail(
          email: _emailController.text,
          password: _passwordController.text,
        );

        final id = response.user!.uid;
        await ProfileRepository().saveProfile(
          UserProfile(uid: id, onboardingComplete: false),
        );

        if (mounted) context.go(AppRoute.onboardingPath);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AuthRepository.messageFromError(e),
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.danger,
          width: 320.0,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithGoogle();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AuthRepository.messageFromError(e),
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.danger,
          width: 320.0,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _forgotPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter your email first.')));
      return;
    }
    try {
      await _auth.sendPasswordReset(email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check your email for a reset link.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AuthRepository.messageFromError(e),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  //-------------------- WIDGETS --------------------
  Widget _breatheLogo() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF102C26), Color(0xFF1C584B)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Text(
            'BREATHE',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.surface,
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 1.5,
          width: 100,
          decoration: BoxDecoration(
            color: AppColors.border.withAlpha(80),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(width: 10),
        Text('Or login with', style: TextStyle(color: AppColors.border)),
        SizedBox(width: 10),
        Container(
          height: 1.5,
          width: 100,
          decoration: BoxDecoration(
            color: AppColors.border.withAlpha(80),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }

  Widget _googleButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _loginWithGoogle,
      icon: Image.asset('lib/assets/google_logo.png', height: 30),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.surface,
        foregroundColor: Color(0xFF102C26),
      ),
      label: Text(
        'Continue with Google',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _logInContainer() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        color: AppColors.background,
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
        margin: EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _isRegisted ? 'Login' : 'Sign Up',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontSize: 30),
            ),
            SizedBox(height: 24),
            CustomTextField(
              controller: _emailController,
              keyboard: TextInputType.emailAddress,
              icon: Icons.email_outlined,
              placeholder: 'Email',
            ),
            SizedBox(height: 24),
            CustomTextField(
              controller: _passwordController,
              keyboard: TextInputType.text,
              icon: Icons.key_sharp,
              placeholder: 'Password',
              obscureText: true,
            ),
            !_isRegisted
                ? Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: CustomTextField(
                      controller: _confirmPasswordController,
                      keyboard: TextInputType.text,
                      icon: Icons.key_sharp,
                      placeholder: 'Confirm Password',
                      obscureText: true,
                    ),
                  )
                : SizedBox.shrink(),
            _isRegisted
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _forgotPassword,
                        child: Text(
                          'Forgot password',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isLoading ? null : _loginWithEmail,
              style: ElevatedButton.styleFrom(),
              child: Text(_isRegisted ? 'Login' : 'Sign Up'),
            ),
            SizedBox(height: 20),
            _divider(),
            SizedBox(height: 20),
            _googleButton(context),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isRegisted
                      ? "Don't have an account?"
                      : 'Already have an account?',
                ),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () => setState(() {
                          _isRegisted = !_isRegisted;
                        }),
                  child: Text(_isRegisted ? 'Sign Up' : 'Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF102C26), Color(0xFF1C584B)],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(children: [_breatheLogo(), _logInContainer()]),
          ),
        ],
      ),
    );
  }
}
