// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_repository/ingredients_repository.dart';

// Project imports:
import 'package:diabetapp/l10n/l10n.dart';
import 'package:mockingjay/mockingjay.dart';

class MockIngredientsRepository extends Mock implements IngredientsRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    IngredientsRepository? ingredientsRepository,
  }) {
    return pumpWidget(
      RepositoryProvider.value(
        value: ingredientsRepository ?? MockIngredientsRepository(),
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: widget),
        ),
      ),
    );
  }

  Future<void> pumpRoute(
    Route<dynamic> route, {
    IngredientsRepository? ingredientsRepository,
  }) {
    return pumpApp(
      Navigator(onGenerateRoute: (_) => route),
      ingredientsRepository: ingredientsRepository,
    );
  }
}
