import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/injection.dart' as di;
import 'package:spoonacular/presentation/bloc/recipe/random_recipe_dessert_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/random_recipe_vegetarian_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/recipe_detail_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/search_recipe_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/similar_recipe_bloc.dart';
import 'package:spoonacular/presentation/pages/recipe/home_recipe_page.dart';
import 'package:spoonacular/presentation/pages/recipe/random_recipe_dessert_page.dart';
import 'package:spoonacular/presentation/pages/recipe/random_recipe_vegetarian_page.dart';
import 'package:spoonacular/presentation/pages/recipe/recipe_detail_page.dart';
import 'package:spoonacular/presentation/pages/recipe/search_recipe_page.dart';
import 'package:spoonacular/utils/utils.dart';

import 'styles/text_styles.dart';

void main() {
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<RandomRecipeVegetarianBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<RandomRecipeDessertBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<RecipeDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchRecipeBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SimilarRecipeBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Spoonacular',
        theme: ThemeData(
          colorScheme: kColorScheme,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          textTheme: kTextTheme,
        ),
        home: const HomeRecipePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          final args = settings.arguments;

          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                builder: (_) => const HomeRecipePage(),
              );
            case RandomRecipeVegetarianPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const RandomRecipeVegetarianPage(),
              );
            case RandomRecipeDessertPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const RandomRecipeDessertPage(),
              );
            case RecipeDetailPage.routeName:
              return MaterialPageRoute(
                builder: (_) => RecipeDetailPage(id: args as int),
                settings: settings,
              );
            case SearchRecipePage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const SearchRecipePage());
            default:
          }
          return null;
        },
      ),
    );
  }
}
