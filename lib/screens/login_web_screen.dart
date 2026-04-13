import 'package:flutter/material.dart';
import '../widgets/background_pattern.dart';
import 'base_login_screen.dart';

class LoginWebScreen extends BaseLoginScreen {
  const LoginWebScreen({super.key});

  @override
  State<LoginWebScreen> createState() => _LoginWebScreenState();
}

class _LoginWebScreenState extends BaseLoginScreenState<LoginWebScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseLoginScreenState.orangeBg,
      body: Stack(
        children: [
          const BackgroundPattern(),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'B2B + Governo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 46,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Plataforma para análise de consumo de energia, previsão de demanda e alertas de desperdício.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Versão web com foco em visualização e acesso rápido aos módulos do sistema.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 420,
                      child: buildLoginForm(maxWidth: 420),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}