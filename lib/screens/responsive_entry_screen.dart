import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'login_mobile_screen.dart';
import 'login_web_screen.dart';

class ResponsiveEntryScreen extends StatelessWidget {
  const ResponsiveEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const LoginWebScreen();
    }

    return const LoginMobileScreen();
  }
}