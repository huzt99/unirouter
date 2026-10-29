import 'dart:io';
import '../models/tower_device.dart';

class NetworkService {
  // فحص حالة اتصال جهاز عبر الـ Ping
  static Future<bool> checkDeviceStatus(String ipAddress) async {
    try {
      final result = await Process.run(
        'ping',
        [Platform.isWindows ? '-n' : '-c', '1', '-w', '1000', ipAddress],
      );
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  // فحص قائمة أجهزة البرج
  static Future<List<TowerDevice>> scanTowerDevices(List<TowerDevice> devices) async {
    List<TowerDevice> updatedDevices = [];
    for (var device in devices) {
      bool online = await checkDeviceStatus(device.ipAddress);
      device.isOnline = online;
      updatedDevices.add(device);
    }
    return updatedDevices;
  }
}
