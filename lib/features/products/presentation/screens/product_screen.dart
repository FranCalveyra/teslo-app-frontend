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

    final floatingActionButton = FloatingActionButton(
      onPressed: () => _onPressed(productState, ref, context),
      child: const Icon(Icons.save_as_outlined),
    );

    final selectImageButton = IconButton(
      onPressed: () => _selectImage(ref, productState),
      icon: const Icon(Icons.photo_library_outlined),
    );

    final takePhotoButton = IconButton(
      onPressed: () => _takePicture(ref, productState),
      icon: const Icon(Icons.camera_alt_outlined),
    );

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Edit Product'),
          actions: [selectImageButton, takePhotoButton],
        ),
        // body: Center(child: text),
        floatingActionButton: floatingActionButton,
        body: productState.isLoading
            ? const FullScreenLoader()
            : ProductView(product: productState.product!),
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      const SnackBar(
        content: Text('Updated Product'),
      ),
    );
  }

  // Private methods
  void _onPressed(
      ProductState productState, WidgetRef ref, BuildContext context) {
    if (productState.product == null) return;
    ref
        .read(productFormProvider(productState.product!).notifier)
        .onFormSubmit()
        .then(
      (value) {
        if (!value) return;
        // ignore: use_build_context_synchronously
        showSnackBar(context);
      },
    );
  }

  void _selectImage(WidgetRef ref, ProductState productState) async {
    final photoPath = await CameraGalleryServiceImpl().selectPhoto();
    if (photoPath == null) return;
    ref
        .read(productFormProvider(productState.product!).notifier)
        .updateProductImage(photoPath);
  }

  void _takePicture(WidgetRef ref, ProductState productState) async {
    final photoPath = await CameraGalleryServiceImpl().takePhoto();
    if (photoPath == null) return;
    ref
        .read(productFormProvider(productState.product!).notifier)
        .updateProductImage(photoPath);
  }
}
