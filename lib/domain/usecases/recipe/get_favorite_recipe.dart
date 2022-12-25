import 'package:dartz/dartz.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';
import 'package:spoonacular/utils/failure.dart';

import '../../repositories/recipe/recipe_repository.dart';

class GetFavoriteRecipe {
  final RecipeRepository _recipeRepository;

  GetFavoriteRecipe(this._recipeRepository);

  Future<Either<Failure, List<Recipe>>> execute() async {
    return await _recipeRepository.getFavoriteRecipe();
  }
}
