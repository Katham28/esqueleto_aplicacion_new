import 'package:flutter/material.dart';

class rutinasavanzadas extends StatefulWidget {
  final String? commandToExecute;

  const rutinasavanzadas({Key? key, this.commandToExecute}) : super(key: key);

  @override
  State<rutinasavanzadas> createState() => _rutinasavanzadasState();
}

class _rutinasavanzadasState extends State<rutinasavanzadas> {
  final List<String> rutinas = [
    'Ejercicio avanzado 1',
    'Ejercicio avanzado 2',
    'Ejercicio avanzado 3',
    'Ejercicio avanzado 4',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.commandToExecute != null) {
      int index = rutinas.indexOf(widget.commandToExecute!);
      if (index != -1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _ejecutarRutina(index);
        });
      }
    }
  }

  void _ejecutarRutina(int index) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ejecutando: ${rutinas[index]}')),
    );
    // Aquí podrías colocar lógica de control real si es necesario

    if (index==0){

    }else if (index==1){

    } else if (index==2){

    }else{

      
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
                        onPressed: () => _ejecutarRutina(index),
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