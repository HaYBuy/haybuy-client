# Backend API Requirements for Product Map Feature

## Overview

ฟีเจอร์แผนที่ต้องการ API endpoints เพื่อดึงข้อมูลพ่อค้าและสินค้า

## Required Endpoints

### 1. Get Nearby Vendors

```
GET /api/vendors/nearby
```

**Query Parameters:**

- `lat` (required): Latitude ของผู้ใช้
- `lng` (required): Longitude ของผู้ใช้
- `radius` (optional): รัศมีการค้นหาในกิโลเมตร (default: 10)

**Response Example:**

```json
{
  "vendors": [
    {
      "id": 1,
      "username": "vendor1",
      "first_name": "สมชาย",
      "last_name": "ใจดี",
      "email": "somchai@example.com",
      "profile_image": "https://example.com/images/profile1.jpg",
      "profile": {
        "id": 1,
        "user_id": 1,
        "phone": "0812345678",
        "address_line1": "123 ถนนสุขุมวิท",
        "address_line2": "แขวงบางนา",
        "district": "บางนา",
        "province": "กรุงเทพมหานคร",
        "postal_code": "10260",
        "latitude": 13.7563,
        "longitude": 100.5018,
        "location_verified": true,
        "id_verified": true,
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z"
      }
    }
  ]
}
```

**Logic Requirements:**

- ต้องคำนวณระยะทางจากพิกัดผู้ใช้ไปยังพิกัดพ่อค้า
- ส่งกลับเฉพาะพ่อค้าที่:
  - `latitude` และ `longitude` ไม่เป็น null
  - อยู่ในรัศมีที่กำหนด
  - มีสถานะ active

**SQL Example (PostgreSQL with PostGIS):**

```sql
SELECT u.*, up.*
FROM users u
INNER JOIN user_profiles up ON u.id = up.user_id
WHERE up.latitude IS NOT NULL
  AND up.longitude IS NOT NULL
  AND u.is_vendor = true
  AND u.is_active = true
  AND ST_DWithin(
    ST_MakePoint(up.longitude, up.latitude)::geography,
    ST_MakePoint(:lng, :lat)::geography,
    :radius * 1000  -- convert km to meters
  )
ORDER BY ST_Distance(
  ST_MakePoint(up.longitude, up.latitude)::geography,
  ST_MakePoint(:lng, :lat)::geography
);
```

---

### 2. Get Vendor Products

```
GET /api/vendors/{vendor_id}/products
```

**Path Parameters:**

- `vendor_id` (required): ID ของพ่อค้า

**Response Example:**

```json
{
  "products": [
    {
      "id": 1,
      "name": "มะม่วงน้ำดอกไม้",
      "description": "มะม่วงสด หวานฉ่ำ คุณภาพดี",
      "price": 120.0,
      "unit": "กก.",
      "stock": 50,
      "image_url": "https://example.com/images/mango.jpg",
      "vendor_id": 1,
      "is_available": true,
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    },
    {
      "id": 2,
      "name": "ทุเรียนหมอนทอง",
      "description": "ทุเรียนแท้จากสวน หวานมัน",
      "price": 350.0,
      "unit": "กก.",
      "stock": 20,
      "image_url": "https://example.com/images/durian.jpg",
      "vendor_id": 1,
      "is_available": true,
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    }
  ]
}
```

**Logic Requirements:**

- ส่งกลับเฉพาะสินค้าของพ่อค้าที่ระบุ
- สามารถกรองเฉพาะสินค้าที่ `is_available = true` (optional)

**SQL Example:**

```sql
SELECT *
FROM products
WHERE vendor_id = :vendor_id
  AND is_available = true
ORDER BY created_at DESC;
```

---

## Database Schema Requirements

### users table

```sql
- id (int, primary key)
- username (string)
- first_name (string, nullable)
- last_name (string, nullable)
- email (string, nullable)
- profile_image (string, nullable)
- is_vendor (boolean)
- is_active (boolean)
```

### user_profiles table (ตามที่คุณมีอยู่แล้ว)

```sql
- id (int, primary key)
- user_id (int, foreign key -> users.id)
- phone (string, nullable)
- address_line1 (string, nullable)
- address_line2 (string, nullable)
- district (string, nullable)
- province (string, nullable)
- postal_code (string, nullable)
- latitude (float, nullable)  ⚠️ REQUIRED for map
- longitude (float, nullable) ⚠️ REQUIRED for map
- location_verified (boolean, default: false)
- id_verified (boolean, default: false)
- created_at (timestamp)
- updated_at (timestamp)
```

### products table

```sql
- id (int, primary key)
- name (string)
- description (string, nullable)
- price (decimal/float)
- unit (string, nullable)
- stock (int, nullable)
- image_url (string, nullable)
- vendor_id (int, foreign key -> users.id)
- is_available (boolean, default: true)
- created_at (timestamp)
- updated_at (timestamp)
```

---

## Additional Recommendations

### 1. Add Indexes

```sql
CREATE INDEX idx_user_profiles_location ON user_profiles(latitude, longitude);
CREATE INDEX idx_products_vendor ON products(vendor_id);
CREATE INDEX idx_users_is_vendor ON users(is_vendor);
```

### 2. Add Distance Calculation Helper

พิจารณาเพิ่ม function หรือ stored procedure สำหรับคำนวณระยะทาง:

```python
from math import radians, cos, sin, asin, sqrt

def haversine(lon1, lat1, lon2, lat2):
    """
    Calculate the great circle distance between two points
    on the earth (specified in decimal degrees)
    Returns distance in kilometers
    """
    lon1, lat1, lon2, lat2 = map(radians, [lon1, lat1, lon2, lat2])

    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = sin(dlat/2)**2 + cos(lat1) * cos(lat2) * sin(dlon/2)**2
    c = 2 * asin(sqrt(a))
    km = 6371 * c
    return km
```

### 3. Response Optimization

- ใช้ pagination สำหรับรายการสินค้าถ้ามีจำนวนมาก
- เพิ่มฟิลด์ `distance` (ระยะทางจากผู้ใช้) ใน vendor response
- รองรับ image optimization/CDN

### 4. Security

- ตรวจสอบ authentication ถ้าจำเป็น
- Validate latitude/longitude range (-90 to 90, -180 to 180)
- Rate limiting สำหรับป้องกัน abuse

---

## Testing with Mock Data

ตอนนี้ Frontend ใช้ Mock Data อยู่ที่:

```
lib/data/repositories/vendor/mock_vendor_data.dart
```

เมื่อ Backend พร้อมแล้ว แก้ไขที่:

```dart
// lib/data/repositories/vendor/vendor_repository.dart
class VendorRepository {
  final bool useMockData = false; // เปลี่ยนเป็น false
}
```

และอัปเดต Base URL:

```dart
// lib/utils/http/http_client.dart
static const String _baseUrl = 'https://your-backend-url.com/api';
```
