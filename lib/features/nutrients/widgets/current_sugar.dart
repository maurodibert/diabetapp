import 'package:diabetapp/resources/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diabetapp/features/nutrients/bloc/nutrients_bloc.dart';

class CurrentSugar extends StatelessWidget {
  const CurrentSugar({
    Key? key,
    required this.sugarController,
    required this.formKey,
    required this.bloc,
  }) : super(key: key);

  final TextEditingController sugarController;
  final GlobalKey<FormState> formKey;
  final NutrientsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n!.nutrientsCurrentSugarText,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(width: 24),
        Expanded(
          child: TextFormField(
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
            ],
            validator: (value) {
              return validate(value);
            },
            controller: sugarController,
            onChanged: (value) {
              final _value = value.isEmpty ? '0' : value;

              bloc.add(NutrientsSetSugarEvent(sugar: double.parse(_value)));
            },
          ),
        ),
      ],
    );
  }
}

String? validate(String? value) {
  if (value != null && value.isNotEmpty) {
    if (double.parse(value) < 0) {
      return 'Cannot be less than 0';
    }
  }
  return null;
}
