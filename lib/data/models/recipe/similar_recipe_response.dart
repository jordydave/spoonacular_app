import 'package:equatable/equatable.dart';
import 'package:spoonacular/data/models/recipe/recipe_model.dart';

class SimilarRecipeResponse extends Equatable {
  final List<RecipeModel> recipeList;

  const SimilarRecipeResponse({required this.recipeList});

  factory SimilarRecipeResponse.fromJson(List<dynamic> json) =>
      SimilarRecipeResponse(
        recipeList: List<RecipeModel>.from(
          json.map(
            (x) => RecipeModel.fromJson(x),
          ),
        ),
      );

  @override
  List<Object?> get props => [recipeList];
}
