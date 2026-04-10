import 'package:flutter/material.dart';

class GoogleContinueScreen extends StatelessWidget {
  const GoogleContinueScreen({super.key});

  static const Color bg = Color(0xFFF2F2F2);
  static const Color textDark = Color(0xFF202124);
  static const Color textMedium = Color(0xFF5F6368);
  static const Color border = Color(0xFFDADCE0);
  static const Color blue = Color(0xFF1A73E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            const _TopBrowserBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "You're signing back in to\nShopee",
                        style: TextStyle(
                          fontSize: 34,
                          height: 1.1,
                          fontWeight: FontWeight.w400,
                          color: textDark,
                        ),
                      ),
                      const SizedBox(height: 26),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: border),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=300&auto=format&fit=crop',
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'alexjosesilvati@gmail.com',
                              style: TextStyle(
                                fontSize: 16,
                                color: textDark,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_drop_down, color: textDark),
                            const SizedBox(width: 6),
                          ],
                        ),
                      ),
                      const SizedBox(height: 34),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 17,
                            height: 1.45,
                            color: textDark,
                          ),
                          children: [
                            TextSpan(text: "Review Shopee’s "),
                            TextSpan(
                              text: "privacy policy",
                              style: TextStyle(color: blue),
                            ),
                            TextSpan(
                              text:
                                  " and Terms of Service to understand how Shopee will process and protect your data.",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 17,
                            height: 1.45,
                            color: textDark,
                          ),
                          children: [
                            TextSpan(text: "To make changes at any time, go to your "),
                            TextSpan(
                              text: "Google\nAccount.",
                              style: TextStyle(color: blue),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 17,
                            height: 1.45,
                            color: textDark,
                          ),
                          children: [
                            TextSpan(text: "Learn more about "),
                            TextSpan(
                              text: "Sign in with Google.",
                              style: TextStyle(color: blue),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 44),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(0, 58),
                                side: const BorderSide(color: border),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(0, 58),
                                side: const BorderSide(color: border),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                  color: blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const _BottomBrowserBar(),
          ],
        ),
      ),
    );
  }
}

class _TopBrowserBar extends StatelessWidget {
  const _TopBrowserBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(34),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _CircleIconButton(
                icon: Icons.close,
                onTap: () => Navigator.pop(context),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'accounts.google.com',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: GoogleContinueScreen.textDark,
                    ),
                  ),
                ),
              ),
              _CircleIconButton(
                icon: Icons.menu_rounded,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: Text(
                    'G',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: GoogleContinueScreen.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 18,
                  color: GoogleContinueScreen.textMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomBrowserBar extends StatelessWidget {
  const _BottomBrowserBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: Color(0xFFF7F7F7),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
          ),
          const Spacer(),
          const Text(
            'English (United Kingdom)',
            style: TextStyle(
              color: Color(0xFFB4B4B4),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: Color(0xFFB4B4B4),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: const [
                Icon(Icons.ios_share_outlined, size: 28),
                SizedBox(width: 22),
                Icon(Icons.refresh, size: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Container(
        width: 58,
        height: 58,
        decoration: const BoxDecoration(
          color: Color(0xFFF1F1F1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 30, color: Colors.black87),
      ),
    );
  }
}