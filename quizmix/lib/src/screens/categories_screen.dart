import 'package:flutter/material.dart';
import 'package:quizmix/src/screens/game_screen.dart';

class Category {
  final String name;
  final IconData icon;

  Category(this.name, this.icon);
}

class CategoryScreen extends StatelessWidget {
  final List<Category> categories = [
    Category("Historia", Icons.history_edu),
    Category("Paises", Icons.public),
    Category("Deportes", Icons.sports_soccer),
    Category("Literatura", Icons.menu_book),
    Category("Geografía", Icons.map),
    Category("Ciencia", Icons.science),
  ];

  CategoryScreen({super.key});

  // category: categoryName
  void _startGameWithCategory(BuildContext context, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(category: categoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background_2.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text("Categorias")),
        body: Column(
          children: [
            SizedBox(height: 15),
            Image.asset('assets/images/title_logo.png', width: 225),
            SizedBox(height: 15),
            Text(
              "Selecciona una Categoría",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Dos columnas
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () =>
                          _startGameWithCategory(context, category.name),
                      child: Card(
                        color: const Color.fromARGB(255, 84, 16, 209),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(category.icon, size: 55, color: Colors.white),
                            SizedBox(height: 12),
                            Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
