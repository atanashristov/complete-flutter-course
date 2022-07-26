import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tony_ecommerce_app/src/constants/test_products.dart';
import 'package:tony_ecommerce_app/src/features/products/domain/product.dart';

class FakeProductsRepository {
  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProductById(String id) => _getProduct(_products, id);

  Future<List<Product>> fetchProductsList() async {
    // await Future.delayed(const Duration(seconds: 2));
    // throw Exception('Failed to fetch products');
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    //throw Exception('Failed to fetch products');
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList().map((products) => _getProduct(products, id));
  }

  static Product? _getProduct(List<Product> products, String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListFutureProvider = FutureProvider<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsList();
});

final productsListStreamProvider = StreamProvider<List<Product>>((ref) {
  // debugPrint('created productsListStreamProvider');
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsList();
});

final productStreamProvider = StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  // debugPrint('created productStreamProvider with id=$id');
  // ref.onDispose(() {
  //   debugPrint('disposed productStreamProvider with id=$id');
  // });
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
});
