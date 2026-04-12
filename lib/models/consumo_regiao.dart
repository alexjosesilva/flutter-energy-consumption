class ConsumoRegiao {
  final String regiao;
  final double valor;

  ConsumoRegiao({
    required this.regiao,
    required this.valor,
  });

  factory ConsumoRegiao.fromJson(Map<String, dynamic> json) {
    return ConsumoRegiao(
      regiao: json['regiao'] as String,
      valor: (json['valor'] as num).toDouble(),
    );
  }
}