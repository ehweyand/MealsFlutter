import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Filtros
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  // Controla os Meals
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    // Atualiza os filtros
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        // Lógica pra verificar os filtros
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false; //não quero incluir na busca
        }

        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false; //não quero incluir na busca
        }

        if (_filters['vegan'] && !meal.isVegan) {
          return false; //não quero incluir na busca
        }

        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false; //não quero incluir na busca
        }

        return true; // mantém a refeição na lista (do where)
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        //alterando a fonte padrão do texto no tema
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      //initialRoute: '/', //default é '/'
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        //passando parâmetros para a rota (o ponteiro para a função)
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      //se acessar uma rota não registrada em routes
      /*onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },*/
      //rotas desconhecidas, um fallback caso não encontrar uma rota por exemplo
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
