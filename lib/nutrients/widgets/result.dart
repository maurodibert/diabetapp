import 'package:flutter/material.dart';
import 'package:diabetapp/nutrients/bloc/nutrients_bloc.dart';
import 'package:provider/src/provider.dart';

class Result extends StatelessWidget {
  const Result({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    switch (context.watch<NutrientsBloc>().state.status) {
      case NutrientsStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case NutrientsStatus.calculationSuccess:
        final _result = context
                    .watch<NutrientsBloc>()
                    .state
                    .result!
                    .userShould ==
                UserShould.doNothing
            ? 'You are in great shape!'
            : context.watch<NutrientsBloc>().state.result!.userShould ==
                    UserShould.addFood
                ? 'You have to eat ${context.watch<NutrientsBloc>().state.result!.amount!.toStringAsFixed(1)} grams of carbs'
                : 'You have to add ${context.watch<NutrientsBloc>().state.result!.amount!.toStringAsFixed(1)} of insuline';

        return Center(
          child: Text(
            _result,
            textAlign: TextAlign.center,
            style: _textTheme.headline5,
          ),
        );
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
