import 'package:flutter/material.dart';
import 'package:recekos/weolcome_screen.dart'; // Importa el archivo de pantalla de bienvenida

void main() {
  runApp(MaterialApp(
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen(); // Muestra la pantalla de bienvenida al iniciar la aplicación
  }
}
