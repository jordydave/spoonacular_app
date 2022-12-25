import 'package:dartz/dartz.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';
import 'package:spoonacular/utils/failure.dart';

import '../../repositories/recipe/recipe_repository.dart';

class GetSearchRecipe {
  final RecipeRepository repository;

  GetSearchRecipe(this.repository);

  Future<Either<Failure, List<Recipe>>> execute(String query) {
    return repository.searchRecipe(query);
  }
}
