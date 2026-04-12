import '../models/consumo_regiao.dart';
import '../services/consumo_service.dart';

class ConsumoRepository {
  final ConsumoService service;

  ConsumoRepository({required this.service});

  Future<List<ConsumoRegiao>> obterConsumoPorRegiao({
    int ano = 2026,
    String indicador = 'DEC',
  }) {
    return service.buscarConsumoPorRegiao(
      ano: ano,
      indicador: indicador,
    );
  }
}