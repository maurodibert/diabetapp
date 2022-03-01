import 'package:flutter/material.dart';
import 'package:ingredients_repository/ingredients_repository.dart';
import 'package:diabetapp/nutrients/bloc/nutrients_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diabetapp/nutrients/widgets/nutrients_adder.dart';

class NutrientsPage extends StatelessWidget {
  const NutrientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NutrientsBloc(
        ingredientsRepository: context.read<IngredientsRepository>(),
      )..add(const NutrientsSubscriptionRequested()),
      child: const NutrientsView(),
    );
  }
}

class NutrientsView extends StatelessWidget {
  const NutrientsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: NutrientsAdder(),
      )
    ]);
  }
}
