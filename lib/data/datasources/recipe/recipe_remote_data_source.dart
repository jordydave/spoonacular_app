import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spoonacular/data/models/recipe/recipe_model.dart';
import 'package:spoonacular/data/models/recipe/recipe_response.dart';
import 'package:spoonacular/utils/constant.dart';

import '../../../utils/exception.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getRandomVegetarianRecipes();
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RecipeModel>> getRandomVegetarianRecipes() async {
    final response = await client.get(
      Uri.parse('$baseUrl/random?number=100&$apiKey&tags=vegetarian'),
    );
    if (response.statusCode == 200) {
      return RecipeResponse.fromJson(json.decode(response.body)).recipeList;
    } else {
      throw ServerException();
    }
  }
}
