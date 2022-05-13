import 'package:bloc_test/bloc_test.dart';
import 'package:diabetapp/features/nutrients/nutrients.dart';
import 'package:diabetapp/features/nutrients/widgets/action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../tests_helpers/helpers.dart';

class MockNutrientsBloc extends MockBloc<NutrientsEvent, NutrientsState>
    implements NutrientsBloc {}

class MockFunction extends Mock {
  void call();
}

void main() {
  group('ActionButtons', () {
    late NutrientsBloc bloc;
    late void Function() mockedFunction;

    setUp(() {
      bloc = MockNutrientsBloc();
      mockedFunction = MockFunction();

      when(
        () => bloc.state,
      ).thenReturn(const NutrientsState());
    });
    ActionButtons createSubject() {
      return ActionButtons(
          width: 600,
          bloc: bloc,
          scrollTop: mockedFunction.call,
          scrollBottom: mockedFunction.call,
          iconSize: 32,
          formKey: GlobalKey<FormState>(),
          cleanControllers: mockedFunction.call);
    }

    group('constructor', () {
      test('works properly', () {
        expect(
          () => createSubject(),
          returnsNormally,
        );
      });
    });

    group('buttons', () {
      testWidgets('renders properly', (tester) async {
        await tester.pumpApp(BlocProvider(
          create: (context) => bloc,
          child: Stack(children: [createSubject()]),
        ));
        expect(find.byType(IconButton), findsNWidgets(2));
      });

      testWidgets('renders circular progress indicator when bloc loading',
          (tester) async {
        when(() => bloc.state)
            .thenReturn(NutrientsState(status: NutrientsStatus.loading));

        await tester.pumpApp(BlocProvider(
          create: (context) => bloc,
          child: Stack(children: [createSubject()]),
        ));
        expect(find.byType(IconButton), findsNWidgets(1));
        expect(find.byType(CircularProgressIndicator), findsNWidgets(1));
      });
    });
  });
}
