import 'package:flutter/material.dart';

import '../data/auth_repository.dart';

/// Ecrã de entrada: email/password + Google.
///
/// Mantém o estado localmente (loading, erro, modo entrar/registar).
/// Quando introduzires o Riverpod, esta lógica migra para um provider
/// e o ecrã fica só com a UI.
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

  bool _isRegister = false;
  bool _loading = false;
  String? _error;

  static const _bg = Color(0xFF1C3329);
  static const _bgTop = Color(0xFF2F4A3F);
  static const _cream = Color(0xFFE9E0CF);
  static const _sage = Color(0xFF73937E);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitEmail() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      if (_isRegister) {
        await _auth.registerWithEmail(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        await _auth.signInWithEmail(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
      // O router redireciona sozinho via authStateChanges — não navegamos aqui.
    } catch (e) {
      setState(() => _error = AuthRepository.messageFromError(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _submitGoogle() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await _auth.signInWithGoogle();
    } catch (e) {
      setState(() => _error = AuthRepository.messageFromError(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_bgTop, _bg],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'BREATHE',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: _cream,
                      letterSpacing: 6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _isRegister ? 'Create your space' : 'Welcome back',
                    style: const TextStyle(
                      color: Color(0xFFB9CABF),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 36),

                  _field(
                    controller: _emailController,
                    hint: 'Email',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  _field(
                    controller: _passwordController,
                    hint: 'Password',
                    icon: Icons.lock_outline,
                    obscure: true,
                  ),

                  if (_error != null) ...[
                    const SizedBox(height: 14),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFE6A8A2),
                        fontSize: 13,
                      ),
                    ),
                  ],

                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _submitEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _sage,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: _loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(_isRegister ? 'Create account' : 'Sign in'),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Color(0x33FFFFFF))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or',
                          style: TextStyle(color: Color(0xFF8FA499)),
                        ),
                      ),
                      Expanded(child: Divider(color: Color(0x33FFFFFF))),
                    ],
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _loading ? null : _submitGoogle,
                      icon: const Icon(Icons.g_mobiledata, size: 26),
                      label: const Text('Continue with Google'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _cream,
                        side: const BorderSide(color: Color(0x55FFFFFF)),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 26),
                  TextButton(
                    onPressed: _loading
                        ? null
                        : () => setState(() {
                            _isRegister = !_isRegister;
                            _error = null;
                          }),
                    child: Text(
                      _isRegister
                          ? 'Already have an account? Sign in'
                          : "Don't have an account? Create one",
                      style: const TextStyle(color: Color(0xFFB9CABF)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF8FA499)),
        prefixIcon: Icon(icon, color: const Color(0xFF8FA499)),
        filled: true,
        fillColor: const Color(0x1AFFFFFF),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0x33FFFFFF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _sage, width: 1.5),
        ),
      ),
    );
  }
}
