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
    final height = MediaQuery.of(context).size.height;
    final bloc = context.read<NutrientsBloc>();

    return Form(
      key: formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.725,
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.all(24),
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
                    width: width,
                    dismissKeyboard: dismissKeyboard,
                    scrollTop: scrollTop,
                    scrollBottom: scrollBottom,
                  ),
                  const SizedBox(height: 20),
                  Result(),
                ],
              ),
            ),
            Container(
              color: Colors.pink,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.close),
                        iconSize: 32,
                        onPressed: () {
                          bloc.add(NutrientsCleanIngredientsEvent(
                              scrollingTop: scrollTop));
                          cleanControllers();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: IconButton(
                      iconSize: 32,
                      icon: Icon(
                        Icons.check,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          bloc.add(NutrientsGetResultEvent(
                            scrollingBottom: scrollBottom,
                            scrollingTop: scrollTop,
                          ));
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
  void scrollBottom() =>
      scrollController.animateTo(scrollController.position.maxScrollExtent + 50,
          duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
  void scrollTop() =>
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
  void cleanControllers() {
    adderController.clear();
    insulineController.clear();
    sugarController.clear();
    scrollTop();
  }
}
