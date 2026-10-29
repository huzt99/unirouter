enum DeviceType {
  mikrotik,  // راوتر الميكروتك الرئيسي للبرج
  ubiquiti,  // أجهزة الربط والبث اللاسلكي (PowerBeam, LiteBeam, Sector)
  olt,       // أجهزة الفايبر (Huawei, ZTE)
  generic    // أي جهاز آخر
}

class TowerDevice {
  final String id;
  final String name;        // اسم الجهاز (مثلاً: Core-MikroTik)
  final String ipAddress;   // عنوان الـ IP
  final DeviceType type;    // نوع الجهاز
  final int port;           // منفذ الاتصال
  bool isOnline;            // حالة الاتصال

  TowerDevice({
    required this.id,
    required this.name,
    required this.ipAddress,
    required this.type,
    this.port = 80,
    this.isOnline = false,
  });
}
