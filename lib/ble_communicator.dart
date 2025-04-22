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
  Future<void> connect() async {
    // Inicia un escaneo corto
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    // Espera hasta encontrar al dispositivo que anuncie el servicio esperado
    final List<ScanResult> results = await FlutterBluePlus.scanResults.firstWhere(
          (list) => list.any((r) =>
          r.advertisementData.serviceUuids.contains(serviceUuid.toString())),
    );

    // Detén el escaneo para ahorrar batería
    await FlutterBluePlus.stopScan();

    // Selecciona el primer dispositivo coincidente
    final ScanResult match = results.firstWhere((r) =>
        r.advertisementData.serviceUuids.contains(serviceUuid.toString()));
    _device = match.device;

    // Conéctate al dispositivo
    await _device.connect();

    // Descubre servicios y características
    final services = await _device.discoverServices();
    final service = services.firstWhere((s) => s.uuid == serviceUuid);
    _cmdChar = service.characteristics.firstWhere((c) => c.uuid == charUuidCmd);
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
