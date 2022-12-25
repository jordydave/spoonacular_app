part of 'search_recipe_bloc.dart';

abstract class SearchRecipeEvent extends Equatable {
  const SearchRecipeEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchRecipeEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
