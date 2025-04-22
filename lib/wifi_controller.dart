import 'package:http/http.dart' as http;

//Conéctate a la red ExoesqueletoESP.
//Contraseña: 12345678.

//Verifica que puedes abrir http://192.168.4.1/marcha desde el navegador.
//Si ves "Marcha OK", está funcionando.

class WifiController {
  static const String baseUrl = 'http://192.168.4.1'; // IP del ESP32

  static Future<void> enviarComando(String comando) async {
    final url = Uri.parse('$baseUrl/$comando');
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        print('✅ Comando "$comando" enviado al ESP32.');
      } else {
        print('❌ Error del servidor ESP32: ${res.statusCode}');
      }
    } catch (e) {
      print('⚠️ Error de conexión: $e');
    }
  }
}
