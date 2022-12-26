part of 'recipe_favorite_bloc.dart';

abstract class RecipeFavoriteEvent extends Equatable {
  const RecipeFavoriteEvent();

  @override
  List<Object> get props => [];
}

class RecipeFavoriteRequested extends RecipeFavoriteEvent {}

class RecipeFavoriteStatus extends RecipeFavoriteEvent {
  final int id;

  const RecipeFavoriteStatus(this.id);

  @override
  List<Object> get props => [id];
}

class RecipeFavoriteAdd extends RecipeFavoriteEvent {
  final RecipeDetail recipeDetail;

  const RecipeFavoriteAdd(this.recipeDetail);

  @override
  List<Object> get props => [recipeDetail];
}

class RecipeFavoriteRemove extends RecipeFavoriteEvent {
  final RecipeDetail recipeDetail;

  const RecipeFavoriteRemove(this.recipeDetail);

  @override
  List<Object> get props => [recipeDetail];
}
