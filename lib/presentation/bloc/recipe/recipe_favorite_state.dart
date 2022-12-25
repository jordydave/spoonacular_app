part of 'recipe_favorite_bloc.dart';

abstract class RecipeFavoriteState extends Equatable {
  const RecipeFavoriteState();

  @override
  List<Object> get props => [];
}

class RecipeFavoriteEmpty extends RecipeFavoriteState {}

class RecipeFavoriteLoading extends RecipeFavoriteState {}

class RecipeFavoriteHasData extends RecipeFavoriteState {
  final List<Recipe> recipes;

  const RecipeFavoriteHasData(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RecipeFavoriteError extends RecipeFavoriteState {
  final String message;

  const RecipeFavoriteError(this.message);

  @override
  List<Object> get props => [message];
}

class RecipeFavoriteAdded extends RecipeFavoriteState {
  final bool isAdd;

  const RecipeFavoriteAdded(this.isAdd);

  @override
  List<Object> get props => [isAdd];
}

class RecipeFavoriteMessage extends RecipeFavoriteState {
  final String message;

  const RecipeFavoriteMessage(this.message);

  @override
  List<Object> get props => [message];
}
