import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/background_pattern.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  static const Color orangeBg = Color(0xFFFF5A1F);
  static const Color orangeButton = Color(0xFFFF5A1F);
  static const Color textDark = Color(0xFF222222);
  static const Color textLight = Color(0xFF9A9A9A);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController codeController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    final code = codeController.text.trim();

    if (code.isEmpty || code.length < 6) {
      _showMessage('Informe o código de 6 dígitos.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: code,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;

      _showMessage('Telefone validado com sucesso.');
      Navigator.popUntil(context, (route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      _showMessage(_firebaseErrorMessage(e));
    } catch (_) {
      _showMessage('Erro ao validar código.');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String _firebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-verification-code':
        return 'Código inválido.';
      case 'session-expired':
        return 'Código expirado. Solicite outro.';
      case 'too-many-requests':
        return 'Muitas tentativas. Tente novamente mais tarde.';
      default:
        return e.message ?? 'Ocorreu um erro.';
    }
  }

  void _showMessage(String msg) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OtpScreen.orangeBg,
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundPattern(),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Container(
                  width: 340,
                  decoration: BoxDecoration(
                    color: OtpScreen.orangeBg,
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
                                  color: OtpScreen.textDark,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'OTP Code',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: OtpScreen.textDark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enter the code sent to ${widget.phoneNumber}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: OtpScreen.textLight,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 28),
                          TextField(
                            controller: codeController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            decoration: InputDecoration(
                              labelText: 'Código',
                              hintText: '123456',
                              counterText: '',
                              prefixIcon: const Icon(Icons.lock_outline),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE5E5E5),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: OtpScreen.orangeButton,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _verifyCode,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: OtpScreen.orangeButton,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor:
                                    OtpScreen.orangeButton.withOpacity(0.7),
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'VERIFY',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                            ),
                          ),
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