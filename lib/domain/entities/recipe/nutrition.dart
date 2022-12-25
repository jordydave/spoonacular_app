import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/caloric_breakdown.dart';
import 'package:spoonacular/domain/entities/recipe/flavonoids.dart';
import 'package:spoonacular/domain/entities/recipe/nutrients.dart';
import 'package:spoonacular/domain/entities/recipe/properties.dart';
import 'package:spoonacular/domain/entities/recipe/weight_per_serving.dart';

import 'ingredients.dart';

class Nutrition extends Equatable {
  final List<Nutrients>? nutrients;
  final List<Properties>? properties;
  final List<Flavonoids>? flavonoids;
  final List<Ingredients>? ingredients;
  final CaloricBreakdown? caloricBreakdown;
  final WeightPerServing? weightPerServing;

  const Nutrition({
    required this.nutrients,
    required this.properties,
    required this.flavonoids,
    required this.ingredients,
    required this.caloricBreakdown,
    required this.weightPerServing,
  });

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
