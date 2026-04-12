import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'submernu/analise_consumo_regiao_screen.dart';
import 'submernu/alertas_desperdicio_screen.dart';
import 'submernu/previsao_demanda_screen.dart'; 
import 'submernu/perfil_usuario_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const Color orangeDark = Color(0xFFFF6D00);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'Usuário autenticado';

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: orangeDark,
                child: const Text(
                  'B2B + Governo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.bar_chart),
                title: const Text('Análise de consumo por região'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AnaliseConsumoRegiaoScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.show_chart),
                title: const Text('Previsão de demanda'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PrevisaoDemandaScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.warning_amber_rounded),
                title: const Text('Alertas de desperdício'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AlertasDesperdicioScreen(),
                    ),
                  );
                },
              ),
               ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Perfil usuário'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PerfilUsuarioScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFF7A00),
                  Color(0xFFFF5A1F),
                  Color(0xFFE63E62),
                ],
              ),
            ),
          ),

          Positioned(
            top: 80,
            left: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: 40,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 120,
            right: 30,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 220,
            right: 40,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 180,
            left: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 20,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

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
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
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
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'B2B Governo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.white,
                      foregroundColor: orangeDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('SAIR'),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}