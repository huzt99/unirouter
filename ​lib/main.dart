import 'package:flutter/material.dart';
import 'models/tower_device.dart';
import 'services/network_service.dart';

void main() {
  runApp(const UniRouterApp());
}

class UniRouterApp extends StatelessWidget {
  const UniRouterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniRouter Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TowerDashboardScreen(),
    );
  }
}

class TowerDashboardScreen extends StatefulWidget {
  const TowerDashboardScreen({super.key});

  @override
  State<TowerDashboardScreen> createState() => _TowerDashboardScreenState();
}

class _TowerDashboardScreenState extends State<TowerDashboardScreen> {
  List<TowerDevice> towerDevices = [
    TowerDevice(id: '1', name: 'MikroTik Core Router', ipAddress: '192.168.88.1', type: DeviceType.mikrotik),
    TowerDevice(id: '2', name: 'Ubiquiti Main Link', ipAddress: '192.168.1.20', type: DeviceType.ubiquiti),
    TowerDevice(id: '3', name: 'Huawei OLT / Fiber', ipAddress: '192.168.100.1', type: DeviceType.olt),
  ];

  bool isLoading = false;

  void refreshDevices() async {
    setState(() => isLoading = true);
    var updatedList = await NetworkService.scanTowerDevices(towerDevices);
    setState(() {
      towerDevices = updatedList;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة أجهزة البرج - UniRouter'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: isLoading ? null : refreshDevices,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: towerDevices.length,
              itemBuilder: (context, index) {
                final device = towerDevices[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      device.type == DeviceType.mikrotik
                          ? Icons.router
                          : device.type == DeviceType.ubiquiti
                              ? Icons.settings_input_antenna
                              : Icons.developer_board,
                      color: Colors.blue,
                      size: 32,
                    ),
                    title: Text(device.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('IP: ${device.ipAddress}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: device.isOnline ? Colors.green.withAlpha(50) : Colors.red.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: device.isOnline ? Colors.green : Colors.red),
                      ),
                      child: Text(
                        device.isOnline ? 'متصل' : 'غير متصل',
                        style: TextStyle(
                          color: device.isOnline ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
