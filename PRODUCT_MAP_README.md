# Product Map Feature - แสดงหมุดพ่อค้า/แม่ค้าบนแผนที่

## ภาพรวมฟีเจอร์

ฟีเจอร์นี้แสดงพ่อค้า/แม่ค้าที่อยู่ใกล้เคียงบนแผนที่ Google Maps พร้อมระบบ:

- 📍 แสดงหมุดสีส้มของพ่อค้าที่มีพิกัด GPS
- 🗺️ แสดงตำแหน่งของผู้ใช้ปัจจุบัน
- 🛒 เมื่อกดหมุดจะแสดง Bottom Sheet พร้อมรายการสินค้าทั้งหมดของพ่อค้า
- 📱 รองรับ Permission สำหรับ Android และ iOS

## โครงสร้างไฟล์

```
lib/
├── features/shop/
│   ├── models/
│   │   ├── vendor_model.dart           # Model สำหรับข้อมูลพ่อค้า
│   │   ├── user_profile_model.dart     # Model สำหรับ User Profile (พิกัด, ที่อยู่)
│   │   └── product_model.dart          # Model สำหรับสินค้า
│   │
│   ├── controllers/
│   │   └── product_map_controller.dart # GetX Controller จัดการ state
│   │
│   └── screens/product_map/
│       ├── product_map.dart            # หน้าจอหลักของแผนที่
│       └── widgets/
│           └── vendor_products_bottom_sheet.dart  # Bottom Sheet แสดงสินค้า
│
└── data/repositories/vendor/
    ├── vendor_repository.dart          # Repository สำหรับเรียก API
    └── mock_vendor_data.dart           # Mock data สำหรับทดสอบ
```

## Models

### UserProfileModel

```dart
class UserProfileModel {
  final int id;
  final int userId;
  final String? phone;
  final String? addressLine1;
  final String? addressLine2;
  final String? district;
  final String? province;
  final String? postalCode;
  final double? latitude;        // พิกัด GPS
  final double? longitude;       // พิกัด GPS
  final bool locationVerified;
  final bool idVerified;
  // ...
}
```

### VendorModel

```dart
class VendorModel {
  final int id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profileImage;
  final UserProfileModel? profile;  // ข้อมูลโปรไฟล์พร้อมพิกัด
}
```

### ProductModel

```dart
class ProductModel {
  final int id;
  final String name;
  final String? description;
  final double price;
  final String? unit;
  final int? stock;
  final String? imageUrl;
  final int vendorId;
  final bool isAvailable;
}
```

## การทำงาน

### 1. เมื่อเปิดหน้าจอ (ProductMapScreen)

1. ขอ Location Permission
2. รับตำแหน่ง GPS ปัจจุบัน
3. เรียก API ผ่าน `VendorRepository.getNearbyVendors()` เพื่อดึงพ่อค้าใกล้เคียง (รัศมี 10 กม.)
4. สร้างหมุดสีส้มบนแผนที่สำหรับพ่อค้าแต่ละราย
5. เลื่อนกล้องไปยังตำแหน่งปัจจุบัน

### 2. เมื่อกดหมุดพ่อค้า

1. เรียก `onMarkerTapped()` ใน `ProductMapController`
2. เรียก API ผ่าน `VendorRepository.getVendorProducts(vendorId)` เพื่อดึงสินค้า
3. แสดง `VendorProductsBottomSheet` พร้อมรายการสินค้า

### 3. Bottom Sheet แสดง

- ชื่อพ่อค้า + รูปโปรไฟล์
- ที่อยู่ (เขต)
- รายการสินค้าทั้งหมดพร้อม:
  - รูปสินค้า
  - ชื่อและคำอธิบาย
  - ราคา (บาท/หน่วย)
  - สต็อคคงเหลือ

## การตั้งค่า Permissions

