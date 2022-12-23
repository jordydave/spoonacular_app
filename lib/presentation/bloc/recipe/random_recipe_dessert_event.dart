part of 'random_recipe_dessert_bloc.dart';

abstract class RandomRecipeDessertEvent extends Equatable {
  const RandomRecipeDessertEvent();

  @override
  List<Object> get props => [];
}

class RandomRecipeDessertRequested extends RandomRecipeDessertEvent {
  final int? number;

  const RandomRecipeDessertRequested({this.number});

  @override
  List<Object> get props => [number ?? 10];
}
