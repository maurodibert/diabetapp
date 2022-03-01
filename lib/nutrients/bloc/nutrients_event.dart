part of 'nutrients_bloc.dart';

abstract class NutrientsEvent extends Equatable {
  const NutrientsEvent();
  @override
  List<Object> get props => [];
}

class NutrientsSubscriptionRequested extends NutrientsEvent {
  const NutrientsSubscriptionRequested();
}

class NutrientsGetResultEvent extends NutrientsEvent {
  const NutrientsGetResultEvent();
}

class NutrientsSetIngredientsEvent extends NutrientsEvent {
  const NutrientsSetIngredientsEvent({required this.ingredient});
  final String ingredient;
  @override
  List<Object> get props => [ingredient];
}

class NutrientsCleanIngredientsEvent extends NutrientsEvent {
  const NutrientsCleanIngredientsEvent();
}

class NutrientsRemoveIngredientEvent extends NutrientsEvent {
  const NutrientsRemoveIngredientEvent({required this.ingredient});
  final String ingredient;
  @override
  List<Object> get props => [ingredient];
}

class NutrientsSetInsulineEvent extends NutrientsEvent {
  const NutrientsSetInsulineEvent({required this.insuline});
  final num insuline;
  @override
  List<Object> get props => [insuline];
}

class NutrientsSetSugarEvent extends NutrientsEvent {
  const NutrientsSetSugarEvent({required this.sugar});
  final num sugar;
  @override
  List<Object> get props => [sugar];
}
