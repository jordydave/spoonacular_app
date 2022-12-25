import 'package:equatable/equatable.dart';
import 'package:spoonacular/data/models/recipe/caloric_breakdown_model.dart';
import 'package:spoonacular/data/models/recipe/flavonoids_model.dart';
import 'package:spoonacular/data/models/recipe/ingredients_model.dart';
import 'package:spoonacular/data/models/recipe/nutrients_model.dart';
import 'package:spoonacular/data/models/recipe/properties_model.dart';
import 'package:spoonacular/data/models/recipe/weight_per_serving_model.dart';
import 'package:spoonacular/domain/entities/recipe/nutrition.dart';

class NutritionModel extends Equatable {
  final List<NutrientsModel>? nutrients;
  final List<PropertiesModel>? properties;
  final List<FlavonoidsModel>? flavonoids;
  final List<IngredientsModel>? ingredients;
  final CaloricBreakDownModel? caloricBreakdown;
  final WeightPerServingModel? weightPerServing;

  const NutritionModel({
    required this.nutrients,
    required this.properties,
    required this.flavonoids,
    required this.ingredients,
    required this.caloricBreakdown,
    required this.weightPerServing,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    return NutritionModel(
      nutrients: json['nutrients'] != null
          ? (json['nutrients'] as List)
              .map((e) => NutrientsModel.fromJson(e))
              .toList()
          : null,
      properties: json['properties'] != null
          ? (json['properties'] as List)
              .map((e) => PropertiesModel.fromJson(e))
              .toList()
          : null,
      flavonoids: json['flavonoids'] != null
          ? (json['flavonoids'] as List)
              .map((e) => FlavonoidsModel.fromJson(e))
              .toList()
          : null,
      ingredients: json['ingredients'] != null
          ? (json['ingredients'] as List)
              .map((e) => IngredientsModel.fromJson(e))
              .toList()
          : null,
      caloricBreakdown: json['caloricBreakdown'] != null
          ? CaloricBreakDownModel.fromJson(json['caloricBreakdown'])
          : null,
      weightPerServing: json['weightPerServing'] != null
          ? WeightPerServingModel.fromJson(json['weightPerServing'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nutrients': nutrients?.map((e) => e.toJson()).toList(),
      'properties': properties?.map((e) => e.toJson()).toList(),
      'flavonoids': flavonoids?.map((e) => e.toJson()).toList(),
      'ingredients': ingredients?.map((e) => e.toJson()).toList(),
      'caloricBreakdown': caloricBreakdown?.toJson(),
      'weightPerServing': weightPerServing?.toJson(),
    };
  }

  Nutrition toEntity() {
    return Nutrition(
      nutrients: nutrients?.map((e) => e.toEntity()).toList(),
      properties: properties?.map((e) => e.toEntity()).toList(),
      flavonoids: flavonoids?.map((e) => e.toEntity()).toList(),
      ingredients: ingredients?.map((e) => e.toEntity()).toList(),
      caloricBreakdown: caloricBreakdown?.toEntity(),
      weightPerServing: weightPerServing?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        nutrients,
        properties,
        flavonoids,
        ingredients,
        caloricBreakdown,
        weightPerServing,
      ];
}
