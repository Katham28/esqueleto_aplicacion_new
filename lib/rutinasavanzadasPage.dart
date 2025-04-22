import 'package:flutter/material.dart';
import 'comandos_voz.dart';
import 'wifi_controller.dart';
import 'rutinas.dart';

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

    final Map<String, Function()> commandActions = {
      'uno': () =>  Rutinas.ejecutarRutinaAvanzada(context,0),
      'dos': () =>  Rutinas.ejecutarRutinaAvanzada(context, 1),
      'tres': () =>  Rutinas.ejecutarRutinaAvanzada(context, 2),
      'cuatro': () =>  Rutinas.ejecutarRutinaAvanzada(context, 3),
    };

    _voiceHandler = ContinuousVoiceHandler(
      context: context,
      commandRoutes: {},
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

    if (widget.commandToExecute != null) {
      final index = rutinas.indexOf(widget.commandToExecute!);
      if (index != -1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
           Rutinas.ejecutarRutinaAvanzada(context, index);
        });
      }
    }
  }

  void _ejecutarRutina(int index) {
    if (!mounted) return;

    final comando = 'ejercicio${index + 1}'; // ejemplo: ejercicio1
    WifiController.enviarComando(comando);   // aquí lo usas

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('🦿 Ejecutando: ${rutinas[index]}')),
    );
  }

  @override
  void dispose() {
    _voiceHandler.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rehabilitación Avanzada++'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF0D1B2A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset('assets/rut_reha_avanzada.png', height: 40, width: 40),
                    ),
                    SizedBox(width: 16),
                    Expanded(child: Text(rutinas[index], style: TextStyle(fontSize: 18))),
                    ElevatedButton(
                      onPressed: () => Rutinas.ejecutarRutinaAvanzada(context, index),
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
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFC8102E),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text('Apagar Exoesqueleto', style: TextStyle(fontSize: 16)),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
