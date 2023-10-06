import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecetasScreen extends StatefulWidget {
  final List<String> ingredients;

  RecetasScreen({required this.ingredients});

  @override
  _RecetasScreenState createState() => _RecetasScreenState();
}

class _RecetasScreenState extends State<RecetasScreen> {
  List<dynamic> recipes = [];

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final String apiKey = 'fa75e200f2094c40aa8afdcb81171f26';
    final String baseUrl =
        'https://api.spoonacular.com/recipes/findByIngredients';

    final response = await http.get(
      Uri.parse(
          '$baseUrl?ingredients=${widget.ingredients.join(",")}&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      setState(() {
        recipes = jsonDecode(response.body);
      });
    } else {
      throw Exception('Fallo al cargar las recetas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas Disponibles'),
      ),
      body: recipes.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator(), // Muestra un indicador de carga mientras se obtienen las recetas.
            )
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ListTile(
                  leading: Image.network(recipe['image']),
                  title: Text(recipe['title']),
                  onTap: () {
                    // Cuando se toca una receta, navega a la pantalla de detalles de receta.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetallesRecetaScreen(recipe: recipe),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class DetallesRecetaScreen extends StatelessWidget {
  final dynamic recipe;

  DetallesRecetaScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    // Aquí puedes construir la pantalla de detalles de receta para mostrar información detallada de la receta.
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title']),
      ),
      body: Column(
        children: [
          Image.network(recipe['image']),
          Text(
              'Ingredientes: ${recipe['usedIngredients'].length} ingredientes utilizados'),
          Text(
              'Pasos de preparación: ${recipe['instructions'] ?? 'No disponibles'}'),
        ],
      ),
    );
  }
}
