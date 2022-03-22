// Package imports:
import 'package:diabetapp/home/home.dart';
import 'package:diabetapp/theme/theme.dart';
import 'package:flutter/material.dart';
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
  });

  group('AppView', () {
    testWidgets('renders MaterialApp with correct themes', (tester) async {
      await tester.pumpWidget(RepositoryProvider.value(
        value: ingredientsRepository,
        child: AppView(),
      ));

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, equals(DiabetappTheme.light));
      expect(materialApp.darkTheme, equals(DiabetappTheme.dark));
    });
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(RepositoryProvider.value(
        value: ingredientsRepository,
        child: AppView(),
      ));
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
