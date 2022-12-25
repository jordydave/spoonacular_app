import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/recipe_favorite_bloc.dart';
import 'package:spoonacular/presentation/widgets/recipe/recipe_card_list_widget.dart';

import '../../../utils/utils.dart';

class FavoriteRecipePage extends StatefulWidget {
  static const routeName = '/favorite-recipe';

  const FavoriteRecipePage({Key? key}) : super(key: key);

  @override
  FavoriteRecipePageState createState() => FavoriteRecipePageState();
}

class FavoriteRecipePageState extends State<FavoriteRecipePage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RecipeFavoriteBloc>().add(RecipeFavoriteRequested());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<RecipeFavoriteBloc>().add(RecipeFavoriteRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<RecipeFavoriteBloc, RecipeFavoriteState>(
          builder: (context, state) {
            if (state is RecipeFavoriteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RecipeFavoriteHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final recipe = state.recipes[index];
                  return RecipeCardListWidget(recipe);
                },
                itemCount: state.recipes.length,
              );
            } else if (state is RecipeFavoriteError) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
