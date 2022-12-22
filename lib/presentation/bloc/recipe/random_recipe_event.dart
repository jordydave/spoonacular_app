part of 'random_recipe_bloc.dart';

abstract class RandomRecipeEvent extends Equatable {
  const RandomRecipeEvent();

  @override
  List<Object> get props => [];
}

class RandomRecipeRequested extends RandomRecipeEvent {
  final int? number;

  const RandomRecipeRequested({this.number});

  @override
  List<Object> get props => [number ?? 10];
}
