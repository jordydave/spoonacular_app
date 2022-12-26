import 'package:equatable/equatable.dart';
import 'package:spoonacular/data/models/recipe/ingredients_model.dart';
import 'package:spoonacular/domain/entities/recipe/steps.dart';

class StepsModel extends Equatable {
  final int? number;
  final String? step;
  final List<IngredientsModel>? ingredients;

  const StepsModel({
    required this.number,
    required this.step,
    required this.ingredients,
  });

  factory StepsModel.fromJson(Map<String, dynamic> json) {
    return StepsModel(
      number: json['number'],
      step: json['step'],
      ingredients: json['ingredients'] != null
          ? (json['ingredients'] as List)
              .map((e) => IngredientsModel.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'number': number,
        'step': step,
        'ingredients': ingredients?.map((e) => e.toJson()).toList(),
      };
  
  Steps toEntity() {
    return Steps(
      number: number,
      step: step,
      ingredients: ingredients?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        number,
        step,
        ingredients,
      ];
}