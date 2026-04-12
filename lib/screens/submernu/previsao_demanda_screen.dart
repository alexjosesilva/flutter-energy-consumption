import 'package:flutter/material.dart';
import 'submenu_base_screen.dart';

class PrevisaoDemandaScreen extends StatelessWidget {
  const PrevisaoDemandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubmenuBaseScreen(
      title: 'Previsão de demanda',
      child: const Center(
        child: Text(
          'Conteúdo da previsão de demanda', 
          style: TextStyle(color: Colors.white),),
      ),
    );
  }
}