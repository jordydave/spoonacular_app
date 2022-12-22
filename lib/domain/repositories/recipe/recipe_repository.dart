import 'package:dartz/dartz.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';

import '../../../utils/failure.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> getRandomRecipes();
}
