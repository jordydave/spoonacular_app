import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/steps.dart';

// ignore: unused_import
import 'ingredients.dart';

class AnalyzedInstructions extends Equatable {
  final int? id;
  final String? name;
  final List<Steps>? steps;

  const AnalyzedInstructions({
    required this.id,
    required this.name,
    required this.steps,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        steps,
      ];
}