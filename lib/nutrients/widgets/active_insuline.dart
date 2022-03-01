import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diabetapp/nutrients/bloc/nutrients_bloc.dart';

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Active insuline',
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
              final _value = value.isEmpty ? '0' : value;
              if (value.isEmpty) ;
              bloc.add(
                  NutrientsSetInsulineEvent(insuline: double.parse(_value)));
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
