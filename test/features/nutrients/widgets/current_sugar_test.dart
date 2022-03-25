import 'package:diabetapp/features/nutrients/nutrients.dart';
import 'package:diabetapp/features/nutrients/widgets/current_sugar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';
import '../../../helpers/l10n.dart';

class MockNutrientsBloc extends Mock implements NutrientsBloc {}

void main() {
  group('CurrentSugar', () {
    late NutrientsBloc bloc;

    setUp(() {
      bloc = MockNutrientsBloc();
    });

    CurrentSugar createSubject() {
      return CurrentSugar(
          sugarController: TextEditingController(),
          formKey: GlobalKey(),
          bloc: bloc);
    }

    group('constructor', () {
      test('works properly', () {
        expect(createSubject, returnsNormally);
      });
    });

    group('row', () {
      testWidgets('renders properly', (tester) async {
        await tester.pumpApp(createSubject());
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.byType(Text), findsOneWidget);
        expect(find.text(l10n.nutrientsCurrentSugarText), findsOneWidget);
      });
    });

    group('field of text', () {
      testWidgets('not allows letters but numbers', (tester) async {
        await tester.pumpApp(createSubject());
        final textField = find.byType(TextFormField);
        await tester.enterText(textField, 'Testing entering letters');
        await tester.pumpAndSettle();
        expect(find.text('Testing entering letters'), findsNothing);
        await tester.enterText(textField, '123');
        await tester.pumpAndSettle();
        expect(find.text('123'), findsOneWidget);
      });

      testWidgets('renders no error on empty value', (tester) async {
        await tester.pumpApp(createSubject());
        final textField = find.byType(TextFormField);
        await tester.enterText(textField, '');
        await tester.pumpAndSettle();
      });

      testWidgets('never add event to bloc on empty value', (tester) async {
        await tester.pumpApp(createSubject());
        final textField = find.byType(TextFormField);
        await tester.enterText(textField, '');
        await tester.pumpAndSettle();
        // TODO(#toAsk): why 'Used on a non-mocktail object'
        verifyNever(
          () => bloc.add,
        );
      });
    });
  });
}
