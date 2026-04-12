import 'package:flutter/material.dart';

import '../../models/consumo_regiao.dart';
import '../../repositories/consumo_repository.dart';
import '../../services/consumo_service.dart';
import '../../widgets/consumo_regiao_chart.dart';
import '../../widgets/error_state.dart';
import '../../widgets/loading_state.dart';
import 'submenu_base_screen.dart';

class AnaliseConsumoRegiaoScreen extends StatefulWidget {
  const AnaliseConsumoRegiaoScreen({super.key});

  @override
  State<AnaliseConsumoRegiaoScreen> createState() =>
      _AnaliseConsumoRegiaoScreenState();
}

class _AnaliseConsumoRegiaoScreenState
    extends State<AnaliseConsumoRegiaoScreen> {
  late Future<List<ConsumoRegiao>> _future;

  final ConsumoRepository _repository = ConsumoRepository(
    service: ConsumoService(),
  );

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() {
    _future = _repository.obterConsumoPorRegiao(
      ano: 2026,
      indicador: 'DEC',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SubmenuBaseScreen(
      title: 'Análise de consumo por região',
      child: FutureBuilder<List<ConsumoRegiao>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState(
              message: 'Carregando consumo por região...',
            );
          }

          if (snapshot.hasError) {
            return ErrorState(
              message: 'Erro ao carregar dados reais.',
              onRetry: () {
                setState(() {
                  _carregarDados();
                });
              },
            );
          }

          final dados = snapshot.data ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 24,
              bottom: 24,
            ),
            child: ConsumoRegiaoChart(dados: dados),
          );
        },
      ),
    );
  }
}