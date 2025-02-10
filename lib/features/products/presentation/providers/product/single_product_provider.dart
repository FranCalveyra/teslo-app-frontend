import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';

final singleProductProvider = StateNotifierProvider.autoDispose
    .family<SingleProductStateNotifier, ProductState, String>((ref, productId) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return SingleProductStateNotifier(
      productId: productId, productsRepository: productsRepository);
});

class SingleProductStateNotifier extends StateNotifier<ProductState> {
  final String productId;

  final ProductsRepository productsRepository;
  SingleProductStateNotifier({
    required this.productId,
    required this.productsRepository,
  }) : super(ProductState(id: productId)) {
    loadProduct();
  }

  Product _newEmptyProduct() {
    return Product(
      id: 'new',
      title: '',
      price: 0,
      description: '',
      slug: '',
      stock: 0,
      sizes: [],
      gender: '',
      tags: [],
      images: [],
    );
  }

  Future<void> loadProduct() async {
    try {
      Product product = state.id == 'new'
          ? _newEmptyProduct()
          : await productsRepository.getProductById(productId);
      state = state.copyWith(
        isLoading: false,
        product: product,
      );
    } catch (e) {
      print(e);
    }
  }
}

class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.isLoading = true,
    this.isSaving = false,
    this.product,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) {
    return ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving);
  }
}
