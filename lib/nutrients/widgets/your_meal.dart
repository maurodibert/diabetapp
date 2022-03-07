import 'package:diabetapp/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:diabetapp/nutrients/bloc/nutrients_bloc.dart';
import 'package:provider/src/provider.dart';

class YourMeal extends StatelessWidget {
  const YourMeal({
    Key? key,
    required this.bloc,
    required this.adderController,
    required this.formKey,
    required this.width,
    required this.dismissKeyboard,
    required this.scrollTop,
    required this.scrollBottom,
  }) : super(key: key);

  final NutrientsBloc bloc;
  final TextEditingController adderController;
  final GlobalKey<FormState> formKey;
  final double width;
  final void Function() dismissKeyboard;
  final void Function() scrollTop;
  final void Function() scrollBottom;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n!.nutrientsYourMealText,
          style: Theme.of(context).textTheme.headline6,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (bloc.state.ingredients != null &&
                      bloc.state.ingredients!.contains(value)) {
                    return 'Already in the list!';
                  }
                  if ((value == null || value.isEmpty) &&
                      (bloc.state.ingredients == null &&
                          bloc.state.ingredients!.isEmpty)) {
                    return 'Must enter something!';
                  }
                  return null;
                },
                controller: adderController,
              ),
            ),
            IconButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  bloc.add(NutrientsSetIngredientsEvent(
                    ingredient: adderController.text.trim(),
                    scrollingBottom: scrollBottom,
                  ));
                  adderController.clear();
                  dismissKeyboard();
                }
              },
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                bloc.add(NutrientsCleanIngredientsEvent(
                  scrollingTop: scrollTop,
                ));
                adderController.clear();
                dismissKeyboard();
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: width,
          child: Wrap(
            children: [
              if (bloc.state.ingredients != null)
                ...context.watch<NutrientsBloc>().state.ingredients!.map((e) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Chip(
                        label: Text(e),
                        deleteIcon: Icon(Icons.highlight_remove),
                        onDeleted: () {
                          bloc.add(
                              NutrientsRemoveIngredientEvent(ingredient: e));
                        },
                      ),
                    )),
            ],
          ),
        ),
      ],
    );
  }
}
