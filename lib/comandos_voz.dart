import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'rutinas.dart';

/// Maneja el reconocimiento de voz continuo para toda la app.
/// Se mantiene vivo aunque cambies de pantalla y se recupera
/// solo tras silencios o al volver del segundo plano.
class ContinuousVoiceHandler with WidgetsBindingObserver {
  // ========= CONFIGURACIÓN =========
  final stt.SpeechToText _speech = stt.SpeechToText();
  final BuildContext context;
  final Map<String, WidgetBuilder> _commandRoutes;
  final String _notRecognizedMessage;
  final String _activationCommand;
  final Function(bool isEnabled)? onStatusChanged;
  Function(String)? _customCommandHandler;

  bool _isEnabled = false;
  bool _isProcessing = false;

  // Comandos “globales”
  final List<String> _deactivationCommands = [
    'terminar',
    'gracias asistente',
    'silencio',
  ];

  final List<String> _rutinas = [
    'marcha',
    'piernas',
    'equilibrio',
    'avanzada',
  ];

  final List<String> _rutinasAv = [
    'uno',
    'dos',
    'tres',
    'cuatro',
  ];

  ContinuousVoiceHandler({
    required this.context,
    required Map<String, WidgetBuilder> commandRoutes,
    String notRecognizedMessage = 'Perdón, no entendí.',
    String activationCommand = 'iniciar',
    this.onStatusChanged,
  }) : _commandRoutes = commandRoutes,
        _notRecognizedMessage = notRecognizedMessage,
        _activationCommand = activationCommand.toLowerCase() {
    WidgetsBinding.instance.addObserver(this);
  }

  // ========= INICIALIZACIÓN =========
  Future<void> initializeContinuousListening() async {
    final ok = await _speech.initialize(
      onStatus: _statusListener,
      onError: (error) {
        debugPrint('STT error: $error');
        _restartListening();
      },
    );
    if (!ok) {
      debugPrint('El reconocimiento de voz no está disponible.');
      return;
    }
    _startListening();
    _showListeningStatus();
  }

  // ========= ESCUCHA / REESCÚCHA =========
  void _startListening() {
    _speech.listen(
      onResult: (result) => _processContinuousCommand(result.recognizedWords),
      listenFor: const Duration(hours: 1),
      pauseFor: const Duration(seconds: 10),
      partialResults: true,
      localeId: 'es-MX',                // cambia a tu preferencia
      listenMode: stt.ListenMode.dictation,
    );
  }

  void _restartListening() async {
    if (_speech.isListening) {
      await _speech.stop();
    }
    await Future.delayed(const Duration(milliseconds: 300));
    _startListening();
  }

  void _statusListener(String status) {
    if (status == 'notListening') {
      _restartListening();
    }
  }

  // ========= PROCESADO DE COMANDOS =========
  void _processContinuousCommand(String command) async {
    if (_isProcessing) return;
    _isProcessing = true;

    command = command.trim().toLowerCase();
    debugPrint('‑ Escuchado: $command');

    // Activación / desactivación
    if (!_isEnabled && command.contains(_activationCommand)) {
      _isEnabled = true;
      onStatusChanged?.call(_isEnabled);
      _showFeedback('Asistente activado. Di un comando.');
      _isProcessing = false;
      _restartListening();
      return;
    } else if (_isEnabled && _deactivationCommands.any(command.contains)) {
      _isEnabled = false;
      onStatusChanged?.call(_isEnabled);
      _showFeedback('Asistente desactivado.');
      _isProcessing = false;
      _restartListening();
      return;
    }

    bool matched = false;

    // Navegación básica
    for (final key in _commandRoutes.keys) {
      if (command.contains(key.toLowerCase())) {
        _navigateToScreen(key);
        matched = true;
        _restartListening();
        break;
      }
    }

    // Rutinas normales
    for (int i = 0; i < _rutinas.length && !matched; i++) {
      if (command.contains(_rutinas[i])) {
        matched = true;
        Future.delayed(const Duration(milliseconds: 300),
                () => Rutinas.ejecutarRutina(context, i));
        debugPrint('‑‑> Rutina $i vía voz');
        _restartListening();
      }
    }

    // Rutinas avanzadas
    for (int i = 0; i < _rutinasAv.length && !matched; i++) {
      if (command.contains(_rutinasAv[i])) {
        matched = true;
        Future.delayed(const Duration(milliseconds: 300),
                () => Rutinas.ejecutarRutinaAvanzada(context, i));
        debugPrint('‑‑> Rutina avanzada $i vía voz');
        _restartListening();
      }
    }

    // Comando “desconectar”
    if (!matched && command.contains('desconectar')) {
      Rutinas.navegarDesconectar(context);
      matched = true;
      _restartListening();
    }

    // Handler personalizado (por pantalla)
    if (!matched && _customCommandHandler != null) {
      _customCommandHandler!(command);
      matched = true;
      _restartListening();
    }

    // Nada coincidió
    if (!matched) {
      _showFeedback(_notRecognizedMessage);
      _restartListening();
    }

    _isProcessing = false;
  }

  void _navigateToScreen(String cmd) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: _commandRoutes[cmd]!),
    );
  }

  // ========= UTILIDADES =========
  void _showFeedback(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  void _showListeningStatus() {
    _showFeedback('Escuchando… Di “$_activationCommand” para activar.');
  }

  // ========= INTERFAZ PÚBLICA =========
  void stopListening() {
    _speech.stop();
    _isEnabled = false;
    onStatusChanged?.call(_isEnabled);
  }

  bool isListening() => _speech.isListening;

  void setCustomCommandHandler(Function(String) handler) {
    _customCommandHandler = handler;
    _restartListening();
  }

  // ========= CICLO DE VIDA APP =========
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_speech.isListening) {
      _restartListening();
    } else if (state == AppLifecycleState.paused) {
      _speech.stop();
    }
  }

  void dispose() {
    stopListening();
    WidgetsBinding.instance.removeObserver(this);
  }
}
