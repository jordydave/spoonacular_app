import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/random_recipe_bloc.dart';

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
      context.read<RandomRecipeBloc>().add((const RandomRecipeRequested()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Recipe'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<RandomRecipeBloc, RandomRecipeState>(
              builder: (context, state) {
                if (state is RandomRecipeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is RandomRecipeHasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.recipes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          state.recipes[index].title ?? 'No Title',
                        ),
                      );
                    },
                  );
                } else if (state is RandomRecipeError) {
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
    );
  }
}
