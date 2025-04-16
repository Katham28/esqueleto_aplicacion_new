import 'package:flutter/material.dart';
import 'rutinas.dart';
import 'comandos_voz.dart';
import 'inicioPage.dart';
class rutinasavanzadas extends StatefulWidget {
  final String? commandToExecute;

  const rutinasavanzadas({Key? key, this.commandToExecute}) : super(key: key);

  @override
  State<rutinasavanzadas> createState() => _rutinasavanzadasState();
}

class _rutinasavanzadasState extends State<rutinasavanzadas> {
  final List<String> rutinas = [
    '1 ',
    '2',
    '3',
    '4',
  ];

  
  @override
  void initState() {
    super.initState();
    _ejecutarSiVienePorComando();
  }
  final List<String> commaA = [
    'uno',
    'dos',
    'tres',
    'cuatro',
  ];

  void _ejecutarSiVienePorComando() {
    if (widget.commandToExecute != null) {
      final comando = widget.commandToExecute!.toLowerCase();
      for (int i = 0; i < rutinas.length; i++) {
        if (comando.contains(commaA[i].toLowerCase())) {
          Future.delayed(Duration(milliseconds: 300), () {
            Rutinas.ejecutarRutinaAvanzada(context, i);
          });
          break;
        }
      }
    }
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
        mainAxisAlignment: MainAxisAlignment.center,
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
                        child: Image.asset('assets/rut_reha_avanzada.png', height: 40, width: 40),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(rutinas[index], style: TextStyle(fontSize: 18)),
                      ),
                      ElevatedButton(
                        onPressed: () => { 
                          Rutinas.ejecutarRutinaAvanzada(context, index),
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('🦾 Ejecutando: ${rutinas[index]}')),
                          ),
                          
                          
                          },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF003566),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Iniciar', style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                );
              },
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