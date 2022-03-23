import 'package:diabetapp/features/nutrients/bloc/nutrients_bloc.dart';
import 'package:diabetapp/features/nutrients/widgets/result.dart';
import 'package:diabetapp/features/nutrients/widgets/your_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'action_buttons.dart';
import 'active_insuline.dart';
import 'current_sugar.dart';

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
  final scrollController = ScrollController();

  @override
  void dispose() {
    adderController.dispose();
    insulineController.dispose();
    sugarController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bloc = context.read<NutrientsBloc>();
    final iconSize = 32.0;

    return Form(
      key: formKey,
      child: Stack(children: [
        ListView(
          controller: scrollController,
          padding: EdgeInsets.fromLTRB(24, 12, 24, 36),
          children: [
            ActiveInsuline(
                insulineController: insulineController,
                formKey: formKey,
                bloc: bloc),
            CurrentSugar(
                sugarController: sugarController, formKey: formKey, bloc: bloc),
            const SizedBox(height: 54),
            YourMeal(
              bloc: bloc,
              adderController: adderController,
              formKey: formKey,
              width: width,
              dismissKeyboard: dismissKeyboard,
              scrollTop: scrollTop,
              scrollBottom: scrollBottom,
            ),
            const SizedBox(height: 8),
            Result(),
          ],
        ),
        ActionButtons(
          bloc: bloc,
          cleanControllers: cleanControllers,
          formKey: formKey,
          iconSize: iconSize,
          scrollBottom: scrollBottom,
          scrollTop: scrollTop,
          width: width,
        ),
      ]),
    );
  }

  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
  void scrollBottom() => scrollController.animateTo(
      scrollController.position.maxScrollExtent + 100,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut);
  void scrollTop() =>
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
  void cleanControllers() {
    adderController.clear();
    insulineController.clear();
    sugarController.clear();
    scrollTop();
  }
}
