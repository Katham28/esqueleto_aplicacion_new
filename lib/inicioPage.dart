import 'package:flutter/material.dart';
import 'rutinasPage.dart';
import 'rutinasavanzadasPage.dart';
import 'comandos_voz.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  late ContinuousVoiceHandler _voiceHandler;
  bool _isAssistantActive = false;

  @override
  void initState() {
    super.initState();

    final commandRoutes = {
      'conectar': (context) => rutinasPage(),
      'desconectar': (context) => InicioPage(),
      'avanzado': (context) => rutinasavanzadas(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => rutinasPage()),
                      );
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
