part of 'nutrients_bloc.dart';

enum NutrientsStatus {
  initial,
  loading,
  calculationSuccess,
  apiCalculationSuccess,
  failure
}

enum UserShould {
  doNothing,
  addInsuline,
  addFood,
}

class ResultedCalculation {
  const ResultedCalculation({required this.userShould, this.amount});
  final UserShould userShould;
  final double? amount;
}

class NutrientsState extends Equatable {
  const NutrientsState({
    this.status = NutrientsStatus.initial,
    this.ingredients = const [],
    this.recipeDetail,
    this.insuline = 0,
    this.sugar = 0,
    this.error,
    this.result,
    this.objective = 110,
    this.fsi = 50,
  });
  final NutrientsStatus status;
  final List<String>? ingredients;
  final RecipeDetail? recipeDetail;
  final num insuline;
  final num sugar;
  final String? error;
  final ResultedCalculation? result;
  final num objective;
  final num fsi;

  @override
  List<Object?> get props => [
        status,
        ingredients,
        recipeDetail,
        insuline,
        sugar,
        error,
        result,
        objective,
        fsi,
      ];

  NutrientsState copyWith({
    NutrientsStatus? status,
    UserShould? userShould,
    List<String>? ingredients,
    RecipeDetail? recipeDetail,
    num? insuline,
    num? sugar,
    String? error,
    ResultedCalculation? result,
    num? objective,
    num? fsi,
  }) {
    return NutrientsState(
      status: status ?? this.status,
      ingredients: ingredients ?? this.ingredients,
      recipeDetail: recipeDetail ?? this.recipeDetail,
      insuline: insuline ?? this.insuline,
      sugar: sugar ?? this.sugar,
      error: error ?? this.error,
      result: result ?? this.result,
      objective: objective ?? this.objective,
      fsi: fsi ?? this.fsi,
    );
  }
}
