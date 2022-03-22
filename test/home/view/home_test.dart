// Package imports:
import 'package:diabetapp/home/home.dart';
import 'package:diabetapp/nutrients/nutrients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_repository/ingredients_repository.dart';
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
  group('HomePage', () {
    testWidgets('renders HomeView', (tester) async {
      await tester.pumpApp(HomePage(),
          ingredientsRepository: ingredientsRepository);
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    testWidgets('renders Scaffold with AppBar and NutrientsPage',
        (tester) async {
      await tester.pumpApp(HomePage(),
          ingredientsRepository: ingredientsRepository);

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(NutrientsPage), findsOneWidget);
    });
  });
}
