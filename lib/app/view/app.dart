// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ingredients_repository/ingredients_repository.dart';
import 'package:diabetapp/home/home.dart';

// Project imports:
import 'package:diabetapp/l10n/l10n.dart';

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
      theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.black87),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.pink,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.black87,
            textTheme: ButtonTextTheme.normal,
          )),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomePage(),
    );
  }
}
