import 'dart:io';

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
  File? imageFile;
  final String? image_url;

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
    this.imageFile,
    this.image_url,
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
      user_id: json['user_id'],
      image_url : json['image_url'],
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
      'image_url' : image_url,
    };
  }
}
