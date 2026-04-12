import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/previsao_demanda.dart';

class PrevisaoDemandaService {
  static const String baseUrl =
      'https://b-2-bgoverno-apifast--alexjose.replit.app';

  Future<List<PrevisaoDemanda>> buscarPrevisao({
    int ano = 2026,
    String regiao = 'Nordeste',
  }) async {
    final uri = Uri.parse(
      '$baseUrl/api/previsao/demanda?ano=$ano&regiao=$regiao',
    );

    final response = await http.get(uri).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao buscar previsão: ${response.statusCode}',
      );
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data
        .map((item) => PrevisaoDemanda.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}