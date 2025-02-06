import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';

import 'user_mapper.dart';

class ProductMapper {
  static Product jsonToEntity(Map<String, dynamic> json) => Product(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: double.parse(json['price'] ?? '0'),
      description: json['description'] ?? '',
      slug: json['slug'] ?? '',
      stock: json['stock'] ?? 0,
      sizes: List<String>.from(json['sizes'].map((size) => size ?? '')),
      gender: json['gender'] ?? '',
      tags: json['tags'],
      images: List<String>.from(
          json['images'].map((image) => _parseImage(image) ?? '')),
      user: UserMapper.userJsonToEntity(json['user']));

  static _parseImage(String image) {
    return image.startsWith("http")
        ? image
        : '${Environment.apiUrl}/files/product/$image';
  }
}
