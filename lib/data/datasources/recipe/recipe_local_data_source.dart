import 'package:spoonacular/data/datasources/db/database_helper.dart';
import 'package:spoonacular/data/models/recipe/recipe_table.dart';
import 'package:spoonacular/utils/exception.dart';

abstract class RecipeLocalDataSource {
  Future<String> insertRecipe(RecipeTable recipeDetail);
  Future<String> removeRecipe(RecipeTable recipeDetail);
  Future<RecipeTable?> getRecipeById(int id);
  Future<List<RecipeTable>> getFavoriteRecipe();
  Future<void> cacheRandomRecipeVegetarian(List<RecipeTable> recipes);
  Future<List<RecipeTable>> getCachedRandomRecipeVegetarian();
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final DatabaseHelper databaseHelper;

  RecipeLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertRecipe(RecipeTable recipe) async {
    try {
      await databaseHelper.insertFavorite(recipe);
      return 'Added to Favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeRecipe(RecipeTable recipe) async {
    try {
      await databaseHelper.removeFavorite(recipe);
      return 'Removed from Favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<RecipeTable?> getRecipeById(int id) async {
    final result = await databaseHelper.getRecipeById(id);
    if (result != null) {
      return RecipeTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<RecipeTable>> getFavoriteRecipe() async {
    final result = await databaseHelper.getFavoriteRecipes();
    return result.map((e) => RecipeTable.fromMap(e)).toList();
  }

  @override
  Future<void> cacheRandomRecipeVegetarian(List<RecipeTable> recipes) async {
    await databaseHelper.clearCache('vegetarian');
    await databaseHelper.insertCacheRecipe(recipes, 'vegetarian');
  }

  @override
  Future<List<RecipeTable>> getCachedRandomRecipeVegetarian() async {
    final result = await databaseHelper.getCacheRecipes('vegetarian');
    if (result.isNotEmpty) {
      return result.map((e) => RecipeTable.fromMap(e)).toList();
    } else {
      throw CacheException('No Cached Data');
    }
  }
}
