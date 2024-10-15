class UserBuild {
  final int? id;
  final String name;
  final String? description;
  final int cpu;
  final int gpu;
  final int motherboard;
  final int ram;
  final int storage;
  final int psu;
  final int? totalTdp;
  final double? totalPrice;
  final int? benchmarkScore;
  final int? user_id;

  UserBuild({
    required this.id,
    required this.name,
    required this.description,
    required this.cpu,
    required this.gpu,
    required this.motherboard,
    required this.ram,
    required this.storage,
    required this.psu,
    required this.totalTdp,
    required this.totalPrice,
    this.benchmarkScore,
    required this.user_id,
  });

  factory UserBuild.fromJson(Map<String, dynamic> json) {
    return UserBuild(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      cpu: json['cpu'],
      gpu: json['gpu'],
      motherboard: json['motherboard'],
      ram: json['ram'],
      storage: json['storage'],
      psu: json['psu'],
      totalTdp: json['total_tdp'],
      totalPrice: json['total_price'].toDouble(),
      benchmarkScore: json['benchmarkScore'],
      user_id: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'cpu': cpu,
      'gpu': gpu,
      'motherboard': motherboard,
      'ram': ram,
      'storage': storage,
      'psu': psu,
      'total_tdp': totalTdp,
      'total_price': totalPrice,
      'benchmarkScore': benchmarkScore,
      'user_id': user_id,
    };
  }
}
