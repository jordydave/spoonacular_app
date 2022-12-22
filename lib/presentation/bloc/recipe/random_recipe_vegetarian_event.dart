part of 'random_recipe_vegetarian_bloc.dart';

abstract class RandomRecipeVegetarianEvent extends Equatable {
  const RandomRecipeVegetarianEvent();

  @override
  List<Object> get props => [];
}

class RandomRecipeVegetarianRequested extends RandomRecipeVegetarianEvent {
  final int? number;

  const RandomRecipeVegetarianRequested({this.number});

  @override
  List<Object> get props => [number ?? 10];
}
