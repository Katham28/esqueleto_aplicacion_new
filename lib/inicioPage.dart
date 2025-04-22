import 'package:flutter/material.dart';
import 'rutinasPage.dart';
import 'rutinasavanzadasPage.dart';
import 'comandos_voz.dart';
import 'ble_communicator.dart';

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

    final commandRoutes = {
      'conectar': (context) => rutinasPage(),
      'desconectar': (context) => InicioPage(),
      'avanzado': (context) => RutinasAvanzadasPage(),
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

  @override
  void dispose() {
    _voiceHandler.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Control Exoesqueleto')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Text(
              _isAssistantActive ? '🟢 Asistente escuchando' : '🔴 Asistente desactivado',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                     try {
                      Future<bool> b=bleCommunicator.connect();
                      //print('Conexión BLE establecida correctamente');
                      // Aquí puedes actualizar el estado de la UI o habilitar funciones
                      if (b==true){
                        print('Conexión BLE establecida correctamente');

                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => rutinasPage()),
                      );

                      }else{
                        print('Conexión BLE fallida');
                      }

                       
                    } catch (e) {
                      bleCommunicator.disconnect();
                      print('Error al conectar: $e');
                      // Maneja el error (mostrar mensaje al usuario, etc.)
                    }


                     
                    },
                    child: Text('Conectar Exoesqueleto'),
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
