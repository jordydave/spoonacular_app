import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/domain/usecases/recipe/get_similar_recipe.dart';

import '../../../domain/entities/recipe/recipe.dart';

part 'similar_recipe_event.dart';
part 'similar_recipe_state.dart';

class SimilarRecipeBloc extends Bloc<SimilarRecipeEvent, SimilarRecipeState> {
  final GetSimilarRecipe _getSimilarRecipe;

  SimilarRecipeBloc(this._getSimilarRecipe) : super(SimilarRecipeEmpty()) {
    on<SimilarRecipeRequested>((event, emit) async {
      final id = event.id;

      emit(SimilarRecipeLoading());
      final result = await _getSimilarRecipe.execute(id);
      result.fold(
        (failure) => emit(SimilarRecipeError(failure.message)),
        (data) => emit(SimilarRecipeHasData(data)),
      );
    });
  }
}
