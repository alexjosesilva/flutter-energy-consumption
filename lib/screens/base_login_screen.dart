import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgot_screen.dart';
import 'google_choose_account_screen.dart';
import 'register_screen.dart';
import 'welcome_screen.dart';
import '../widgets/input_field.dart';

abstract class BaseLoginScreen extends StatefulWidget {
  const BaseLoginScreen({super.key});
}

abstract class BaseLoginScreenState<T extends BaseLoginScreen>
    extends State<T> {
  static const Color orangeBg = Color(0xFFFF5A1F);
  static const Color orangeButton = Color(0xFFFF5A1F);
  static const Color textDark = Color(0xFF222222);
  static const Color textLight = Color(0xFF9A9A9A);
  static const Color borderColor = Color(0xFFE9E9E9);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage('Preencha email e senha.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('login_history').add({
          'uid': user.uid,
          'email': user.email,
          'loginAt': FieldValue.serverTimestamp(),
          'platform': Theme.of(context).platform.name,
        });
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WelcomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      showMessage(e.message ?? 'Erro ao fazer login.');
    } catch (e) {
      debugPrint('Erro inesperado no login: $e');
      showMessage('Erro inesperado ao fazer login.');
    } finally {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget buildLoginForm({double? maxWidth}) {
    return Container(
      width: maxWidth,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please sign in to continue',
            style: TextStyle(
              fontSize: 12,
              color: textLight,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 32),
          InputField(
            label: 'Email',
            hint: 'example@email.com',
            icon: Icons.person_outline,
            controller: emailController,
          ),
          const SizedBox(height: 16),
          InputField(
            label: 'Password',
            hint: '••••••••••',
            icon: Icons.lock_outline,
            obscure: true,
            controller: passwordController,
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ForgotScreen()),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  color: orangeButton,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isLoading ? null : signIn,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: orangeButton,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'LOG IN',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: const [
              Expanded(child: Divider(color: borderColor)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'or',
                  style: TextStyle(
                    color: textLight,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(child: Divider(color: borderColor)),
            ],
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GoogleChooseAccountScreen(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: textDark,
              side: const BorderSide(color: borderColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(double.infinity, 48),
            ),
            icon: const Text(
              'G',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            label: const Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: textDark,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don’t have an account? ",
                style: TextStyle(
                  color: textLight,
                  fontSize: 12,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: orangeButton,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}