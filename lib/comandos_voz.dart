// voice_command_handler.dart
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;



class ContinuousVoiceHandler {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final BuildContext context;
  final Map<String, WidgetBuilder> _commandRoutes;
  final String _notRecognizedMessage;
  final String _activationCommand;
  bool _isEnabled = false;
  bool _isProcessing = false;

  ContinuousVoiceHandler({
    required this.context,
    required Map<String, WidgetBuilder> commandRoutes,
    String notRecognizedMessage = 'Comando no reconocido',
    String activationCommand = 'activar asistente',
  })  : _commandRoutes = commandRoutes,
        _notRecognizedMessage = notRecognizedMessage,
        _activationCommand = activationCommand.toLowerCase();

  /// Inicializa el reconocimiento de voz continuo
  Future<void> initializeContinuousListening() async {
    if (!await _speech.initialize()) {
      debugPrint('El reconocimiento de voz no está disponible');
      return;
    }

    _speech.listen(
      onResult: (result) => _processContinuousCommand(result.recognizedWords),
      listenFor: Duration(hours: 1), // Escucha por mucho tiempo
      pauseFor: Duration(seconds: 3),
      localeId: 'es-ES',
      listenMode: stt.ListenMode.dictation,
      onSoundLevelChange: (level) {
        // Opcional: puedes usar esto para animaciones de nivel de sonido
      },
    );

    _showListeningStatus();
  }

  /// Procesa los comandos en modo continuo
  void _processContinuousCommand(String command) {
    if (_isProcessing) return;
    
    command = command.trim().toLowerCase();
    debugPrint('Escuchado: $command');

    // Verifica el comando de activación
    if (!_isEnabled && command.contains(_activationCommand)) {
      _isEnabled = true;
      _showFeedback('Asistente activado. Di un comando.');
      return;
    }

    // Si está desactivado, ignora otros comandos
    if (!_isEnabled) return;

    _isProcessing = true;

    // Busca coincidencias en los comandos registrados
    for (var cmd in _commandRoutes.keys) {
      if (command.contains(cmd.toLowerCase())) {
        _navigateToScreen(cmd);
        _isProcessing = false;
        return;
      }
    }

    // Si no se reconoce el comando
    if (command.isNotEmpty) {
      _showFeedback(_notRecognizedMessage);
    }
    
    _isProcessing = false;
  }

  /// Navega a la pantalla correspondiente
  void _navigateToScreen(String command) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: _commandRoutes[command]!),
    );
    _showFeedback('Navegando a $command');
  }

  /// Muestra feedback al usuario
  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Muestra el estado de escucha
  void _showListeningStatus() {
    _showFeedback('Escuchando continuamente. Di "$_activationCommand" para activar');
  }

  /// Detiene el reconocimiento de voz
  void stopListening() {
    _speech.stop();
    _isEnabled = false;
  }

  /// Verifica si el reconocimiento está activo
  bool isListening() {
    return _speech.isListening;
  }
}