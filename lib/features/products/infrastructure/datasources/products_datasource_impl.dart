import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';

import '../../domain/domain.dart';
import '../mappers/mappers.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  late final Dio dio;
  final String accessToken;

  ProductsDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    final response = await dio
        .get<List>("/products", queryParameters: {
      'limit': limit,
      'offset': offset,
    });
    // final List<Product> products = [];
    // for (final Map<String, dynamic> product in response.data ?? []) {
    //   products.add(ProductMapper.jsonToEntity(product));
    // }

    // return products;

    return (response.data ?? [])
        .map((product) => ProductMapper.jsonToEntity(product))
        .toList();
  }

  @override
  Future<Product> getProductById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> searchProductsByTerm(String term) {
    throw UnimplementedError();
  }

  @override
  Future<Product> createOrUpdateProduct(Map<String, dynamic> productDto) {
    throw UnimplementedError();
  }
}
