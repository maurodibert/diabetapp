import 'package:flutter/material.dart';
import 'package:ingredients_repository/ingredients_repository.dart';
import 'package:diabetapp/features/nutrients/bloc/nutrients_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diabetapp/features/nutrients/widgets/nutrients_adder.dart';

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
    return NutrientsAdder();
  }
}
