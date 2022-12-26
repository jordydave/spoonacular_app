import 'package:sqflite/sqflite.dart';

import '../../models/recipe/recipe_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblFavoriteRecipe = 'favoriteRecipe';
  static const String _tblCacheRecipe = 'cacheRecipe';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/spoonacular.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblFavoriteRecipe (
        id INTEGER PRIMARY KEY,
        title TEXT,
        image TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCacheRecipe (
        id INTEGER PRIMARY KEY,
        title TEXT,
        image TEXT,
        category TEXT
      );
    ''');
  }

  Future<void> insertCacheRecipe(
      List<RecipeTable> recipes, String category) async {
    final db = await database;
    db!.transaction(
      (txn) async {
        for (final recipe in recipes) {
          final recipeJson = recipe.toJson();
          recipeJson['category'] = category;
          txn.insert(_tblCacheRecipe, recipeJson);
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> getCacheRecipes(String category) async {
    final db = await database;
    final result = await db!.query(
      _tblCacheRecipe,
      where: 'category = ?',
      whereArgs: [category],
    );
    return result;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheRecipe,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertFavorite(RecipeTable recipe) async {
    final db = await database;
    final result = await db!.insert(_tblFavoriteRecipe, recipe.toJson());
    return result;
  }

  Future<int> removeFavorite(RecipeTable recipe) async {
    final db = await database;
    return await db!.delete(
      _tblFavoriteRecipe,
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<Map<String, dynamic>?> getRecipeById(int id) async {
    final db = await database;
    final result = await db!.query(
      _tblFavoriteRecipe,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getFavoriteRecipes() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblFavoriteRecipe);

    return results;
  }
}
