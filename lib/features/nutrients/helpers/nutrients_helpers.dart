import '../../../features/nutrients/bloc/nutrients_bloc.dart';

abstract class NutrientsHelpers {
  static num sugarToBalance({
    required double objective,
    required double sugar,
    required double insuline,
    required double fsi,
  }) =>
      objective - sugar + (insuline * fsi);

  static ResultedCalculation calculateResult({
    required double objective,
    required double sugar,
    required double insuline,
    required double fsi,
  }) {
    final double _sugarToBalance = (sugarToBalance(
      objective: objective,
      sugar: sugar,
      insuline: insuline,
      fsi: fsi,
    )).toDouble();
    final double _insulineAmount;
    final double _foodAmount;

    if (_sugarToBalance < 0) {
      _insulineAmount = (-_sugarToBalance / fsi);
      if (_insulineAmount == 0)
        return ResultedCalculation(userShould: UserShould.doNothing);
      return ResultedCalculation(
          userShould: UserShould.addInsuline, amount: _insulineAmount);
    } else if (_sugarToBalance > 0) {
      _foodAmount = _sugarToBalance;
      return ResultedCalculation(
          userShould: UserShould.addFood, amount: _foodAmount);
    } else {
      return ResultedCalculation(userShould: UserShould.doNothing);
    }
  }
}
