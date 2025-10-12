import '../../../features/shop/models/vendor_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../utils/http/http_client.dart';
import 'mock_vendor_data.dart';

class VendorRepository {
  // Set to true to use mock data, false to use real API
  final bool useMockData = true;

  /// Get nearby vendors within a certain radius (in kilometers)
  Future<List<VendorModel>> getNearbyVendors({
    required double latitude,
    required double longitude,
    double radiusKm = 5.0,
  }) async {
    // Use mock data for testing
    if (useMockData) {
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Simulate API delay
      return MockVendorData.getMockVendors();
    }

    try {
      final response =
          await THttpHelper.get(
            'vendors/nearby?lat=$latitude&lng=$longitude&radius=$radiusKm',
          ).timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response['vendors'] != null) {
        final List<dynamic> vendorsJson = response['vendors'];
        return vendorsJson.map((json) => VendorModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch nearby vendors: $e');
    }
  }

  /// Get all vendors
  Future<List<VendorModel>> getAllVendors() async {
    try {
      final response = await THttpHelper.get('vendors');

      if (response['vendors'] != null) {
        final List<dynamic> vendorsJson = response['vendors'];
        return vendorsJson.map((json) => VendorModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch vendors: $e');
    }
  }

  /// Get vendor by ID
  Future<VendorModel?> getVendorById(int vendorId) async {
    try {
      final response = await THttpHelper.get('vendors/$vendorId');
      return VendorModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch vendor: $e');
    }
  }

  /// Get products by vendor ID
  Future<List<ProductModel>> getVendorProducts(int vendorId) async {
    // Use mock data for testing
    if (useMockData) {
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Simulate API delay
      return MockVendorData.getMockProducts(vendorId);
    }

    try {
      final response = await THttpHelper.get('vendors/$vendorId/products')
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response['products'] != null) {
        final List<dynamic> productsJson = response['products'];
        return productsJson.map((json) => ProductModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch vendor products: $e');
    }
  }
}
