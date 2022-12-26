import 'package:dartz/dartz.dart';
import 'package:spoonacular/domain/entities/recipe/recipe_detail.dart';

import '../../../utils/failure.dart';
import '../../repositories/recipe/recipe_repository.dart';

class SaveFavoriteRecipe {
  final RecipeRepository _repository;

  SaveFavoriteRecipe(this._repository);

  Future<Either<Failure, String>> execute(RecipeDetail recipe) {
    return _repository.saveRecipe(recipe);
  }
}
