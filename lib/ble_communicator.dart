// lib/communications/ble_communicator.dart
// Bluetooth Low Energy implementation updated to fix firstWhere error.

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'exo_communicator.dart';

class BleCommunicator implements ExoCommunicator {
  final Guid serviceUuid = Guid('12345678-1234-5678-1234-56789abcdef0');
  final Guid charUuidCmd = Guid('12345678-1234-5678-1234-56789abcdef1');

  late BluetoothCharacteristic _cmdChar;
  late BluetoothDevice _device;

  @override
Future<bool> connect() async {
  try {
    // Inicia escaneo
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    // Espera resultados
    final List<ScanResult> results = await FlutterBluePlus.scanResults
        .firstWhere((list) => list.any((r) =>
            r.advertisementData.serviceUuids.contains(serviceUuid.toString())))
        .timeout(const Duration(seconds: 5), onTimeout: () => []);

    if (results.isEmpty) return false;
    
    await FlutterBluePlus.stopScan();

    // Encuentra dispositivo
    try {
      final match = results.firstWhere((r) =>
          r.advertisementData.serviceUuids.contains(serviceUuid.toString()));
      _device = match.device;
    } catch (e) {
      return false;
    }

    // Conecta
    await _device.connect(timeout: const Duration(seconds: 10));

    // Descubre servicios
    final services = await _device.discoverServices();
    final service = services.firstWhere((s) => s.uuid == serviceUuid);
    _cmdChar = service.characteristics.firstWhere((c) => c.uuid == charUuidCmd);

    return true;
    
  } catch (e) {
    await FlutterBluePlus.stopScan();
    return false;
  }
}

  @override
  Future<void> sendCommand(String command) async {
    await _cmdChar.write(command.codeUnits, withoutResponse: true);
  }

  @override
  Future<void> disconnect() async {
    await _device.disconnect();
  }
}
