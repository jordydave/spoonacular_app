import 'package:dartz/dartz.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';
import 'package:spoonacular/domain/entities/recipe/recipe_detail.dart';

import '../../../utils/failure.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> getRandomVegetarianRecipes();
  Future<Either<Failure, List<Recipe>>> getRandomDessertRecipes();
  Future<Either<Failure, RecipeDetail>> getRecipeDetail(int id);
  Future<Either<Failure, List<Recipe>>> searchRecipe(String query);
  Future<Either<Failure, List<Recipe>>> getSimilarRecipe(int id);
}
