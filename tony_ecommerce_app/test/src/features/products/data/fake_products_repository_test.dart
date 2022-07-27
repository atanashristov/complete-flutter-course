import 'package:flutter_test/flutter_test.dart';
import 'package:tony_ecommerce_app/src/constants/test_products.dart';
import 'package:tony_ecommerce_app/src/features/products/data/fake_products_repository.dart';

void main() {
  FakeProductsRepository makeProductsRepository() => FakeProductsRepository(addDelay: false);

  group('FakeProductsRepository', () {
    test('getProductsList returns global list of products', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.getProductsList(),
        kTestProducts,
      );
    });

    test('getProductById(1) returns first item', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.getProductById('1'),
        kTestProducts[0],
      );
    });

    // test('getProductById(-1) throws StateError', () {
    //   final productsRepository = makeProductsRepository();
    //   expect(
    //     // wrap in closure to evaluate at runtime
    //     () => productsRepository.getProductById('-1'),
    //     // use matcher to verify it throws StateError
    //     throwsStateError,
    //   );
    // });

    test('getProductById(-1) returns null', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.getProductById('-1'),
        null,
      );
    });

    // Use async/await to test Future results
    test('fetchProductsList returns global list of products', () async {
      final productsRepository = makeProductsRepository();
      expect(
        await productsRepository.fetchProductsList(),
        kTestProducts,
      );
    });

    // Use emit* matchers test Stream results
    test('watchProductsList emits global list of products', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.watchProductsList(),
        emits(kTestProducts),
      );
    });

    test('watchProduct(1) emits first item', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.watchProduct('1'),
        emits(kTestProducts[0]),
      );
    });

    test('watchProduct(-1) emits null', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.watchProduct('-1'),
        emits(null),
      );
    });
  });
}
