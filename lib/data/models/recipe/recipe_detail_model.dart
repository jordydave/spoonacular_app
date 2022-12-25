import 'package:equatable/equatable.dart';
import 'package:spoonacular/data/models/recipe/extended_ingredients_model.dart';
import 'package:spoonacular/data/models/recipe/nutrition_model.dart';
import 'package:spoonacular/domain/entities/recipe/recipe_detail.dart';

class RecipeDetailResponse extends Equatable {
  final int? id;
  final String? title;
  final String? image;
  final int? servings;
  final int? readyInMinutes;
  final String? license;
  final String? sourceUrl;
  final int? aggregateLikes;
  final int? healthScore;
  final double? pricePerServing;
  final String? summary;
  final String? instructions;
  final List<ExtendedIngredientsModel>? extendedIngredients;
  final NutritionModel? nutrition;
  final List<String>? cuisines;
  final List<String>? dishTypes;

  const RecipeDetailResponse({
    required this.id,
    required this.title,
    required this.image,
    required this.servings,
    required this.readyInMinutes,
    required this.license,
    required this.sourceUrl,
    required this.aggregateLikes,
    required this.healthScore,
    required this.pricePerServing,
    required this.summary,
    required this.instructions,
    required this.extendedIngredients,
    required this.nutrition,
    required this.cuisines,
    required this.dishTypes,
  });

  factory RecipeDetailResponse.fromJson(Map<String, dynamic> json) {
    return RecipeDetailResponse(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      servings: json['servings'],
      readyInMinutes: json['readyInMinutes'],
      license: json['license'],
      sourceUrl: json['sourceUrl'],
      aggregateLikes: json['aggregateLikes'],
      healthScore: json['healthScore'],
      pricePerServing: json['pricePerServing'],
      summary: json['summary'],
      instructions: json['instructions'],
      extendedIngredients: json['extendedIngredients'] != null
          ? (json['extendedIngredients'] as List)
              .map((e) => ExtendedIngredientsModel.fromJson(e))
              .toList()
          : null,
      nutrition: json['nutrition'] != null
          ? NutritionModel.fromJson(json['nutrition'])
          : null,
      cuisines: json['cuisines'] != null
          ? (json['cuisines'] as List).map((e) => e.toString()).toList()
          : null,
      dishTypes: json['dishTypes'] != null
          ? (json['dishTypes'] as List).map((e) => e.toString()).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'servings': servings,
        'readyInMinutes': readyInMinutes,
        'license': license,
        'sourceUrl': sourceUrl,
        'aggregateLikes': aggregateLikes,
        'healthScore': healthScore,
        'pricePerServing': pricePerServing,
        'summary': summary,
        'instructions': instructions,
        'extendedIngredients': extendedIngredients != null
            ? extendedIngredients!.map((e) => e.toJson()).toList()
            : null,
        'nutrition': nutrition != null ? nutrition!.toJson() : null,
        'cuisines': cuisines != null ? cuisines!.map((e) => e).toList() : null,
        'dishTypes':
            dishTypes != null ? dishTypes!.map((e) => e).toList() : null,
      };

  RecipeDetail toEntity() {
    return RecipeDetail(
      id: id,
      title: title,
      image: image,
      servings: servings,
      readyInMinutes: readyInMinutes,
      license: license,
      sourceUrl: sourceUrl,
      aggregateLikes: aggregateLikes,
      healthScore: healthScore,
      pricePerServing: pricePerServing,
      summary: summary,
      instructions: instructions,
      extendedIngredients: extendedIngredients != null
          ? extendedIngredients!.map((e) => e.toEntity()).toList()
          : null,
      nutrition: nutrition != null ? nutrition!.toEntity() : null,
      cuisines: cuisines != null ? cuisines!.map((e) => e).toList() : null,
      dishTypes: dishTypes != null ? dishTypes!.map((e) => e).toList() : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        servings,
        readyInMinutes,
        license,
        sourceUrl,
        aggregateLikes,
        healthScore,
        pricePerServing,
        summary,
        instructions,
        extendedIngredients,
        nutrition,
        cuisines,
        dishTypes,
      ];
}
