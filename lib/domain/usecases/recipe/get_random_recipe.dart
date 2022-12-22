import 'package:dartz/dartz.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';
import 'package:spoonacular/utils/failure.dart';

import '../../repositories/recipe/recipe_repository.dart';

class GetRandomRecipe {
  final RecipeRepository _repository;

  GetRandomRecipe(this._repository);

  Future<Either<Failure, List<Recipe>>> execute() async {
    return await _repository.getRandomRecipes();
  }
}
