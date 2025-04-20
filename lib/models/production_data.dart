class ProductionSummary {
  final int total;
  final int good;
  final int bad;
  final double trend;

  ProductionSummary({
    required this.total,
    required this.good,
    required this.bad,
    required this.trend,
  });

  factory ProductionSummary.fromJson(Map<String, dynamic> json) {
    return ProductionSummary(
      total: json['total'],
      good: json['good'],
      bad: json['bad'],
      trend: json['trend'].toDouble(),
    );
  }
}

class ProductionData {
  final String time;
  final int total;
  final int good;
  final int bad;

  ProductionData({
    required this.time,
    required this.total,
    required this.good,
    required this.bad,
  });

  factory ProductionData.fromJson(Map<String, dynamic> json) {
    return ProductionData(
      time: json['time'],
      total: json['total'],
      good: json['good'],
      bad: json['bad'],
    );
  }
}

class ProductionResponse {
  final ProductionSummary summary;
  final List<ProductionData> hourly;
  final List<ProductionData> daily;
  final List<ProductionData> weekly;

  ProductionResponse({
    required this.summary,
    required this.hourly,
    required this.daily,
    required this.weekly,
  });
}
