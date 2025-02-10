import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/constants/constants.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/inputs/inputs.dart';
import 'package:teslo_shop/features/products/presentation/providers/product/products_provider.dart';
import 'package:teslo_shop/features/products/presentation/providers/product/products_repository_provider.dart';

// Provider
final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
  final notifier = ref.watch(productsProvider.notifier);
  final onSubmitCallback = notifier.createOrUpdateProduct;
  return ProductFormNotifier(
    product: product,
    onSubmitCallback: onSubmitCallback,
  );
});

// Notifier
class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final Future<bool> Function(Map<String, dynamic> productDto)?
      onSubmitCallback;

  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }) : super(
          ProductFormState(
            id: product.id,
            title: Title.dirty(product.title),
            price: Price.dirty(product.price),
            slug: Slug.dirty(product.slug),
            inStock: Stock.dirty(product.stock),
            description: product.description,
            sizes: product.sizes,
            gender: product.gender,
            tags: product.tags.join(","),
            images: product.images,
          ),
        );
  void onTitleChanged(String value) {
    final newTitle = Title.dirty(value);
    state = state.copyWith(
      title: newTitle,
      isFormValid: Formz.validate([
        newTitle,
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onSlugChanged(String value) {
    final newSlug = Slug.dirty(value);
    state = state.copyWith(
      slug: newSlug,
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        newSlug,
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onPriceChanged(double value) {
    final newPrice = Price.dirty(value);
    state = state.copyWith(
      price: newPrice,
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        newPrice,
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onStockChanged(int value) {
    final newStock = Stock.dirty(value);
    state = state.copyWith(
      inStock: newStock,
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        newStock,
      ]),
    );
  }

  void onSizesChanged(List<String> sizes) {
    state = state.copyWith(sizes: sizes);
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(tags: tags);
  }

  Future<bool> onFormSubmit() async {
    _touchAllFields();
    if (!state.isFormValid || onSubmitCallback == null) return false;
    final Map<String, dynamic> productDto = {
      "id": state.id,
      "title": state.title.value, // String
      "price": state.price.value, // double
      "slug": state.slug.value, // String
      "stock": state.inStock.value, // int
      "description": state.description,
      "sizes": state.sizes,
      "gender": state.gender,
      "tags": state.tags.split(','),
      "images": state.images.map(_formatImage).toList(), // List<String>
    };
    try {
      return await onSubmitCallback!(productDto);
    } catch (e) {
      return false;
    }
  }

  String _formatImage(String image) {
    final String from = "${Environment.apiUrl}/files/product/";
    return image.replaceAll(from, Constants.emptyString);
  }

  void _touchAllFields() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }
}

// State
class ProductFormState {
  ProductFormState({
    this.isFormValid = false,
    this.id = "",
    this.title = const Title.pure(),
    this.price = const Price.pure(),
    this.slug = const Slug.pure(),
    this.inStock = const Stock.pure(),
    this.description = "",
    this.sizes = const [],
    this.gender = "",
    this.tags = "",
    this.images = const [],
  });
  bool isFormValid;
  String id;
  Title title;
  Price price;
  Slug slug;
  Stock inStock;
  String description;
  List<String> sizes;
  String gender;
  String tags;
  List<String> images;

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Price? price,
    Slug? slug,
    Stock? inStock,
    String? description,
    List<String>? sizes,
    String? gender,
    String? tags,
    List<String>? images,
  }) =>
      ProductFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        slug: slug ?? this.slug,
        inStock: inStock ?? this.inStock,
        description: description ?? this.description,
        sizes: sizes ?? this.sizes,
        gender: gender ?? this.gender,
        tags: tags ?? this.tags,
        images: images ?? this.images,
      );
}
