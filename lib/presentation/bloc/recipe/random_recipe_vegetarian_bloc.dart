import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/domain/usecases/recipe/get_random_vegetarian_recipe.dart';

import '../../../domain/entities/recipe/recipe.dart';

part 'random_recipe_vegetarian_event.dart';
part 'random_recipe_vegetarian_state.dart';

class RandomRecipeVegetarianBloc
    extends Bloc<RandomRecipeVegetarianEvent, RandomRecipeVegetarianState> {
  final GetRandomVegetarianRecipe _getRandomVegetarianRecipe;

  RandomRecipeVegetarianBloc(this._getRandomVegetarianRecipe)
      : super(RandomRecipeVegetarianEmpty()) {
    on<RandomRecipeVegetarianRequested>(
      (event, emit) async {
        emit(RandomRecipeVegetarianLoading());
        final result = await _getRandomVegetarianRecipe.execute();
        result.fold(
          (failure) => emit(RandomRecipeVegetarianError(failure.message)),
          (data) => emit(RandomRecipeVegetarianHasData(data)),
        );
      },
    );
  }
}
