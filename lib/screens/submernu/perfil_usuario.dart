import 'package:flutter/material.dart';
import 'submenu_base_screen.dart';

class PerfilusuarioScreen extends StatelessWidget {
  const PerfilusuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubmenuBaseScreen(
      title: 'Perfil do usuário',
      child: const Center(
        child: Text(
          'Perfil do usuário',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}