### Android (AndroidManifest.xml)

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### iOS (Info.plist)

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>แอปต้องการเข้าถึงตำแหน่งของคุณเพื่อแสดงบนแผนที่</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>แอปต้องการเข้าถึงตำแหน่งของคุณเพื่อแสดงบนแผนที่</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>แอปต้องการเข้าถึงตำแหน่งของคุณเพื่อแสดงบนแผนที่</string>
```

## การเชื่อมต่อ Backend API

ปัจจุบันใช้ Mock Data สำหรับทดสอบ เมื่อพร้อมเชื่อมต่อ Backend จริง:

### 1. แก้ไข `vendor_repository.dart`

```dart
class VendorRepository {
  // เปลี่ยนเป็น false เมื่อต้องการใช้ API จริง
  final bool useMockData = false;
  // ...
}
```

### 2. API Endpoints ที่ต้องมี

#### GET `/vendors/nearby`

Query Parameters:

- `lat`: latitude (double)
- `lng`: longitude (double)
- `radius`: รัศมีในกิโลเมตร (double)

Response:

```json
{
  "vendors": [
    {
      "id": 1,
      "username": "vendor1",
      "first_name": "สมชาย",
      "last_name": "ใจดี",
      "email": "somchai@example.com",
      "profile_image": "https://...",
      "profile": {
        "id": 1,
        "user_id": 1,
        "phone": "0812345678",
        "address_line1": "123 ถนนสุขุมวิท",
        "district": "บางนา",
        "province": "กรุงเทพมหานคร",
        "postal_code": "10260",
        "latitude": 13.7563,
        "longitude": 100.5018,
        "location_verified": true,
        "id_verified": true
      }
    }
  ]
}
```

#### GET `/vendors/{vendor_id}/products`

Response:

```json
{
  "products": [
    {
      "id": 1,
      "name": "มะม่วงน้ำดอกไม้",
      "description": "มะม่วงสด หวานฉ่ำ",
      "price": 120.0,
      "unit": "กก.",
      "stock": 50,
      "image_url": "https://...",
      "vendor_id": 1,
      "is_available": true
    }
  ]
}
```

### 3. อัปเดต Base URL

แก้ไข `lib/utils/http/http_client.dart`:

```dart
class THttpHelper {
  static const String _baseUrl = 'https://your-backend-api.com/api';
  // ...
}
```

## การใช้งาน

```dart
// เปิดหน้าจอแผนที่
Get.to(() => const ProductMapScreen());
```

## Dependencies ที่ใช้

```yaml
dependencies:
  google_maps_flutter: ^2.13.1 # Google Maps
  geolocator: ^13.0.2 # Location services
  get: ^4.6.5 # State management
  http: ^1.1.0 # HTTP requests
```

## การทดสอบ

1. รันแอป
2. อนุญาต Location Permission
3. รอโหลดหมุดพ่อค้า (ใช้ Mock Data)
4. กดหมุดสีส้ม
5. ดู Bottom Sheet แสดงสินค้า

## TODO / ปรับปรุงในอนาคต

- [ ] เพิ่มการค้นหาพ่อค้าตามชื่อ
- [ ] เพิ่มฟิลเตอร์ประเภทสินค้า
- [ ] เพิ่มการจัดเรียงตามระยะทาง
- [ ] เพิ่มปุ่มนำทางไป Google Maps
- [ ] เพิ่มรีวิวและเรตติ้งพ่อค้า
- [ ] เพิ่มระบบเพิ่มสินค้าลงตะกร้า
- [ ] แสดงระยะทางจากตำแหน่งปัจจุบัน
- [ ] Custom marker icon สำหรับพ่อค้าแต่ละประเภท

## หมายเหตุ

- Mock data มี 2 vendors อยู่ใกล้กรุงเทพ
- ต้องมี Google Maps API Key ใน AndroidManifest.xml
- ตรวจสอบให้แน่ใจว่า backend ส่ง latitude และ longitude มาด้วย
