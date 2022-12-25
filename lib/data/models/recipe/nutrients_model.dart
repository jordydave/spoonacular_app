import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/nutrients.dart';

class NutrientsModel extends Equatable {
  final String? name;
  final double? amount;
  final String? unit;
  final double? percentOfDailyNeeds;

  const NutrientsModel({
    required this.name,
    required this.amount,
    required this.unit,
    required this.percentOfDailyNeeds,
  });

  factory NutrientsModel.fromJson(Map<String, dynamic> json) {
    return NutrientsModel(
      name: json['name'],
      amount: json['amount'],
      unit: json['unit'],
      percentOfDailyNeeds: json['percentOfDailyNeeds'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
        'unit': unit,
        'percentOfDailyNeeds': percentOfDailyNeeds,
      };

  Nutrients toEntity() {
    return Nutrients(
      name: name,
      amount: amount,
      unit: unit,
      percentOfDailyNeeds: percentOfDailyNeeds,
    );
  }

  @override
  List<Object?> get props => [
        name,
        amount,
        unit,
        percentOfDailyNeeds,
      ];
}
