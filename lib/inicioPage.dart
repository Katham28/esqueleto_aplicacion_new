// lib/inicioPage.dart (versión combinada BLE y WiFi lista para producción)
import 'package:flutter/material.dart';
import 'rutinasPage.dart';
import 'rutinasavanzadasPage.dart';
import 'comandos_voz.dart';
import 'ble_communicator.dart';
import 'comm_provider.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  late ContinuousVoiceHandler _voiceHandler;
  final bleCommunicator = BleCommunicator();
  bool _isAssistantActive = false;

  @override
  void initState() {
    super.initState();
    _conectarWifi();

    final commandRoutes = {
      'conectar': (context) => const rutinasPage(),
      'desconectar': (context) => const InicioPage(),
      'avanzado': (context) => const RutinasAvanzadasPage(),
    };

    _voiceHandler = ContinuousVoiceHandler(
      context: context,
      commandRoutes: commandRoutes,
      notRecognizedMessage: 'Comando no reconocido',
      activationCommand: 'iniciar',
      onStatusChanged: (isEnabled) {
        setState(() {
          _isAssistantActive = isEnabled;
        });
      },
    );

    _voiceHandler.initializeContinuousListening();
  }

  Future<void> _conectarWifi() async {
    try {
      await CommProvider.initWifi('192.168.4.1');
      debugPrint('✅ Conectado por WiFi');
    } catch (e) {
      debugPrint('❌ Error al conectar por WiFi: $e');
    }
  }

  @override
  void dispose() {
    _voiceHandler.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control Exoesqueleto')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              _isAssistantActive ? '🟢 Asistente escuchando' : '🔴 Asistente desactivado',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                      //  final ok = await bleCommunicator.connect();
                        //if (ok) {
                         // debugPrint('✅ Conexión BLE exitosa');
                         // if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const rutinasPage()),
                            );
                         // }
                        //} else {
                          //debugPrint('⚠️ Conexión BLE fallida');
                       // }
                      } catch (e) {
                        //await bleCommunicator.disconnect();
                        //debugPrint('❌ Error BLE: $e');
                      }
                    },
                    child: const Text('Conectar Exoesqueleto'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
