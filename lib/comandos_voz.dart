import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
//import 'inicioPage.dart';
//import 'rutinasavanzadasPage.dart';
import 'rutinas.dart';
class ContinuousVoiceHandler {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final BuildContext context;
  final Map<String, WidgetBuilder> _commandRoutes;
  final String _notRecognizedMessage;
  final String _activationCommand;
  final Function(bool isEnabled)? onStatusChanged;


  bool _isEnabled = false;
  bool _isProcessing = false;

  final List<String> _deactivationCommands = [
    'terminar',
    'gracias asistente',
    'silencio',
  ];

  final List<String> rutinas = [
    'Rutina de Marcha',
    'Rutina de Piernas',
    'Rutina de Equilibrio',
    'Rehabilitación Avanzada++',
  ];


    final List<String> comma = [
    'marcha',
    'piernas',
    'equilibrio',
    'avanzada',
  ];


  ContinuousVoiceHandler({
    required this.context,
    required Map<String, WidgetBuilder> commandRoutes,
    String notRecognizedMessage = 'Comando no reconocido',
    String activationCommand = 'iniciar',
    this.onStatusChanged,
  })  : _commandRoutes = commandRoutes,
        _notRecognizedMessage = notRecognizedMessage,
        _activationCommand = activationCommand.toLowerCase();

  Future<void> initializeContinuousListening() async {
    if (!await _speech.initialize()) {
      debugPrint('El reconocimiento de voz no está disponible');
      return;
    }
    _startListening();
    _showListeningStatus();
  }

  void _startListening() {
    _speech.listen(
      onResult: (result) => _processContinuousCommand(result.recognizedWords),
      listenFor: Duration(hours: 1),
      pauseFor: Duration(seconds: 5),
      localeId: 'es-ES',
      listenMode: stt.ListenMode.dictation,
    );
  }

  void _restartListening() async {
    if (_speech.isListening) {
      //await _speech.stop();
    }
    await Future.delayed(Duration(milliseconds: 300));
    _startListening();
  }

  void _processContinuousCommand(String command) async {
    if (_isProcessing) return;

    _isProcessing = true;

    command = command.trim().toLowerCase();
    debugPrint('Escuchado: $command');

    if (!_isEnabled && command.contains(_activationCommand)) {
      _isEnabled = true;
      onStatusChanged?.call(_isEnabled);
      _showFeedback('Asistente activado. Di un comando.');
      _isProcessing = false;
      _restartListening();
      return;
    }

    if (!_isEnabled) {
      _isProcessing = false;
      //_restartListening();
      return;
    }

    // Desactivación
    if (_deactivationCommands.any((phrase) => command.contains(phrase))) {
      _isEnabled = false;
      onStatusChanged?.call(_isEnabled);
      _showFeedback('Asistente desactivado.');
      _isProcessing = false;
      _restartListening();
      return;
    }

    // Comandos conocidos
    bool matched = false;
    for (var cmd in _commandRoutes.keys) {
      if (command.contains(cmd.toLowerCase())) {
        _navigateToScreen(cmd);
        matched = true;
        _restartListening();
        break;
      }
    }

    // Comandos de rutina      
    for (int i = 0; i < rutinas.length; i++) {
        if (command.contains(comma[i].toLowerCase())) {
           matched = true;
          Future.delayed(Duration(milliseconds: 300), () {
            
            Rutinas.ejecutarRutina(context, i);

           
          });
          debugPrint('*********Ejecutando rutina x voz: ${rutinas[i]}');
           _restartListening();
          break;
        }
      }


      if (command.contains("desconectar")) {
        Rutinas.navegarDesconectar(context);
        matched = true;
        _restartListening();
        
      }


    // Comando no reconocido
    if (!matched && command.isNotEmpty) {
      _showFeedback(_notRecognizedMessage);
      _restartListening();
    }

    _isProcessing = false;
    _restartListening();
  }


  void _navigateToScreen(String command) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: _commandRoutes[command]!),
    );
   // _showFeedback('Navegando a "$command"...');
    _restartListening();
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showListeningStatus() {
    _showFeedback('Escuchando. Di "$_activationCommand" para activar.');
  }

  void stopListening() {
    _speech.stop();
    _isEnabled = false;
    onStatusChanged?.call(_isEnabled);
  }

  bool isListening() => _speech.isListening;
}
