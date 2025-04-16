import 'package:esqueleto_aplicacion_new/RutinasPage.dart';
import 'package:esqueleto_aplicacion_new/inicioPage.dart';
import 'package:flutter/material.dart';
import 'rutinasavanzadasPage.dart';
class Rutinas {
  
  // Lista de rutinas disponibles
  static const List<String> rutinasDisponibles = [
    'Rutina de Marcha',
    'Rutina de Piernas',
    'Rutina de Equilibrio',
    'Rehabilitación Avanzada++',
  ];

  

  // Método estático para obtener los íconos de las rutinas
  static List<String> obtenerIconosRutinas() {
    return [
      'assets/rut_marcha.png',
      'assets/rut_piernas.png',
      'assets/rut_equilibrio.png',
      'assets/rut_reha_avanzada.png',
    ];
  }

  // Método estático para obtener los textos de los botones
  static List<String> obtenerTextosBotones() {
    return [
      'Iniciar',
      'Iniciar',
      'Iniciar',
      '+++',
    ];
  }

  // Método estático para ejecutar una rutina específica
  static void ejecutarRutina(BuildContext context, int index) {
    if (index < 0 || index >= rutinasDisponibles.length) return;

    //ScaffoldMessenger.of(context).showSnackBar(
    //  SnackBar(content: Text('🦾 Ejecutando: ${rutinasDisponibles[index]}')),
    //);

    // Lógica específica para cada rutina
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
        _navegarARutinaAvanzada(context);
        break;
      

    }
  }

  static void iniciar (){

  }

  static void ejecutarRutinaAvanzada (BuildContext context, int index) {
    if (index < 0 || index >= rutinasDisponibles.length) return;

    //ScaffoldMessenger.of(context).showSnackBar(
    //  SnackBar(content: Text('🦾 Ejecutando rutina avanzada: $index')),
    //);

    // Lógica específica para cada rutina
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


  // Métodos privados para cada rutina específica
  static void _ejecutarMarcha(BuildContext context) {
    // Implementación específica para rutina de marcha
  }

  static void _ejecutarPiernas(BuildContext context) {
    // Implementación específica para rutina de piernas
  }

  static void _ejecutarEquilibrio(BuildContext context) {
    // Implementación específica para rutina de equilibrio
  }


  static void _ejecutarAvanzada1(BuildContext context) {
    // Implementación específica para rutina de equilibrio


  }


  static void _ejecutarAvanzada2(BuildContext context) {
    // Implementación específica para rutina de equilibrio


  }

  
  static void _ejecutarAvanzada3(BuildContext context) {
    // Implementación específica para rutina de equilibrio


  }

  
  static void _ejecutarAvanzada4(BuildContext context) {
    // Implementación específica para rutina de equilibrio


  }
  static void _navegarARutinaAvanzada(BuildContext context) {
    // Navegación a la pantalla de rutinas avanzadas
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => rutinasavanzadas(),
      ),
    );
  }

   
  static void navegarDesconectar(BuildContext context) {
    // Navegación a la pantalla de rutinas avanzadas
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InicioPage(),
      ),
    );
  }


  static void navegarconectar(BuildContext context) {
    // Navegación a la pantalla de rutinas avanzadas
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => rutinasPage(),
      ),
    );
  }
}


  



