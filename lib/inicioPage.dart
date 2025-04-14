import 'package:flutter/material.dart';
import 'rutinasPage.dart';
//import 'comandos_voz.dart';
//import 'crear_cuentas.dart';

class inicioPage extends StatelessWidget {
  
  const inicioPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Control Exoesqueleto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
                             
                            SizedBox(height: 20), // espacio entre botones

                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => rutinasPage()),
                                );
                              },
                              child: Text('Conectar Exoesqueleto'),
                            ),

                            SizedBox(height: 20), // espacio entre botones

          ],
        ),
      ),
    );
  }
}