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
  const NutrientsGetResultEvent({
    required this.scrollingBottom,
    required this.scrollingTop,
  });
  final void Function() scrollingBottom;
  final void Function() scrollingTop;
  @override
  List<Object> get props => [scrollingBottom, scrollingTop];
}

class NutrientsSetIngredientsEvent extends NutrientsEvent {
  const NutrientsSetIngredientsEvent({
    required this.ingredient,
    required this.scrollingBottom,
  });
  final String ingredient;
  final void Function() scrollingBottom;
  @override
  List<Object> get props => [ingredient, scrollingBottom];
}

class NutrientsCleanIngredientsEvent extends NutrientsEvent {
  const NutrientsCleanIngredientsEvent({required this.scrollingTop});
  final void Function() scrollingTop;
  @override
  List<Object> get props => [scrollingTop];
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
