import '../../repositories/recipe/recipe_repository.dart';

class GetFavoriteRecipeStatus {
  final RecipeRepository _recipeRepository;

  GetFavoriteRecipeStatus(this._recipeRepository);

  Future<bool> execute(int id) async {
    return await _recipeRepository.isAddedToFavorite(id);
  }
}
