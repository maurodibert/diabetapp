// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// Package imports:
import 'package:diabetapp/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_repository/ingredients_repository.dart';
import 'package:diabetapp/app/app.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

// Project imports:

void main() {
  late IngredientsRepository ingredientsRepository;
  setUp(() {
    ingredientsRepository = MockIngredientsRepository();
    when(() => ingredientsRepository.getRecipeDetails())
        .thenAnswer((_) => Stream.empty());
  });
  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(App(
        ingredientsRepository: ingredientsRepository,
      ));
      expect(find.byType(AppView), findsOneWidget);
    });

    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(RepositoryProvider.value(
        value: ingredientsRepository,
        child: AppView(),
      ));
      expect(find.byType(AppView), findsOneWidget);
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
