import 'package:flutter/material.dart';

import '../../theme.dart';
import '../main_shell.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const String _hardcodedEmail = 'staff@borneomedispa.my';
  static const String _hardcodedPassword = 'password123';

  final TextEditingController _emailController = TextEditingController(
    text: _hardcodedEmail,
  );
  final TextEditingController _passwordController = TextEditingController(
    text: _hardcodedPassword,
  );

  bool _hide = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _isEmailValid =>
      _emailController.text.trim().toLowerCase() == _hardcodedEmail;

  void _handleSignIn() {
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text;

    if (email == _hardcodedEmail && password == _hardcodedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainShell()),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Invalid staff email or password.',
          style: inter(12, w: FontWeight.w500, c: kWhite),
        ),
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  InputDecoration _dec(IconData icon, {Widget? suffix, String? hint}) =>
      InputDecoration(
        hintText: hint,
        hintStyle: inter(14, c: Colors.grey),
        prefixIcon: Icon(icon, color: kDark),
        suffixIcon: suffix,
        filled: true,
        fillColor: kWhite,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kDark, width: 1.5),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(28),
                ),
                clipBehavior: Clip.antiAlias,
                child: Center(
                  child: Image.asset(
                    'assets/logo.jpeg',
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Asset not loaded: assets/logo.jpeg\nCheck pubspec.yaml and restart the app.',
                        textAlign: TextAlign.center,
                        style: inter(12, c: Colors.white70),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text('Staff Email', style: inter(15, w: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                onChanged: (_) => setState(() {}),
                keyboardType: TextInputType.emailAddress,
                style: inter(14),
                decoration: _dec(
                  Icons.mail_outline,
                  hint: _hardcodedEmail,
                  suffix: _isEmailValid
                      ? const Icon(Icons.check_circle, color: Color(0xFF4CAF50))
                      : null,
                ),
              ),
              const SizedBox(height: 18),
              Text('Password', style: inter(15, w: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _hide,
                style: inter(14),
                decoration: _dec(
                  Icons.lock_outline,
                  hint: 'Enter password',
                  suffix: IconButton(
                    icon: Icon(
                      _hide
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: kDark,
                    ),
                    onPressed: () => setState(() => _hide = !_hide),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kDark,
                    foregroundColor: kWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _handleSignIn,
                  child: Text(
                    'Sign In',
                    style: inter(16, w: FontWeight.w500, c: kWhite),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F1E7),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shield,
                      color: Color(0xFF4CAF50),
                      size: 36,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'STAFF & ADMIN ONLY',
                          style: inter(
                            13,
                            w: FontWeight.w700,
                            c: const Color(0xFF1B5E3A),
                          ),
                        ),
                        Text(
                          'Customer access is not available.',
                          style: inter(11, c: const Color(0xFF1B5E3A)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
