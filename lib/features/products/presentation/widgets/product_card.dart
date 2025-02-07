import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/config/constants/constants.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          _ProductImage(images: product.images),
          const SizedBox(height: 20),
          Text(product.title, textAlign: TextAlign.center),
        ],
      ),
      onTap: () => context.push("/products/${product.id}"),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final List<String> images;
  const _ProductImage({required this.images});

  @override
  Widget build(BuildContext context) {
    final noImage = ClipRRect(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      child: Image.asset(
        'assets/images/no-image.jpg',
        fit: BoxFit.cover,
        height: 250,
      ),
    );

    const placeholder = AssetImage('assets/loaders/bottle-loader.gif');

    const animationDuration = Duration(milliseconds: 100);
    const outAnimationDuration = Duration(milliseconds: 200);

    return images.isEmpty
        ? noImage
        : FadeInImage(
            fadeInDuration: animationDuration,
            fadeOutDuration: outAnimationDuration,
            placeholder: placeholder,
            image: NetworkImage(images.first),
            fit: BoxFit.cover,
          );
  }
}
