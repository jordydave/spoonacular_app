import 'package:equatable/equatable.dart';
import 'package:spoonacular/data/models/recipe/recipe_model.dart';

class RecipeResponse extends Equatable {
  final List<RecipeModel> recipeList;

  const RecipeResponse({required this.recipeList});

  factory RecipeResponse.fromJson(Map<String, dynamic> json) => RecipeResponse(
        recipeList: List<RecipeModel>.from(
          (json["recipes"] as List).map(
            (x) => RecipeModel.fromJson(x),
          ),
        ),
      );

  @override
  List<Object?> get props => [recipeList];
}
