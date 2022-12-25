import 'package:equatable/equatable.dart';

class Nutrients extends Equatable {
  final String? name;
  final double? amount;
  final String? unit;
  final double? percentOfDailyNeeds;

  const Nutrients({
    required this.name,
    required this.amount,
    required this.unit,
    required this.percentOfDailyNeeds,
  });

  @override
  List<Object?> get props => [
        name,
        amount,
        unit,
        percentOfDailyNeeds,
      ];
}
