import 'package:flutter/material.dart';
import '../../models/previsao_demanda.dart';
import '../../services/previsao_demanda_service.dart';
import '../../widgets/previsao_demanda_chart.dart';

class PrevisaoDemandaScreen extends StatefulWidget {
  const PrevisaoDemandaScreen({super.key});

  @override
  State<PrevisaoDemandaScreen> createState() => _PrevisaoDemandaScreenState();
}

class _PrevisaoDemandaScreenState extends State<PrevisaoDemandaScreen> {
  final PrevisaoDemandaService _service = PrevisaoDemandaService();

  late Future<List<PrevisaoDemanda>> _future;
  String regiaoSelecionada = 'Nordeste';

  final List<String> regioes = const [
    'Norte',
    'Nordeste',
    'Centro-Oeste',
    'Sudeste',
    'Sul',
  ];

  @override
  void initState() {
    super.initState();
    _future = _service.buscarPrevisao(regiao: regiaoSelecionada);
  }

  void recarregar() {
    setState(() {
      _future = _service.buscarPrevisao(regiao: regiaoSelecionada);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previsão de Demanda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: regiaoSelecionada,
              decoration: const InputDecoration(
                labelText: 'Região',
                border: OutlineInputBorder(),
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
                if (value != null) {
                  regiaoSelecionada = value;
                  recarregar();
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<PrevisaoDemanda>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erro ao carregar previsão: ${snapshot.error}',
                      ),
                    );
                  }

                  final dados = snapshot.data ?? [];

                  if (dados.isEmpty) {
                    return const Center(
                      child: Text('Nenhum dado encontrado'),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Previsão para $regiaoSelecionada',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: PrevisaoDemandaChart(dados: dados),
                          ),
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