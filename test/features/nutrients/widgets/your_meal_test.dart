import 'package:bloc_test/bloc_test.dart';
import 'package:diabetapp/features/nutrients/nutrients.dart';
import 'package:diabetapp/features/nutrients/widgets/your_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';
import '../../../helpers/l10n.dart';

class MockNutrientsBloc extends MockBloc<NutrientsEvent, NutrientsState>
    implements NutrientsBloc {}

class MockFunction extends Mock {
  void call();
}

class MockFormKey extends Mock implements GlobalKey<FormState> {}

void main() {
  group('YourMeal', () {
    late NutrientsBloc bloc;
    late void Function() mockedFunction;
    late GlobalKey<FormState> formKey;

    setUp(() {
      bloc = MockNutrientsBloc();
      mockedFunction = MockFunction();
      formKey = MockFormKey();

      when(() => bloc.state).thenReturn(const NutrientsState());
    });

    Widget createSubject() {
      return BlocProvider.value(
        value: bloc,
        child: YourMeal(
          width: 600,
          bloc: bloc,
          scrollTop: mockedFunction.call,
          scrollBottom: mockedFunction.call,
          formKey: formKey,
          adderController: TextEditingController(),
          dismissKeyboard: mockedFunction.call,
        ),
      );
    }

    group('constructor', () {
      test('works properly', () {
        expect(
          () => createSubject(),
          returnsNormally,
        );
      });
    });

    group('Columns', () {
      testWidgets('renders properly', (tester) async {
        await tester.pumpApp(Stack(children: [createSubject()]));
        expect(find.text(l10n.nutrientsYourMealText), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.byType(IconButton), findsNWidgets(2));
        expect(find.byType(Wrap), findsOneWidget);
      });

      //TODO(#continue: test functionality)
    });

    group('TextFormField', () {
      //TODO(#toAsk): why state null
      testWidgets('adds new ingredient if is not in the list', (tester) async {
        when(() => formKey.currentState).thenReturn(FormState());
        await tester.pumpApp(createSubject());

        final textFormField = find.byType(TextFormField);
        final addButton = find.byIcon(Icons.add);
        await tester.enterText(textFormField, '1 apple');
        await tester.pumpAndSettle();
        await tester.tap(addButton);
        await tester.pumpAndSettle();
        expect(find.byType(Chip), findsOneWidget);
        expect(find.text('1 apple'), findsOneWidget);
      });
    });
  });
}
