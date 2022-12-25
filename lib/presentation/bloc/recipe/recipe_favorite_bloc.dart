import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/domain/entities/recipe/recipe_detail.dart';
import 'package:spoonacular/domain/usecases/recipe/get_favorite_recipe.dart';
import 'package:spoonacular/domain/usecases/recipe/get_favorite_recipe_status.dart';

import '../../../domain/entities/recipe/recipe.dart';
import '../../../domain/usecases/recipe/remove_favorite_recipe.dart';
import '../../../domain/usecases/recipe/save_favorite_recipe.dart';

part 'recipe_favorite_event.dart';
part 'recipe_favorite_state.dart';

class RecipeFavoriteBloc
    extends Bloc<RecipeFavoriteEvent, RecipeFavoriteState> {
  final GetFavoriteRecipe _getFavoriteRecipe;
  final GetFavoriteRecipeStatus _getFavoriteRecipeStatus;
  final SaveFavoriteRecipe _saveFavoriteRecipe;
  final RemoveFavoriteRecipe _removeFavoriteRecipe;

  RecipeFavoriteBloc(
    this._getFavoriteRecipe,
    this._getFavoriteRecipeStatus,
    this._saveFavoriteRecipe,
    this._removeFavoriteRecipe,
  ) : super(RecipeFavoriteEmpty()) {
    on<RecipeFavoriteRequested>(
      (event, emit) async {
        emit(RecipeFavoriteLoading());
        final result = await _getFavoriteRecipe.execute();

        result.fold(
          (failure) => emit(RecipeFavoriteError(failure.message)),
          (data) => emit(RecipeFavoriteHasData(data)),
        );
      },
    );
    on<RecipeFavoriteStatus>(
      (event, emit) async {
        final id = event.id;
        final result = await _getFavoriteRecipeStatus.execute(id);
        emit(RecipeFavoriteAdded(result));
      },
    );
    on<RecipeFavoriteAdd>(
      (event, emit) async {
        final recipe = event.recipeDetail;
        final result = await _saveFavoriteRecipe.execute(recipe);
        result.fold(
          (failure) => emit(RecipeFavoriteError(failure.message)),
          (data) => emit(RecipeFavoriteMessage(data)),
        );
      },
    );
    on<RecipeFavoriteRemove>(
      (event, emit) async {
        final recipe = event.recipeDetail;
        final result = await _removeFavoriteRecipe.execute(recipe);
        result.fold(
          (failure) => emit(RecipeFavoriteError(failure.message)),
          (data) => emit(RecipeFavoriteMessage(data)),
        );
      },
    );
  }
}
