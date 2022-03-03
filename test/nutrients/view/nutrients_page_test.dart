import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_repository/ingredients_repository.dart';
import 'package:diabetapp/nutrients/nutrients.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helpers/helpers.dart';

class MockIngredientsRepository extends Mock implements IngredientsRepository {}

void main() {
  late IngredientsRepository ingredientsRepository;
  group('IngredientsRepository', () {
    group('NutrientsPage', () {
      setUp(() {
        ingredientsRepository = MockIngredientsRepository();
        when(ingredientsRepository.getRecipeDetails)
            .thenAnswer((_) => const Stream.empty());
      });

      testWidgets('renders NutrientsPage', (tester) async {
        await tester.pumpApp(const NutrientsPage(),
            ingredientsRepository: ingredientsRepository);
        expect(find.byType(NutrientsView), findsOneWidget);
      });

      //TODO(mau): solve this issue
      testWidgets('subscribes to details from repository on initialization',
          (tester) async {
        await tester.pumpApp(
          const NutrientsPage(),
          ingredientsRepository: ingredientsRepository,
        );

        verify(() => ingredientsRepository.getRecipeDetails()).called(1);
      });
    });
  });
}
