import 'package:equatable/equatable.dart';

class CaloricBreakdown extends Equatable {
  final double? percentProtein;
  final double? percentFat;
  final double? percentCarbs;

  const CaloricBreakdown({
    required this.percentProtein,
    required this.percentFat,
    required this.percentCarbs,
  });

  @override
  List<Object?> get props => [
        percentProtein,
        percentFat,
        percentCarbs,
      ];
}
