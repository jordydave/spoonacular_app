import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/domain/usecases/recipe/get_random_dessert_recipe.dart';

import '../../../domain/entities/recipe/recipe.dart';

part 'random_recipe_dessert_event.dart';
part 'random_recipe_dessert_state.dart';

class RandomRecipeDessertBloc
    extends Bloc<RandomRecipeDessertEvent, RandomRecipeDessertState> {
  final GetRandomDessertRecipe _getRandomDessertRecipe;

  RandomRecipeDessertBloc(this._getRandomDessertRecipe)
      : super(RandomRecipeDessertEmpty()) {
    on<RandomRecipeDessertRequested>(
      (event, emit) async {
        emit(RandomRecipeDessertLoading());
        final result = await _getRandomDessertRecipe.execute();
        result.fold(
          (failure) => emit(RandomRecipeDessertError(failure.message)),
          (data) => emit(RandomRecipeDessertHasData(data)),
        );
      },
    );
  }
}
