class PrevisaoDemanda {
  final String mes;
  final double demanda;

  PrevisaoDemanda({
    required this.mes,
    required this.demanda,
  });

  factory PrevisaoDemanda.fromJson(Map<String, dynamic> json) {
    return PrevisaoDemanda(
      mes: json['mes'] as String,
      demanda: (json['demanda'] as num).toDouble(),
    );
  }
}