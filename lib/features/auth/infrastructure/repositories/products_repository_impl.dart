import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/datasources/products_datasource_impl.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDatasource datasource;

  ProductsRepositoryImpl([ProductsDatasource? datasource])
      : datasource = datasource ?? ProductsDatasourceImpl();

  @override
  Future<Product> createOrUpdateProduct(Map<String, dynamic> productDto) {
    return datasource.createOrUpdateProduct(productDto);
  }

  @override
  Future<Product> getProductById(String id) {
    return datasource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return datasource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductsByTerm(String term) {
    return datasource.searchProductsByTerm(term);
  }
}
