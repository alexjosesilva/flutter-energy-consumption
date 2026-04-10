import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const Color orangeDark = Color(0xFFB63D00);
  static const Color orangeMid = Color(0xFFFF6A00);
  static const Color orangeLight = Color(0xFFFF8C2A);
  static const Color orangePink = Color(0xFFFF4D6D);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'Usuário autenticado';

    return Scaffold(
      body: Stack(
        children: [
          const _WelcomeBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 120,
                    color: Color(0xFFE26A00),
                  ),
                ),
                const SizedBox(height: 26),
                const Text(
                  'WELCOME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Text(
                    email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: orangeDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        'SAIR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      _Dot(isActive: true),
                      SizedBox(width: 10),
                      _Dot(),
                      SizedBox(width: 10),
                      _Dot(),
                      SizedBox(width: 10),
                      _Dot(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeBackground extends StatelessWidget {
  const _WelcomeBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            WelcomeScreen.orangeDark,
            WelcomeScreen.orangeMid,
            WelcomeScreen.orangePink,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -120,
            top: 80,
            child: _circle(260, Colors.white.withOpacity(0.08)),
          ),
          Positioned(
            right: -40,
            bottom: 60,
            child: _circle(220, Colors.white.withOpacity(0.08)),
          ),
          Positioned(
            left: -30,
            bottom: 120,
            child: _circle(120, Colors.white.withOpacity(0.12)),
          ),
          Positioned(
            right: 50,
            top: 150,
            child: _circle(90, Colors.white.withOpacity(0.12)),
          ),
          Positioned(
            left: 36,
            top: 210,
            child: _circle(70, Colors.white.withOpacity(0.10)),
          ),
          Positioned(
            left: 120,
            bottom: 210,
            child: _circle(46, Colors.white.withOpacity(0.12)),
          ),
          Positioned(
            right: 90,
            bottom: 250,
            child: _circle(56, Colors.white.withOpacity(0.12)),
          ),
          Positioned(
            right: 40,
            top: 90,
            child: _circle(36, Colors.white.withOpacity(0.14)),
          ),
          Positioned(
            left: 150,
            top: 120,
            child: _circle(22, Colors.white.withOpacity(0.12)),
          ),
          Positioned(
            right: 30,
            bottom: 330,
            child: _circle(18, Colors.white.withOpacity(0.14)),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;

  const _Dot({this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.black.withOpacity(0.28),
        shape: BoxShape.circle,
      ),
    );
  }
}