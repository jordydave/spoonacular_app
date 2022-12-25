import 'package:dartz/dartz.dart';
import 'package:spoonacular/domain/repositories/recipe/recipe_repository.dart';

import '../../../utils/failure.dart';
import '../../entities/recipe/recipe.dart';

class GetSimilarRecipe {
  final RecipeRepository repository;
  GetSimilarRecipe(this.repository);

  Future<Either<Failure, List<Recipe>>> execute(int id) {
    return repository.getSimilarRecipe(id);
  }
}
