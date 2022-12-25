part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();

  @override
  List<Object> get props => [];
}

class RecipeDetailRequested extends RecipeDetailEvent {
  final int id;

  const RecipeDetailRequested(this.id);

  @override
  List<Object> get props => [id];
}
