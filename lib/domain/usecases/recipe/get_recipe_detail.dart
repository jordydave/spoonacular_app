import 'package:dartz/dartz.dart';
import 'package:spoonacular/domain/entities/recipe/recipe_detail.dart';
import 'package:spoonacular/domain/repositories/recipe/recipe_repository.dart';
import 'package:spoonacular/utils/failure.dart';

class GetRecipeDetail {
  final RecipeRepository repository;

  GetRecipeDetail(this.repository);

  Future<Either<Failure, RecipeDetail>> execute(int id) {
    return repository.getRecipeDetail(id);
  }
}
