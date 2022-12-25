import 'package:equatable/equatable.dart';
import 'package:spoonacular/data/models/recipe/recipe_model.dart';

class SearchRecipeResponse extends Equatable {
  final List<RecipeModel> recipeList;

  const SearchRecipeResponse({required this.recipeList});

  factory SearchRecipeResponse.fromJson(Map<String, dynamic> json) => SearchRecipeResponse(
        recipeList: List<RecipeModel>.from(
          (json["results"] as List).map(
            (x) => RecipeModel.fromJson(x),
          ),
        ),
      );

  @override
  List<Object?> get props => [recipeList];
}
