import 'package:diabetapp/resources/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diabetapp/features/nutrients/bloc/nutrients_bloc.dart';

class ActiveInsuline extends StatelessWidget {
  const ActiveInsuline({
    Key? key,
    required this.insulineController,
    required this.formKey,
    required this.bloc,
  }) : super(key: key);

  final TextEditingController insulineController;
  final GlobalKey<FormState> formKey;
  final NutrientsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n!.nutrientsActiveInsulineText,
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
            controller: insulineController,
            onChanged: (value) {
              if (value.isEmpty) return;
              bloc.add(
                  NutrientsSetInsulineEvent(insuline: double.parse(value)));
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
