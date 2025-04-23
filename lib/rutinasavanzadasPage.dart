// lib/rutinasavanzadasPage.dart (versión FINAL)
import 'package:flutter/material.dart';
import 'comandos_voz.dart';
import 'rutinas.dart';
import 'rutinasPage.dart';

class RutinasAvanzadasPage extends StatefulWidget {
  final String? commandToExecute;
  const RutinasAvanzadasPage({Key? key, this.commandToExecute}) : super(key: key);

  @override
  State<RutinasAvanzadasPage> createState() => _RutinasAvanzadasPageState();
}

class _RutinasAvanzadasPageState extends State<RutinasAvanzadasPage> {
  late ContinuousVoiceHandler _voiceHandler;
  final List<String> rutinas = [
    'Ejercicio avanzado 1',
    'Ejercicio avanzado 2',
    'Ejercicio avanzado 3',
    'Ejercicio avanzado 4',
  ];

  @override
  void initState() {
    super.initState();

    // Mapeo de comandos de voz a acciones
    final Map<String, Function()> commandActions = {
      'uno': () => _executeRutinaAvanzada(0),
      'dos': () => _executeRutinaAvanzada(1),
      'tres': () => _executeRutinaAvanzada(2),
      'cuatro': () => _executeRutinaAvanzada(3),
      'regresa': () => _goBackToRutinas(),
      'atras': () => _goBackToRutinas(),
      'volver': () => _goBackToRutinas(),
      'desconectar': () => _desconectarExo(),
    };

    _voiceHandler = ContinuousVoiceHandler(
      context: context,
      commandRoutes: {}, // No rutas de navegación por defecto
      activationCommand: 'iniciar',
    );

    _voiceHandler.setCustomCommandHandler((String command) {
      for (var key in commandActions.keys) {
        if (command.contains(key)) {
          commandActions[key]!();
          break;
        }
      }
    });

    _voiceHandler.initializeContinuousListening();
  }

  void _executeRutinaAvanzada(int index) {
    Rutinas.ejecutarRutinaAvanzada(context, index);
    
  }

  void _goBackToRutinas() {
    
    Navigator.pop(context);
  }

  void _desconectarExo() {
    
    Rutinas.navegarDesconectar(context);
  }

  @override
  void dispose() {
    _voiceHandler.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rutinas Avanzadas')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: rutinas.length,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1B263B),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(child: Text(rutinas[index], style: TextStyle(fontSize: 18))),
                    ElevatedButton(
                      onPressed: () => _executeRutinaAvanzada(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF003566),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Iniciar', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _goBackToRutinas(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFC8102E),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text('Regresa a Rutinas', style: TextStyle(fontSize: 16)),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
