import 'package:teslo_shop/config/constants/environment.dart';

import '../../../auth/infrastructure/mappers/user_mapper.dart';
import '../../domain/domain.dart';

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
