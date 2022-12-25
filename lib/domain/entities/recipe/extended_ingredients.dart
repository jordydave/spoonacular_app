import 'package:equatable/equatable.dart';

class ExtendedIngredients extends Equatable {
  final int? id;
  final String? aisle;
  final String? image;
  final String? consistency;
  final String? name;
  final String? nameClean;
  final String? original;
  final String? originalName;
  final double? amount;
  final String? unit;
  final List<dynamic>? meta;

  const ExtendedIngredients({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.meta,
  });

  factory ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredients(
      id: json['id'],
      aisle: json['aisle'],
      image: json['image'],
      consistency: json['consistency'],
      name: json['name'],
      nameClean: json['nameClean'],
      original: json['original'],
      originalName: json['originalName'],
      amount: json['amount'],
      unit: json['unit'],
      meta: json['meta'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        aisle,
        image,
        consistency,
        name,
        nameClean,
        original,
        originalName,
        amount,
        unit,
        meta,
      ];
}
