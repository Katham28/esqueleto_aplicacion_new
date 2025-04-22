abstract class ExoCommunicator {
  /// Establece la conexión con el dispositivo.
  Future<void> connect();

  /// Envía un comando (cadena ASCII) al exoesqueleto.
  Future<void> sendCommand(String command);

  /// Cierra la conexión, si procede.
  Future<void> disconnect();
}
