class TowerLocationModel {
  final String id;
  final String towerName;
  final double latitude;   // خط العرض (GPS)
  final double longitude;  // خط الطول (GPS)
  final String address;    // المنطقة أو الوصف

  TowerLocationModel({
    required this.id,
    required this.towerName,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory TowerLocationModel.fromJson(Map<String, dynamic> json) {
    return TowerLocationModel(
      id: json['id'] ?? '',
      towerName: json['towerName'] ?? 'برج جديد',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      address: json['address'] ?? '',
    );
  }
}
