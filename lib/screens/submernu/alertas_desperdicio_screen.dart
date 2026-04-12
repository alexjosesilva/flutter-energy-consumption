import 'package:flutter/material.dart';
import 'submenu_base_screen.dart';

class AlertasDesperdicioScreen extends StatelessWidget {
  const AlertasDesperdicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alertas = [
      {
        'titulo': 'Consumo acima do esperado',
        'descricao':
            'A região Agreste apresentou aumento de 18% no consumo em relação ao mês anterior.',
        'icone': Icons.trending_up,
        'tipo': 'alto',
      },
      {
        'titulo': 'Pico fora do horário padrão',
        'descricao':
            'Foi identificado uso elevado entre 22h e 23h, fora da faixa habitual.',
        'icone': Icons.access_time,
        'tipo': 'medio',
      },
      {
        'titulo': 'Possível desperdício em unidade pública',
        'descricao':
            'Uma unidade apresentou consumo constante durante madrugadas consecutivas.',
        'icone': Icons.warning_amber_rounded,
        'tipo': 'alto',
      },
      {
        'titulo': 'Equipamento com uso contínuo',
        'descricao':
            'Há indício de equipamento operando sem interrupção por longo período.',
        'icone': Icons.electrical_services_outlined,
        'tipo': 'baixo',
      },
    ];

    return SubmenuBaseScreen(
      title: 'Alertas de desperdício',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monitoramento inteligente',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Acompanhe sinais de desperdício e padrões de consumo que merecem atenção.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),

            // Card resumo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.white.withOpacity(0.18),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.notifications_active_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '4 alertas encontrados',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '2 críticos, 1 moderado e 1 preventivo.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Ocorrências recentes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                itemCount: alertas.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final alerta = alertas[index];
                  return _AlertaCard(
                    titulo: alerta['titulo'] as String,
                    descricao: alerta['descricao'] as String,
                    icone: alerta['icone'] as IconData,
                    tipo: alerta['tipo'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertaCard extends StatelessWidget {
  final String titulo;
  final String descricao;
  final IconData icone;
  final String tipo;

  const _AlertaCard({
    required this.titulo,
    required this.descricao,
    required this.icone,
    required this.tipo,
  });

  Color _badgeColor() {
    switch (tipo) {
      case 'alto':
        return const Color(0xFFFFD6D6);
      case 'medio':
        return const Color(0xFFFFE9C7);
      default:
        return const Color(0xFFD9F7E3);
    }
  }

  Color _badgeTextColor() {
    switch (tipo) {
      case 'alto':
        return const Color(0xFFC62828);
      case 'medio':
        return const Color(0xFFB26A00);
      default:
        return const Color(0xFF1B8F4D);
    }
  }

  String _badgeLabel() {
    switch (tipo) {
      case 'alto':
        return 'Crítico';
      case 'medio':
        return 'Moderado';
      default:
        return 'Preventivo';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1EB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icone,
              color: const Color(0xFFFF5A1F),
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  descricao,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _badgeColor(),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _badgeLabel(),
                    style: TextStyle(
                      color: _badgeTextColor(),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
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