import 'package:haybuy_client/features/shop/models/product_model.dart';
import 'package:http/http.dart' as http;

class ItemService {
  static const baseUrl = 'http://10.0.2.2:8000';

  static Future<List<ProductModel>> fetchItems({
    String? search,
    double? minPrice,
    double? maxPrice,
    int? categoryId,
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/v1/item/').replace(queryParameters: {
        if (search != null) 'search': search,
        if (minPrice != null) 'min_price': minPrice.toString(),
        if (maxPrice != null) 'max_price': maxPrice.toString(),
        if (categoryId != null) 'category_id': categoryId.toString(),
        'skip': skip.toString(),
        'limit': limit.toString(),
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return ProductModel.fromJsonList(response.body);
      } else {
        throw Exception('Failed to load items');
      }

    } catch (e) {
      ('❌ Error: $e');
      rethrow;
    }
  
  }
}
