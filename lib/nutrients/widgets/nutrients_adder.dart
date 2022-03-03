import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diabetapp/nutrients/bloc/nutrients_bloc.dart';
import 'package:diabetapp/nutrients/widgets/result.dart';
import 'package:diabetapp/nutrients/widgets/your_meal.dart';

import 'active_insuline.dart';
import 'current_sugar.dart';
import 'package:diabetapp/l10n/l10n.dart';

class NutrientsAdder extends StatefulWidget {
  const NutrientsAdder({Key? key}) : super(key: key);

  @override
  _NutrientsAdderState createState() => _NutrientsAdderState();
}

class _NutrientsAdderState extends State<NutrientsAdder> {
  final formKey = GlobalKey<FormState>();
  final adderController = TextEditingController();
  final insulineController = TextEditingController();
  final sugarController = TextEditingController();

  @override
  void dispose() {
    adderController.dispose();
    insulineController.dispose();
    sugarController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bloc = context.read<NutrientsBloc>();
    final l10n = context.l10n;

    return Form(
      key: formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: SizedBox(
                height: height * 0.73,
                child: ListView(
                  children: [
                    ActiveInsuline(
                        insulineController: insulineController,
                        formKey: formKey,
                        bloc: bloc),
                    CurrentSugar(
                        sugarController: sugarController,
                        formKey: formKey,
                        bloc: bloc),
                    const SizedBox(height: 54),
                    YourMeal(
                        bloc: bloc,
                        adderController: adderController,
                        formKey: formKey,
                        width: width),
                    const SizedBox(height: 20),
                    Result(),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.amber,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlueAccent)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          bloc.add(NutrientsGetResultEvent());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(l10n!.nutrientsAdderCalculateButton,
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: Colors.white)),
                      )),
                ),
              ),
            )
          ]),
    );
  }
}
