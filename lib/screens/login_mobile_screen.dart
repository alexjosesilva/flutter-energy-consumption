import 'package:flutter/material.dart';
import '../widgets/background_pattern.dart';
import 'base_login_screen.dart';

class LoginMobileScreen extends BaseLoginScreen {
  const LoginMobileScreen({super.key});

  @override
  State<LoginMobileScreen> createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState
    extends BaseLoginScreenState<LoginMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseLoginScreenState.orangeBg,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundPattern(),
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 32,
                    ),
                    child: Center(
                      child: Container(
                        width: 340,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: BaseLoginScreenState.orangeBg,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Center(
                          child: buildLoginForm(maxWidth: 285),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}