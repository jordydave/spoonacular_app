part of 'random_recipe_dessert_bloc.dart';

abstract class RandomRecipeDessertState extends Equatable {
  const RandomRecipeDessertState();

  @override
  List<Object> get props => [];
}

class RandomRecipeDessertEmpty extends RandomRecipeDessertState {}

class RandomRecipeDessertLoading extends RandomRecipeDessertState {}

class RandomRecipeDessertHasData extends RandomRecipeDessertState {
  final List<Recipe> recipes;

  const RandomRecipeDessertHasData(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RandomRecipeDessertError extends RandomRecipeDessertState {
  final String message;

  const RandomRecipeDessertError(this.message);

  @override
  List<Object> get props => [message];
}
