import 'package:flutter/material.dart';

class GuiaDeComandos extends StatelessWidget {
  const GuiaDeComandos({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> comandos = [
      'asistente, conectar',
      'asistente, desconectar',
      'asistente, marcha',
      'asistente, piernas',
      'asistente, equilibrio',
      'asistente, avanzada',
      'asistente, ejercicio avanzado 1',
      'asistente, ejercicio avanzado 2',
      'asistente, ejercicio avanzado 3',
      'asistente, ejercicio avanzado 4',
      'asistente, volver',
      'gracias asistente / terminar',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Guía de Comandos de Voz'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: comandos.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.record_voice_over),
            title: Text(comandos[index]),
          );
        },
      ),
    );
  }
}