import 'package:flutter/material.dart';
import 'package:recekos/RecetasScreen.dart';
import 'package:http/http.dart' as http;

class IngredientesScreen extends StatefulWidget {
  @override
  _IngredientesScreenState createState() => _IngredientesScreenState();
}

class _IngredientesScreenState extends State<IngredientesScreen> {
  final primaryColor = Colors.black12;
  final secondaryColor = Colors.grey;
  TextEditingController ingredientsController = TextEditingController();
  List<String> selectedIngredients = [];

  @override
  void dispose() {
    ingredientsController.dispose();
    super.dispose();
  }

  void addIngredient() {
    final ingredient = ingredientsController.text;
    if (ingredient.isNotEmpty) {
      setState(() {
        selectedIngredients.add(ingredient);
        ingredientsController.clear();
      });
    }
  }

  void clearAllIngredients() {
    setState(() {
      selectedIngredients.clear();
    });
  }

  void verRecetas() {
    if (selectedIngredients.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecetasScreen(ingredients: selectedIngredients),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Seleccionar Ingredientes'),
        backgroundColor: secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildIngredientInput(context),
            _buildSelectedIngredients(context),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: verRecetas,
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text('Ver Recetas'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        height: 240,
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1454944338482-a69bb95894af?w=1280&h=720',
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: AlignmentDirectional(-1.00, 1.00),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?w=512&h=512',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          _buildTextInputField(context, 'Ingrese un ingrediente',
              controller: ingredientsController),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: addIngredient,
            style: ElevatedButton.styleFrom(
              primary: secondaryColor,
            ),
            child: Text('Agregar Ingrediente'),
          ),
          SizedBox(height: 16),
          if (selectedIngredients.isNotEmpty)
            ElevatedButton(
              onPressed: clearAllIngredients,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('Borrar Todos'),
            ),
        ],
      ),
    );
  }

  Widget _buildTextInputField(BuildContext context, String hintText,
      {required TextEditingController controller}) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedIngredients(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredientes Seleccionados',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: selectedIngredients.asMap().entries.map((entry) {
              final index = entry.key;
              final ingredient = entry.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ingredient,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () =>
                        clearAllIngredients(), // Cambiado para borrar todos
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
