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

  Future<void> loadProduct() async {
    try {
      final product = await productsRepository.getProductById(productId);
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
