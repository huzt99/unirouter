class MikroTikStatus {
  final String identity;    // اسم جهاز الميكروتك
  final String cpuLoad;     // نسبة استخدام المعالج %
  final String freeMemory;  // الذاكرة الفارغة
  final String uptime;      // مدة التوريد والتطبيق بدون إطفاء
  final int activeUsers;    // عدد المشتركين الأونلاين حالياً

  MikroTikStatus({
    required this.identity,
    required this.cpuLoad,
    required this.freeMemory,
    required this.uptime,
    required this.activeUsers,
  });

  // تحويل البيانات القادمة من الجهاز إلى كائن برمجياً
  factory MikroTikStatus.fromJson(Map<String, dynamic> json) {
    return MikroTikStatus(
      identity: json['identity'] ?? 'MikroTik Router',
      cpuLoad: json['cpu-load'] ?? '0%',
      freeMemory: json['free-memory'] ?? '0MB',
      uptime: json['uptime'] ?? '0d 0h',
      activeUsers: json['active-users'] ?? 0,
    );
  }
}
