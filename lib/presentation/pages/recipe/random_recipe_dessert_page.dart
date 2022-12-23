import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/presentation/widgets/recipe/recipe_card_list_widget.dart';

import '../../bloc/recipe/random_recipe_dessert_bloc.dart';

class RandomRecipeDessertPage extends StatefulWidget {
  static const routeName = '/recipe-dessert';

  const RandomRecipeDessertPage({Key? key}) : super(key: key);

  @override
  RandomRecipeDessertPageState createState() => RandomRecipeDessertPageState();
}

class RandomRecipeDessertPageState extends State<RandomRecipeDessertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Recipe Dessert'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<RandomRecipeDessertBloc, RandomRecipeDessertState>(
          builder: (context, state) {
            if (state is RandomRecipeDessertLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RandomRecipeDessertHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final recipe = state.recipes[index];
                  return RecipeCardListWidget(recipe);
                },
                itemCount: state.recipes.length,
              );
            } else if (state is RandomRecipeDessertError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
