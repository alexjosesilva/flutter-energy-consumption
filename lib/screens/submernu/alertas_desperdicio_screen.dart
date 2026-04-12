import 'package:flutter/material.dart';
import 'submenu_base_screen.dart';

class AlertasDesperdicioScreen extends StatelessWidget {
  const AlertasDesperdicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubmenuBaseScreen(
      title: 'Alertas de desperdício',
      child: const Center(
        child: Text(
          'Em construção',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}