part of 'random_recipe_bloc.dart';

abstract class RandomRecipeState extends Equatable {
  const RandomRecipeState();

  @override
  List<Object> get props => [];
}

class RandomRecipeEmpty extends RandomRecipeState {}

class RandomRecipeLoading extends RandomRecipeState {}

class RandomRecipeHasData extends RandomRecipeState {
  final List<Recipe> recipes;

  const RandomRecipeHasData(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RandomRecipeError extends RandomRecipeState {
  final String message;

  const RandomRecipeError(this.message);

  @override
  List<Object> get props => [message];
}
