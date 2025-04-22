// lib/rutinas.dart – versión corregida 
// Mantiene todas las rutinas y navegaciones en un único lugar.
// Asegúrate de ajustar las rutas de import si cambias el nombre del paquete.

import 'package:flutter/material.dart';
import 'rutinasPage.dart';
import 'rutinasavanzadasPage.dart';
import 'inicioPage.dart';

class Rutinas {
  /// Lista visible de rutinas principales (0‑3)
  static const List<String> rutinasDisponibles = [
    'Rutina de Marcha',
    'Rutina de Piernas',
    'Rutina de Equilibrio',
    'Rehabilitación Avanzada++',
  ];

  // ───────────────────────── Navegación ─────────────────────────

  /// Navega a la selección de rutinas normales.
  static void navegarConectar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const rutinasPage()),
    );
  }

  /// Navega a la lista de rutinas avanzadas.
  static void _navegarARutinaAvanzada(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RutinasAvanzadasPage()),
    );
  }

  /// Cierra cualquier conexión / vuelve a Inicio.

static void navegarDesconectar(BuildContext context) {
  Navigator.popUntil(context, ModalRoute.withName('/'));
  
 // Navigator.pushAndRemoveUntil(
  //  context,
  //  MaterialPageRoute(builder: (_) => const InicioPage()),
  //  (route) => false, // Elimina TODAS las rutas anteriores
  //);
}
  

  // ──────────────────────── Ejecución de rutinas ────────────────────────

  /// Ejecuta una rutina principal por índice.
  static void ejecutarRutina(BuildContext context, int index) {
    if (index < 0 || index >= rutinasDisponibles.length) return;

    switch (index) {
      case 0:
        _ejecutarMarcha(context);
        break;
      case 1:
        _ejecutarPiernas(context);
        break;
      case 2:
        _ejecutarEquilibrio(context);
        break;
      case 3:
      // La 4.ª opción es en realidad un sub‑menú de avanzadas
        _navegarARutinaAvanzada(context);
        break;
    }
  }

  /// Ejecuta una rutina avanzada (índices 0‑3 de la lista avanzada).
  static void ejecutarRutinaAvanzada(BuildContext context, int index) {
    if (index < 0 || index > 3) return;

    switch (index) {
      case 0:
        _ejecutarAvanzada1(context);
        break;
      case 1:
        _ejecutarAvanzada2(context);
        break;
      case 2:
        _ejecutarAvanzada3(context);
        break;
      case 3:
        _ejecutarAvanzada4(context);
        break;
    }
  }

  // ────────────────────────── Privados ──────────────────────────

  static void _showSnack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  // Rutinas principales
  static void _ejecutarMarcha(BuildContext context) {
    _showSnack(context, '🦾 Iniciando rutina de Marcha');
    // TODO: enviar comando real por WiFi/Bluetooth…
  }

  static void _ejecutarPiernas(BuildContext context) {
    _showSnack(context, '🦾 Iniciando rutina de Piernas');
  }

  static void _ejecutarEquilibrio(BuildContext context) {
    _showSnack(context, '🦾 Iniciando rutina de Equilibrio');
  }

  // Rutinas avanzadas
  static void _ejecutarAvanzada1(BuildContext context) {
    _showSnack(context, '🔥 Avanzada 1');
  }

  static void _ejecutarAvanzada2(BuildContext context) {
    _showSnack(context, '🔥 Avanzada 2');
  }

  static void _ejecutarAvanzada3(BuildContext context) {
    _showSnack(context, '🔥 Avanzada 3');
  }

  static void _ejecutarAvanzada4(BuildContext context) {
    _showSnack(context, '🔥 Avanzada 4');
  }
}