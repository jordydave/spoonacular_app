import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/presentation/widgets/recipe/recipe_card_list_widget.dart';

import '../../bloc/recipe/random_recipe_vegetarian_bloc.dart';

class RandomRecipeVegetarianPage extends StatefulWidget {
  static const routeName = '/recipe-vegetarian';

  const RandomRecipeVegetarianPage({Key? key}) : super(key: key);

  @override
  RandomRecipeVegetarianPageState createState() =>
      RandomRecipeVegetarianPageState();
}

class RandomRecipeVegetarianPageState
    extends State<RandomRecipeVegetarianPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Recipe Vegetarian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<RandomRecipeVegetarianBloc,
            RandomRecipeVegetarianState>(
          builder: (context, state) {
            if (state is RandomRecipeVegetarianLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RandomRecipeVegetarianHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final recipe = state.recipes[index];
                  return RecipeCardListWidget(recipe);
                },
                itemCount: state.recipes.length,
              );
            } else if (state is RandomRecipeVegetarianError) {
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
