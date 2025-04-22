// lib/communications/wifi_communicator.dart
// Implementación basada en HTTP (o WebSocket) sobre Wi‑Fi.

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exo_communicator.dart';

class WifiCommunicator implements ExoCommunicator {
  final String baseUrl; // p.ej.: "http://192.168.4.1"

  WifiCommunicator(this.baseUrl);

  @override
  Future<void> connect() async {
    final ping = await http
        .get(Uri.parse('$baseUrl/ping'))
        .timeout(const Duration(seconds: 3));
    if (ping.statusCode != 200) {
      throw Exception('ESP32 no responde: ${ping.statusCode}');
    }
  }

  @override
  Future<void> sendCommand(String command) async {
    await http.post(
      Uri.parse('$baseUrl/cmd'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'command': command}),
    );
  }

  @override
  Future<void> disconnect() async {
    // HTTP no mantiene sesión persistente; nada que cerrar.
  }
}
