import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/weight_per_serving.dart';

class WeightPerServingModel extends Equatable {
  final int? amount;
  final String? unit;

  const WeightPerServingModel({
    required this.amount,
    required this.unit,
  });

  factory WeightPerServingModel.fromJson(Map<String, dynamic> json) {
    return WeightPerServingModel(
      amount: json['amount'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'unit': unit,
      };

  WeightPerServing toEntity() {
    return WeightPerServing(
      amount: amount,
      unit: unit,
    );
  }

  @override
  List<Object?> get props => [
        amount,
        unit,
      ];
}
