// Flutter imports:
import 'package:diabetapp/resources/l10n/l10n.dart';
import 'package:diabetapp/resources/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ingredients_repository/ingredients_repository.dart';

import '../../features/home/view/home.dart';

// Project imports:

class App extends StatelessWidget {
  App({required this.ingredientsRepository, Key? key}) : super(key: key);
  final IngredientsRepository ingredientsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: ingredientsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DiabetappTheme.light,
      darkTheme: DiabetappTheme.dark,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomePage(),
    );
  }
}
