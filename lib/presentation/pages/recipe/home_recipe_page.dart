import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/random_recipe_vegetarian_bloc.dart';
import 'package:spoonacular/styles/text_styles.dart';

import '../../widgets/recipe/home_recipe_widget.dart';

class HomeRecipePage extends StatefulWidget {
  const HomeRecipePage({super.key});

  @override
  State<HomeRecipePage> createState() => _HomeRecipePageState();
}

class _HomeRecipePageState extends State<HomeRecipePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<RandomRecipeVegetarianBloc>()
          .add((const RandomRecipeVegetarianRequested()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Recipe'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vegetarian Recipe',
                style: kHeading5,
              ),
              BlocBuilder<RandomRecipeVegetarianBloc,
                  RandomRecipeVegetarianState>(
                builder: (context, state) {
                  if (state is RandomRecipeVegetarianLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is RandomRecipeVegetarianHasData) {
                    return HomeRecipeWidget(
                      recipes: state.recipes,
                    );
                  } else if (state is RandomRecipeVegetarianError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
