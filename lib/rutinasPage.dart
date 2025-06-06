import 'package:flutter/material.dart';
import 'rutinas.dart';
import 'rutinasavanzadasPage.dart';
import 'inicioPage.dart'; 
class rutinasPage extends StatefulWidget {
  final String? commandToExecute;

  const rutinasPage({super.key, this.commandToExecute});

  @override
  State<rutinasPage> createState() => _rutinasPageState();
}

class _rutinasPageState extends State<rutinasPage> {
  
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

  final List<String> ima = [
    'assets/rut_marcha.png',
    'assets/rut_piernas.png',
    'assets/rut_equilibrio.png',
    'assets/rut_reha_avanzada.png',
  ];

  final List<String> textos = [
    'Iniciar',
    'Iniciar',
    'Iniciar',
    '+++',
  ];

   


  @override
  void initState() {
    super.initState();
    _ejecutarSiVienePorComando();
  }

  void _ejecutarSiVienePorComando() {
    if (widget.commandToExecute != null) {
      final comando = widget.commandToExecute!.toLowerCase();
      for (int i = 0; i < rutinas.length; i++) {
        if (comando.contains(comma[i].toLowerCase())) {
          Future.delayed(Duration(milliseconds: 300), () {
            Rutinas.ejecutarRutina(context, i);
          });
          break;
        }
      }


          if (comando.contains("apagar") 
          //|| comando.contains("terminar") 
          ) {
          Future.delayed(Duration(milliseconds: 300), () {
            Rutinas.navegarDesconectar(context);
          });
          
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona Rutina'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: rutinas.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1B263B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF0D1B2A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(ima[index], height: 40, width: 40),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(rutinas[index], style: TextStyle(fontSize: 18)),
                      ),
                      ElevatedButton(
                        onPressed: () => Rutinas.ejecutarRutina(context, index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF003566),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(textos[index], style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Rutinas.navegarDesconectar(context);
            },
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