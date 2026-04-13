import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'submernu/analise_consumo_regiao_screen.dart';
import 'submernu/alertas_desperdicio_screen.dart';
import 'submernu/perfil_usuario_screen.dart';
import 'submernu/previsao_demanda_screen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  static const Color orangeDark = Color(0xFFFF6D00);

  int selectedIndex = 0;

  final List<Widget> pages = const [
    AnaliseConsumoRegiaoScreen(),
    PrevisaoDemandaScreen(),
    AlertasDesperdicioScreen(),
    PerfilUsuarioScreen(),
  ];

  final List<String> titles = const [
    'Análise de consumo por região',
    'Previsão de demanda',
    'Alertas de desperdício',
    'Perfil do usuário',
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'Usuário autenticado';

    final isWide = kIsWeb || MediaQuery.of(context).size.width >= 900;

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() => selectedIndex = index);
              },
              backgroundColor: orangeDark,
              labelType: NavigationRailLabelType.all,
              leading: const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Icon(Icons.bolt, color: Colors.white, size: 32),
              ),
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme:
                  const IconThemeData(color: Colors.white70),
              selectedLabelTextStyle:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              unselectedLabelTextStyle:
                  const TextStyle(color: Colors.white70),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.bar_chart),
                  label: Text('Consumo'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.show_chart),
                  label: Text('Previsão'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.warning_amber_rounded),
                  label: Text('Alertas'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('Perfil'),
                ),
              ],
              trailing: Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: IconButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (!mounted) return;
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Color(0x14000000),
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          titles[selectedIndex],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          email,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xFFF8F8F8),
                      child: pages[selectedIndex],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeDark,
        foregroundColor: Colors.white,
        title: Text(titles[selectedIndex]),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: orangeDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'B2B + Governo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      email,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.bar_chart),
                title: const Text('Análise de consumo por região'),
                onTap: () {
                  setState(() => selectedIndex = 0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.show_chart),
                title: const Text('Previsão de demanda'),
                onTap: () {
                  setState(() => selectedIndex = 1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.warning_amber_rounded),
                title: const Text('Alertas de desperdício'),
                onTap: () {
                  setState(() => selectedIndex = 2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Perfil usuário'),
                onTap: () {
                  setState(() => selectedIndex = 3);
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sair'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!mounted) return;
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}