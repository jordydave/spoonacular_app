import 'package:equatable/equatable.dart';
// ignore: unused_import
import 'package:spoonacular/data/models/recipe/ingredients_model.dart';
import 'package:spoonacular/data/models/recipe/steps_model.dart';
import 'package:spoonacular/domain/entities/recipe/analyzed_instructions.dart';

class AnalyzedInstructionsModel extends Equatable{
  final int? id;
  final String? name;
  final List<StepsModel>? steps;

  const AnalyzedInstructionsModel({
    required this.id,
    required this.name,
    required this.steps,
  });

  factory AnalyzedInstructionsModel.fromJson(Map<String, dynamic> json) {
    return AnalyzedInstructionsModel(
      id: json['id'],
      name: json['name'],
      steps: json['steps'] != null
          ? (json['steps'] as List)
              .map((e) => StepsModel.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'steps': steps?.map((e) => e.toJson()).toList(),
      };

  AnalyzedInstructions toEntity() {
    return AnalyzedInstructions(
      id: id,
      name: name,
      steps: steps?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        steps,
      ];
}