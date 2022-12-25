import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/caloric_breakdown.dart';

class CaloricBreakDownModel extends Equatable {
  final double? percentProtein;
  final double? percentFat;
  final double? percentCarbs;

  const CaloricBreakDownModel({
    required this.percentProtein,
    required this.percentFat,
    required this.percentCarbs,
  });

  factory CaloricBreakDownModel.fromJson(Map<String, dynamic> json) {
    return CaloricBreakDownModel(
      percentProtein: json['percentProtein'],
      percentFat: json['percentFat'],
      percentCarbs: json['percentCarbs'],
    );
  }

  Map<String, dynamic> toJson() => {
        'percentProtein': percentProtein,
        'percentFat': percentFat,
        'percentCarbs': percentCarbs,
      };
  CaloricBreakdown toEntity() {
    return CaloricBreakdown(
      percentProtein: percentProtein,
      percentFat: percentFat,
      percentCarbs: percentCarbs,
    );
  }

  @override
  List<Object?> get props => [
        percentProtein,
        percentFat,
        percentCarbs,
      ];
}
