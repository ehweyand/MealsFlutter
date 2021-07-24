// vai gerenciar apenas as abas e carregar outras telas
import 'package:flutter/material.dart';
import './favorites_screen.dart';
import './categories_screen.dart';

/* Stateful pois nas abas inferiores, o flutter trabalha de uma forma que necessita do stateful*/
class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        // Para gerenciar qual tela vai mostrar
        // Mostra de acordo com a ordem das Tab widgets definidas acima
        body: TabBarView(
          children: [
            CategoriesScreen(),
            FavoritesScreen(),
          ],
        ),
      ),
    );
  }
}
/*
O conteúdo que carregamos em uma tab não deve trazer um widget de scaffold, pois já será
coordenado pela tabs_screen


*/
