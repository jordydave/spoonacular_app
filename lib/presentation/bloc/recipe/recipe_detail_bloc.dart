import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/domain/usecases/recipe/get_recipe_detail.dart';

import '../../../domain/entities/recipe/recipe_detail.dart';

part 'recipe_detail_event.dart';
part 'recipe_detail_state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeDetail _getRecipeDetail;

  RecipeDetailBloc(this._getRecipeDetail) : super(RecipeDetailEmpty()) {
    on<RecipeDetailRequested>((event, emit) async {
      final id = event.id;

      emit(RecipeDetailLoading());
      final result = await _getRecipeDetail.execute(id);
      result.fold(
        (failure) => emit(RecipeDetailError(message: failure.message)),
        (data) => emit(RecipeDetailHasData(recipeDetail: data)),
      );
    });
  }
}
