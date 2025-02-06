import 'package:teslo_shop/config/constants/environment.dart';

import '../../../auth/infrastructure/mappers/user_mapper.dart';
import '../../domain/domain.dart';

class ProductMapper {
  static Product jsonToEntity(Map<String, dynamic> json) => Product(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: double.parse(json['price'].toString()),
      description: json['description'] ?? '',
      slug: json['slug'] ?? '',
      stock: json['stock'] ?? 0,
      sizes: _listFromEntry(json, 'sizes'),
      gender: json['gender'] ?? '',
      tags: _listFromEntry(json, 'tags'),
      images: List<String>.from(
          json['images'].map((image) => _parseImage(image) ?? '')),
      user: UserMapper.userJsonToEntity(json['user']));

  static _parseImage(String image) {
    return image.startsWith("http")
        ? image
        : '${Environment.apiUrl}/files/product/$image';
  }

  static List<String> _listFromEntry(Map<String, dynamic> json, String key) {
    return List<String>.from(json[key].map((value) => value ?? ''));
  }
}
