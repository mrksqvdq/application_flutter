class OperatorData {
  final String id;
  final String name;
  final String shift;
  final String machine;
  final int totalProduction;
  final int qualityRate;
  final String status;

  OperatorData({
    required this.id,
    required this.name,
    required this.shift,
    required this.machine,
    required this.totalProduction,
    required this.qualityRate,
    required this.status,
  });

  factory OperatorData.fromJson(Map<String, dynamic> json) {
    return OperatorData(
      id: json['id'],
      name: json['name'],
      shift: json['shift'],
      machine: json['machine'],
      totalProduction: json['totalProduction'],
      qualityRate: json['qualityRate'],
      status: json['status'],
    );
  }
}
