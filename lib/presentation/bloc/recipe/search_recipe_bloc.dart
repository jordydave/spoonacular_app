import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';
import 'package:spoonacular/domain/usecases/recipe/get_search_recipe.dart';

import '../../../domain/entities/recipe/recipe.dart';

part 'search_recipe_event.dart';
part 'search_recipe_state.dart';

class SearchRecipeBloc extends Bloc<SearchRecipeEvent, SearchRecipeState> {
  final GetSearchRecipe _getSearchRecipe;

  SearchRecipeBloc(this._getSearchRecipe) : super(SearchRecipeEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchRecipeLoading());
        final result = await _getSearchRecipe.execute(query);

        result.fold(
          (failure) => emit(SearchRecipeError(failure.message)),
          (recipes) => emit(SearchRecipeHasData(recipes)),
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
