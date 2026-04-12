import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/consumo_regiao.dart';

class ConsumoService {
  // Troque pela URL real do seu backend
  static const String baseUrl = 'https://b-2-bgoverno-apifast--alexjose.replit.app/';

  Future<List<ConsumoRegiao>> buscarConsumoPorRegiao({
    int ano = 2026,
    String indicador = 'DEC',
  }) async {
    final uri = Uri.parse(
      '$baseUrl/api/consumo/regioes?ano=$ano&indicador=$indicador',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao buscar consumo por região: ${response.statusCode}',
      );
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

    return data
        .map((item) => ConsumoRegiao.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}