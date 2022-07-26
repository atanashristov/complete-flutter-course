import 'package:flutter_test/flutter_test.dart';
import 'package:tony_ecommerce_app/src/constants/test_products.dart';
import 'package:tony_ecommerce_app/src/features/products/data/fake_products_repository.dart';

void main() {
  test('getProductsList returns global list of products', () {
    final productsRepository = FakeProductsRepository();
    expect(
      productsRepository.getProductsList(),
      kTestProducts,
    );
  });

  test('getProductById(1) returns first item', () {
    final productsRepository = FakeProductsRepository();
    expect(
      productsRepository.getProductById('1'),
      kTestProducts[0],
    );
  });

  test('getProductById(-1) throws StateError', () {
    final productsRepository = FakeProductsRepository();
    expect(
      // wrap in closure to evaluate at runtime
      () => productsRepository.getProductById('-1'),
      // use matcher to verify it throws StateError
      throwsStateError,
    );
  });
}
