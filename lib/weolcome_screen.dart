import 'package:flutter/material.dart';
import 'package:recekos/ingredintes_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12, // Establece el color de fondo
      appBar: AppBar(
        title: Text(
            'App de Recetas'), // Establece el título de la barra de navegación
        backgroundColor: Colors
            .grey, // Establece el color de fondo de la barra de navegación
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWelcomeText(
              context), // Llama a un método para construir el texto de bienvenida
          SizedBox(height: 32), // Agrega un espacio vertical
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      IngredientesScreen(), // Navega a la pantalla de ingredientes al presionar el botón "Empezar"
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey, // Establece el color de fondo del botón
            ),
            child: Text('Empezar'), // Texto del botón "Empezar"
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Column(
      children: [
        Text(
          '¡Bienvenido a la App de Recetas!', // Título de bienvenida
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Establece el color del texto
          ),
        ),
        SizedBox(height: 16), // Agrega un espacio vertical
        Text(
          'Explora deliciosas recetas y crea platos increíbles.', // Descripción
          style: TextStyle(
            fontSize: 16,
            color: Colors.white, // Establece el color del texto
          ),
          textAlign: TextAlign.center, // Alinea el texto al centro
        ),
      ],
    );
  }
}
