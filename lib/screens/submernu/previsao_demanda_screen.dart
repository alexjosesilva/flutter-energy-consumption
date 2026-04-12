import 'package:flutter/material.dart';
import '../../models/previsao_demanda.dart';
import '../../services/previsao_demanda_service.dart';
import '../../widgets/previsao_demanda_chart.dart';
import 'submenu_base_screen.dart';

class PrevisaoDemandaScreen extends StatefulWidget {
  const PrevisaoDemandaScreen({super.key});

  @override
  State<PrevisaoDemandaScreen> createState() => _PrevisaoDemandaScreenState();
}

class _PrevisaoDemandaScreenState extends State<PrevisaoDemandaScreen> {
  final PrevisaoDemandaService _service = PrevisaoDemandaService();

  String? regiaoSelecionada;
  Future<List<PrevisaoDemanda>>? _future;

  final List<String> regioes = const [
    'Norte',
    'Nordeste',
    'Centro-Oeste',
    'Sudeste',
    'Sul',
  ];

  void recarregar() {
    if (regiaoSelecionada == null) return;

    setState(() {
      _future = _service.buscarPrevisao(
        regiao: regiaoSelecionada!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SubmenuBaseScreen(
      title: 'Previsão de Demanda',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // SELECT REGIÃO
            DropdownButtonFormField<String>(
              value: regiaoSelecionada,
              hint: const Text('Selecione uma região'),
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: regioes
                  .map(
                    (regiao) => DropdownMenuItem(
                      value: regiao,
                      child: Text(regiao),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                regiaoSelecionada = value;
                recarregar();
              },
            ),

            const SizedBox(height: 16),

            // CONTEÚDO
            Expanded(
              child: _future == null
                  ? const Center(
                      child: Text(
                        'Selecione uma região para ver a previsão',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : FutureBuilder<List<PrevisaoDemanda>>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Erro: ${snapshot.error}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        final dados = snapshot.data ?? [];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Previsão para $regiaoSelecionada',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),

                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: PrevisaoDemandaChart(dados: dados),
                              ),
                            ),
                          ],
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