import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/background_pattern.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const Color orangeBg = Color(0xFFFF5A1F);
  static const Color orangeButton = Color(0xFFFF5A1F);
  static const Color textDark = Color(0xFF222222);
  static const Color textLight = Color(0xFF9A9A9A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orangeBg,
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundPattern(),
            Center(
              child: Container(
                width: 340,
                height: 740,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: orangeBg,
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Center(
                  child: Container(
                    width: 285,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 28,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: textDark,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Create your new account',
                          style: TextStyle(
                            fontSize: 12,
                            color: textLight,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 28),
                        const InputField(
                          label: 'Full Name',
                          hint: 'John Doe',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),
                        const InputField(
                          label: 'Email',
                          hint: 'example@email.com',
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 16),
                        const InputField(
                          label: 'Password',
                          hint: '••••••••••',
                          icon: Icons.lock_outline,
                          obscure: true,
                        ),
                        const SizedBox(height: 16),
                        const InputField(
                          label: 'Confirm Password',
                          hint: '••••••••••',
                          icon: Icons.lock_outline,
                          obscure: true,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: orangeButton,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: textLight,
                                fontSize: 12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Login',
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}