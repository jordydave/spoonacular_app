part of 'similar_recipe_bloc.dart';

abstract class SimilarRecipeState extends Equatable {
  const SimilarRecipeState();

  @override
  List<Object> get props => [];
}

class SimilarRecipeEmpty extends SimilarRecipeState {}

class SimilarRecipeLoading extends SimilarRecipeState {}

class SimilarRecipeHasData extends SimilarRecipeState {
  final List<Recipe> recipes;

  const SimilarRecipeHasData(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class SimilarRecipeError extends SimilarRecipeState {
  final String message;

  const SimilarRecipeError(this.message);

  @override
  List<Object> get props => [message];
}
