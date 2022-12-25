part of 'similar_recipe_bloc.dart';

abstract class SimilarRecipeEvent extends Equatable {
  const SimilarRecipeEvent();

  @override
  List<Object> get props => [];
}

class SimilarRecipeRequested extends SimilarRecipeEvent {
  final int id;

  const SimilarRecipeRequested(this.id);

  @override
  List<Object> get props => [id];
}
