part of 'random_recipe_vegetarian_bloc.dart';

abstract class RandomRecipeVegetarianState extends Equatable {
  const RandomRecipeVegetarianState();

  @override
  List<Object> get props => [];
}

class RandomRecipeVegetarianEmpty extends RandomRecipeVegetarianState {}

class RandomRecipeVegetarianLoading extends RandomRecipeVegetarianState {}

class RandomRecipeVegetarianHasData extends RandomRecipeVegetarianState {
  final List<Recipe> recipes;

  const RandomRecipeVegetarianHasData(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RandomRecipeVegetarianError extends RandomRecipeVegetarianState {
  final String message;

  const RandomRecipeVegetarianError(this.message);

  @override
  List<Object> get props => [message];
}
