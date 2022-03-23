import 'package:flutter/material.dart';
import 'package:diabetapp/features/nutrients/bloc/nutrients_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Result extends StatelessWidget {
  const Result({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    switch (context.watch<NutrientsBloc>().state.status) {
      case NutrientsStatus.loading:
        return SizedBox.shrink();
      case NutrientsStatus.calculationSuccess:
        return ResultView();
      case NutrientsStatus.failure:
        return Center(
          child: Text(
            context.watch<NutrientsBloc>().state.error ?? '',
            textAlign: TextAlign.center,
            style: _textTheme.headline5,
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }
}

class ResultView extends StatelessWidget {
  const ResultView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<NutrientsBloc, NutrientsState>(
      builder: (context, state) {
        bool hasRecipe = state.recipeDetail!.totalNutrients != null;
        final result = state.result!.userShould == UserShould.doNothing
            ? 'You are in great shape!'
            : state.result!.userShould == UserShould.addFood
                ? 'You have to eat ${context.watch<NutrientsBloc>().state.result!.amount!.toStringAsFixed(1)} grams of carbs'
                : 'You have to add ${context.watch<NutrientsBloc>().state.result!.amount!.toStringAsFixed(1)} of insuline';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Center(
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: hasRecipe
                        ? 'Your meal has ${context.watch<NutrientsBloc>().state.recipeDetail!.totalNutrients!.nutrient.quantity.toStringAsFixed(1)} grams of sugar | '
                        : '',
                    style: textTheme.headline5,
                    children: <TextSpan>[
                      TextSpan(
                        text: result,
                        style: hasRecipe
                            ? textTheme.bodyText1
                            : textTheme.headline5,
                      ),
                    ])),
          ),
        );
      },
    );
  }
}
