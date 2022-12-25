import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/properties.dart';

class PropertiesModel extends Equatable {
  final String? name;
  final double? amount;
  final String? unit;

  const PropertiesModel({
    required this.name,
    required this.amount,
    required this.unit,
  });

  factory PropertiesModel.fromJson(Map<String, dynamic> json) {
    return PropertiesModel(
      name: json['name'],
      amount: json['amount'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
        'unit': unit,
      };

  Properties toEntity() {
    return Properties(
      name: name,
      amount: amount,
      unit: unit,
    );
  }

  @override
  List<Object?> get props => [
        name,
        amount,
        unit,
      ];
}
