// ignore_for_file: prefer_const_constructors
import 'package:ingredients_api/ingredients_api.dart';
import 'package:test/test.dart';

class TestIngredientsApi extends IngredientsApi {
  TestIngredientsApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('IngredientsApi', () {
    test('can be constructed', () {
      expect(() => TestIngredientsApi(), returnsNormally);
    });
  });
}
