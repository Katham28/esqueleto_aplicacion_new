// lib/communications/comm_provider.dart
// Proveedor estático que expone una única instancia de ExoCommunicator
// (Wi‑Fi o BLE) al resto de la app.

import 'exo_communicator.dart';
import 'wifi_communicator.dart';
import 'ble_communicator.dart';

class CommProvider {
  static ExoCommunicator? _instance;

  /// Inicializa usando Wi‑Fi. `ip` puede incluir puerto («192.168.4.1:8080»).
  static Future<void> initWifi(String ip) async {
    _instance = WifiCommunicator('http://$ip');
    await _instance!.connect();
  }

  /// Inicializa usando Bluetooth Low Energy.
  static Future<void> initBle() async {
    _instance = BleCommunicator();
    await _instance!.connect();
  }

  /// Devuelve la instancia activa o lanza excepción si no está configurada.
  static ExoCommunicator get instance {
    if (_instance == null) {
      throw StateError('CommProvider no inicializado');
    }
    return _instance!;
  }

  static Future<void> dispose() async {
    await _instance?.disconnect();
    _instance = null;
  }
}
