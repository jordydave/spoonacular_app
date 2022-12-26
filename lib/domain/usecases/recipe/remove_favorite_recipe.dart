import 'package:dartz/dartz.dart';
import 'package:spoonacular/domain/entities/recipe/recipe_detail.dart';
import 'package:spoonacular/utils/failure.dart';

import '../../repositories/recipe/recipe_repository.dart';

class RemoveFavoriteRecipe {
  final RecipeRepository _recipeRepository;

  RemoveFavoriteRecipe(this._recipeRepository);

  Future<Either<Failure, String>> execute(RecipeDetail recipe) {
    return _recipeRepository.removeRecipe(recipe);
  }
}
