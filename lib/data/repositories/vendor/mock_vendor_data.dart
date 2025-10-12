import '../../../features/shop/models/vendor_model.dart';
import '../../../features/shop/models/product_model.dart';

/// Mock data for testing purposes
/// Replace this with actual API calls in production
class MockVendorData {
  /// Get mock vendors for testing
  static List<VendorModel> getMockVendors() {
    return [
      VendorModel(
        id: 1,
        username: 'vendor1',
        firstName: 'สมชาย',
        lastName: 'ใจดี',
        email: 'somchai@example.com',
        profileImage: null,
        profile: UserProfileModel(
          id: 1,
          userId: 1,
          phone: '0812345678',
          addressLine1: '123 ถนนสุขุมวิท',
          district: 'บางนา',
          province: 'กรุงเทพมหานคร',
          postalCode: '10260',
          latitude: 13.7563,
          longitude: 100.5018,
          locationVerified: true,
          idVerified: true,
        ),
      ),
      VendorModel(
        id: 2,
        username: 'vendor2',
        firstName: 'สมหญิง',
        lastName: 'รักดี',
        email: 'somying@example.com',
        profileImage: null,
        profile: UserProfileModel(
          id: 2,
          userId: 2,
          phone: '0823456789',
          addressLine1: '456 ถนนพระราม 9',
          district: 'ห้วยขวาง',
          province: 'กรุงเทพมหานคร',
          postalCode: '10310',
          latitude: 13.7650,
          longitude: 100.5690,
          locationVerified: true,
          idVerified: false,
        ),
      ),
    ];
  }

  /// Get mock products for a vendor
  static List<ProductModel> getMockProducts(int vendorId) {
    if (vendorId == 1) {
      return [
        ProductModel(
          id: 1,
          name: 'มะม่วงน้ำดอกไม้',
          description: 'มะม่วงสด หวานฉ่ำ คุณภาพดี',
          price: 120.0,
          unit: 'กก.',
          stock: 50,
          imageUrl: null,
          vendorId: 1,
          isAvailable: true,
        ),
        ProductModel(
          id: 2,
          name: 'ทุเรียนหมอนทอง',
          description: 'ทุเรียนแท้จากสวน หวานมัน อร่อย',
          price: 350.0,
          unit: 'กก.',
          stock: 20,
          imageUrl: null,
          vendorId: 1,
          isAvailable: true,
        ),
        ProductModel(
          id: 3,
          name: 'มังคุดสด',
          description: 'มังคุดจากสวนตรัง หวานฉ่ำ',
          price: 80.0,
          unit: 'กก.',
          stock: 30,
          imageUrl: null,
          vendorId: 1,
          isAvailable: true,
        ),
      ];
    } else if (vendorId == 2) {
      return [
        ProductModel(
          id: 4,
          name: 'ข้าวหอมมะลิ',
          description: 'ข้าวหอมมะลิ 100% คุณภาพพรีเมียม',
          price: 45.0,
          unit: 'กก.',
          stock: 100,
          imageUrl: null,
          vendorId: 2,
          isAvailable: true,
        ),
        ProductModel(
          id: 5,
          name: 'น้ำมันปาล์ม',
          description: 'น้ำมันปาล์มบริสุทธิ์',
          price: 55.0,
          unit: 'ลิตร',
          stock: 50,
          imageUrl: null,
          vendorId: 2,
          isAvailable: true,
        ),
      ];
    }
    return [];
  }
}
