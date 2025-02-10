import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/products/infrastructure/errors/errors.dart';
import 'package:teslo_shop/features/shared/infrastructure/mappers/mappers.dart';

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
    final response = await dio.get<List>("/products", queryParameters: {
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
  Future<Product> getProductById(String id) async {
    try {
      final response = await dio.get("/products/$id");
      return ProductMapper.jsonToEntity(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) throw ProductNotFoundError();
      throw ErrorMapper.customErrorFromDioException(e);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> searchProductsByTerm(String term) {
    throw UnimplementedError();
  }

  @override
  Future<Product> createOrUpdateProduct(Map<String, dynamic> productDto) async {
    try {
      final String? productId = productDto['id'];
      final String method = productId == null ? 'POST' : 'PATCH';
      final String url = productId == null ? '/post' : '/products/$productId';

      productDto.remove('id');
      final response = await dio.request(
        url,
        data: productDto,
        options: Options(method: method),
      );
      return ProductMapper.jsonToEntity(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) throw ProductNotFoundError();
      throw ErrorMapper.customErrorFromDioException(e);
    } catch (e) {
      throw Exception();
    }
  }
}
