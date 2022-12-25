part of 'search_recipe_bloc.dart';

abstract class SearchRecipeState extends Equatable {
  const SearchRecipeState();

  @override
  List<Object> get props => [];
}

class SearchRecipeEmpty extends SearchRecipeState {}

class SearchRecipeLoading extends SearchRecipeState {}

class SearchRecipeHasData extends SearchRecipeState {
  final List<Recipe> recipes;

  const SearchRecipeHasData(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class SearchRecipeError extends SearchRecipeState {
  final String message;

  const SearchRecipeError(this.message);

  @override
  List<Object> get props => [message];
}
