import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ingredients_repository/ingredients_repository.dart';
import 'package:diabetapp/nutrients/helpers/nutrients_helpers.dart';
part 'nutrients_state.dart';
part 'nutrients_event.dart';

class NutrientsBloc extends Bloc<NutrientsEvent, NutrientsState> {
  NutrientsBloc({required IngredientsRepository ingredientsRepository})
      : _ingredientsRepository = ingredientsRepository,
        super(const NutrientsState()) {
    on<NutrientsSubscriptionRequested>(_onSubscriptionRequested);
    on<NutrientsGetResultEvent>(_onGetResult);
    on<NutrientsSetIngredientsEvent>(_onSetIngredients);
    on<NutrientsCleanIngredientsEvent>(_onCleanIngredients);
    on<NutrientsRemoveIngredientEvent>(_onRemoveIngredient);
    on<NutrientsSetInsulineEvent>(_onSetInsuline);
    on<NutrientsSetSugarEvent>(_onSetSugar);
  }

  IngredientsRepository _ingredientsRepository;

  Future<void> _onSubscriptionRequested(
    NutrientsSubscriptionRequested event,
    Emitter<NutrientsState> emit,
  ) async {
    await emit.forEach<RecipeDetail>(
      _ingredientsRepository.getRecipeDetails(),
      onData: (recipe) {
        final result = NutrientsHelpers.calculateResult(
            objective: state.objective.toDouble(),
            sugar: state.sugar.toDouble() +
                double.parse(
                    recipe.totalNutrients.nutrient.quantity.toStringAsFixed(1)),
            insuline: state.insuline.toDouble(),
            fsi: state.fsi.toDouble());

        return state.copyWith(
          recipeDetail: recipe,
          status: NutrientsStatus.calculationSuccess,
          result: result,
        );
      },
      onError: (error, stackTrace) =>
          state.copyWith(status: NutrientsStatus.failure),
    );
  }

  Future<void> _onGetResult(
    NutrientsGetResultEvent event,
    Emitter<NutrientsState> emit,
  ) async {
    emit(state.copyWith(status: NutrientsStatus.loading));
    // TODO(Mau): check if next calculation is correct
    // TODO(Mau): add possibility to custom fsi and objective

    if (state.ingredients == null || state.ingredients!.isEmpty) {
      final result = NutrientsHelpers.calculateResult(
          objective: state.objective.toDouble(),
          sugar: state.sugar.toDouble(),
          insuline: state.insuline.toDouble(),
          fsi: state.fsi.toDouble());
      emit(state.copyWith(
        status: NutrientsStatus.calculationSuccess,
        result: result,
      ));
    } else {
      try {
        await _ingredientsRepository.getDetails(state.ingredients!);
      } catch (e) {
        e as DioError;
        emit(state.copyWith(
          status: NutrientsStatus.failure,
          error: e.message,
        ));
      }
    }
  }

  void _onSetIngredients(
    NutrientsSetIngredientsEvent event,
    Emitter<NutrientsState> emit,
  ) {
    final ingredients = state.ingredients?.toList() ?? [];
    ingredients.add(event.ingredient);
    emit(state.copyWith(ingredients: ingredients));
  }

  void _onCleanIngredients(
    NutrientsCleanIngredientsEvent event,
    Emitter<NutrientsState> emit,
  ) {
    emit(state.copyWith(ingredients: []));
  }

  void _onRemoveIngredient(
    NutrientsRemoveIngredientEvent event,
    Emitter<NutrientsState> emit,
  ) {
    final ingredients = state.ingredients!.toList();
    ingredients.remove(event.ingredient);
    emit(state.copyWith(ingredients: ingredients));
  }

  void _onSetInsuline(
    NutrientsSetInsulineEvent event,
    Emitter<NutrientsState> emit,
  ) {
    emit(state.copyWith(insuline: event.insuline));
  }

  void _onSetSugar(
    NutrientsSetSugarEvent event,
    Emitter<NutrientsState> emit,
  ) {
    emit(state.copyWith(sugar: event.sugar));
  }
}
