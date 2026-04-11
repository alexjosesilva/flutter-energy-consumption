import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/input_field.dart';
import '../widgets/background_pattern.dart';
import 'welcome_screen.dart'; // ajuste se o nome/rota for diferente

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const Color orangeBg = Color(0xFFFF5A1F);
  static const Color orangeButton = Color(0xFFFF5A1F);
  static const Color textDark = Color(0xFF222222);
  static const Color textLight = Color(0xFF9A9A9A);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _registerUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showMessage('Preencha todos os campos.');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('As senhas não coincidem.');
      return;
    }

    if (password.length < 6) {
      _showMessage('A senha deve ter pelo menos 6 caracteres.');
      return;
    }

    try {
      setState(() => _isLoading = true);

      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        _showMessage('Não foi possível criar o usuário.');
        return;
      }

      await user.updateDisplayName(name);

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance.collection('register_history').add({
        'uid': user.uid,
        'name': name,
        'email': email,
        'registeredAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      _showMessage('Conta criada com sucesso!');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WelcomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Erro ao criar conta.';

      switch (e.code) {
        case 'email-already-in-use':
          message = 'Este e-mail já está em uso.';
          break;
        case 'invalid-email':
          message = 'E-mail inválido.';
          break;
        case 'weak-password':
          message = 'Senha muito fraca.';
          break;
        case 'operation-not-allowed':
          message = 'Cadastro por e-mail/senha não está habilitado no Firebase.';
          break;
      }

      _showMessage(message);
    } catch (e) {
      _showMessage('Erro inesperado: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RegisterScreen.orangeBg,
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundPattern(),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: 340,
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: RegisterScreen.orangeBg,
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
                                  color: RegisterScreen.textDark,
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
                              color: RegisterScreen.textDark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Create your new account',
                            style: TextStyle(
                              fontSize: 12,
                              color: RegisterScreen.textLight,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 28),

                          InputField(
                            label: 'Full Name',
                            hint: 'John Doe',
                            icon: Icons.person_outline,
                            controller: _nameController,
                          ),
                          const SizedBox(height: 16),

                          InputField(
                            label: 'Email',
                            hint: 'example@email.com',
                            icon: Icons.email_outlined,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),

                          InputField(
                            label: 'Password',
                            hint: '••••••••••',
                            icon: Icons.lock_outline,
                            obscure: true,
                            controller: _passwordController,
                          ),
                          const SizedBox(height: 16),

                          InputField(
                            label: 'Confirm Password',
                            hint: '••••••••••',
                            icon: Icons.lock_outline,
                            obscure: true,
                            controller: _confirmPasswordController,
                          ),
                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _registerUser,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: RegisterScreen.orangeButton,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
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
                                  color: RegisterScreen.textLight,
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
                                    color: RegisterScreen.orangeButton,
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
            ),
          ],
        ),
      ),
    );
  }
}