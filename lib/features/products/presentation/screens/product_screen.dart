import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/config/constants/constants.dart';
import 'package:teslo_shop/features/products/presentation/providers/single_product_provider.dart';

class ProductScreen extends ConsumerWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(singleProductProvider(productId));
    final text = Text(_getTitle(productState));

    final floatingActionButton = FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.save_as_outlined),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Center(child: text),
      floatingActionButton: floatingActionButton,
    );
  }

  String _getTitle(ProductState productState) =>
      productState.product?.title ?? Constants.productCardPlaceholderText;
}
