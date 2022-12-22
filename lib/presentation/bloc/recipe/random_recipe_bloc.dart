import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/domain/usecases/recipe/get_random_recipe.dart';

import '../../../domain/entities/recipe/recipe.dart';

part 'random_recipe_event.dart';
part 'random_recipe_state.dart';

class RandomRecipeBloc extends Bloc<RandomRecipeEvent, RandomRecipeState> {
  final GetRandomRecipe _getRandomRecipe;

  RandomRecipeBloc(this._getRandomRecipe) : super(RandomRecipeEmpty()) {
    on<RandomRecipeRequested>(
      (event, emit) async {
        emit(RandomRecipeLoading());
        final result = await _getRandomRecipe.execute();
        result.fold(
          (failure) => emit(RandomRecipeError(failure.message)),
          (data) => emit(RandomRecipeHasData(data)),
        );
      },
    );
  }
}
