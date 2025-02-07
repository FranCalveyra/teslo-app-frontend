import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop/features/products/presentation/views/views.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class ProductScreen extends ConsumerWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(singleProductProvider(productId));
    // final productFormNotifier =
    //     ref.read(productFormProvider(productState.product!).notifier);
    final floatingActionButton = FloatingActionButton(
      onPressed: () => {},
      child: const Icon(Icons.save_as_outlined),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      // body: Center(child: text),
      floatingActionButton: floatingActionButton,
      body: productState.isLoading
          ? const FullScreenLoader()
          : ProductView(product: productState.product!),
    );
  }
}
