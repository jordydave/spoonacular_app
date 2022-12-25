part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailState extends Equatable {
  const RecipeDetailState();

  @override
  List<Object> get props => [];
}

class RecipeDetailEmpty extends RecipeDetailState {}

class RecipeDetailLoading extends RecipeDetailState {}

class RecipeDetailHasData extends RecipeDetailState {
  final RecipeDetail recipeDetail;

  const RecipeDetailHasData({required this.recipeDetail});

  @override
  List<Object> get props => [recipeDetail];
}

class RecipeDetailError extends RecipeDetailState {
  final String message;

  const RecipeDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
