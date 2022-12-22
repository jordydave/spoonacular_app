import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/injection.dart' as di;
import 'package:spoonacular/presentation/bloc/recipe/random_recipe_bloc.dart';
import 'package:spoonacular/presentation/pages/recipe/home_recipe_page.dart';
import 'package:spoonacular/styles/colors.dart';
import 'package:spoonacular/styles/text_styles.dart';
import 'package:spoonacular/utils/utils.dart';

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
          create: (context) => di.locator<RandomRecipeBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Spoonacular',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeRecipePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          // final args = settings.arguments;

          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                builder: (_) => const HomeRecipePage(),
              );

            default:
          }
          return null;
        },
      ),
    );
  }
}
