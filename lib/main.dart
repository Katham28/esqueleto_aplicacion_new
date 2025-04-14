import 'package:flutter/material.dart';
import 'inicioPage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exoesqueleto v. sin voz',
      home: InicioPage(),
       theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0D1B2A),
        primaryColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          titleLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      debugShowCheckedModeBanner: false,

    );
  }
}
