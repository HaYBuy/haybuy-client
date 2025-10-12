# User Profile Screen

หน้าแสดงโปรไฟล์ของผู้ขาย (Seller Profile) ที่ประกอบด้วยข้อมูลหลักของผู้ใช้, รีวิว และสินค้าทั้งหมดที่เปิดขาย

## 📁 โครงสร้างไฟล์

```
lib/features/shop/screens/user_profile/
├── user_profile_screen.dart          # หน้าหลัก User Profile
├── user_profile_example.dart         # ตัวอย่างการใช้งาน
└── widgets/
    ├── user_header_section.dart      # ส่วนแสดงข้อมูล User
    ├── user_reviews_section.dart     # ส่วนแสดง Reviews
    └── user_products_section.dart    # ส่วนแสดงสินค้า
```

## 🎯 Features

### 1. User Header Section

- **รูปโปรไฟล์**: แสดงรูปภาพโปรไฟล์ของผู้ขาย
- **ข้อมูลพื้นฐาน**:
  - ชื่อผู้ใช้
  - สถานะการยืนยัน (Verified Seller)
  - ที่อยู่ (Location)
- **Statistics**:
  - จำนวนสินค้า (Products)
  - คะแนนเฉลี่ย (Rating)
  - จำนวนผู้ติดตาม (Followers)
- **Action Buttons**:
  - ปุ่มส่งข้อความ (Message)
  - ปุ่มติดตาม (Follow)

### 2. Reviews Section

- แสดง **1 รีวิว** ล่าสุด
- ปุ่ม "See All" เพื่อดูรีวิวทั้งหมด
- นำไปที่หน้า `UserAllReviewsScreen` ที่แสดงรีวิวทั้งหมด

### 3. Products Section

- แสดง**สินค้าทั้งหมด**ที่ผู้ขายเปิดขาย
- ใช้ `GridLayout` เพื่อแสดงสินค้าในรูปแบบ Grid
- ใช้ `ProductCardVertical` เพื่อแสดงแต่ละสินค้า

## 🚀 วิธีใช้งาน

### เรียกใช้หน้า User Profile

```dart
import 'package:get/get.dart';
import 'package:haybuy_client/features/shop/screens/user_profile/user_profile_screen.dart';

// วิธีที่ 1: ใช้ GetX Navigation
Get.to(() => const UserProfileScreen());

// วิธีที่ 2: ใช้ Navigator (Standard Flutter)
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const UserProfileScreen()),
);
```

### ตัวอย่างการใช้ใน Button

```dart
ElevatedButton(
  onPressed: () {
    Get.to(() => const UserProfileScreen());
  },
  child: const Text('View Seller Profile'),
)
```

## 🔮 Future Enhancements

ฟีเจอร์ที่ควรพัฒนาต่อในอนาคต:

### 1. รับ User ID เป็น Parameter

```dart
class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen({
    super.key,
    required this.userId,
  });

  // ดึงข้อมูลจาก Backend ตาม userId
}
```

### 2. เชื่อมต่อกับ Backend API

- ดึงข้อมูล User Profile
- ดึง Reviews ของ User
- ดึงสินค้าทั้งหมดของ User
- ระบบ Follow/Unfollow
- ระบบส่งข้อความ (Chat)

### 3. State Management

ใช้ GetX Controller เพื่อจัดการ state:

```dart
class UserProfileController extends GetxController {
  final RxBool isFollowing = false.obs;
  final RxInt followerCount = 0.obs;
  final RxList products = [].obs;
  final RxList reviews = [].obs;

  Future<void> loadUserData(String userId) async {
    // Load data from API
  }

  Future<void> toggleFollow() async {
    // Follow/Unfollow logic
  }

  Future<void> sendMessage() async {
    // Navigate to chat
  }
}
```

### 4. ฟีเจอร์เพิ่มเติม

- **Pagination**: โหลดสินค้าและรีวิวทีละหน้า
- **Filter/Sort**: กรองและเรียงลำดับสินค้า
- **Search**: ค้นหาสินค้าในร้านของผู้ขาย
- **Product Categories**: แสดงหมวดหมู่สินค้า
- **Shop Hours**: แสดงเวลาทำการ
- **Response Rate**: แสดงอัตราการตอบกลับ
- **Share Profile**: แชร์โปรไฟล์ผู้ขาย

## 📊 Data Structure

### User Profile Model (ตัวอย่าง)

```dart
class UserProfile {
  final String id;
  final String name;
  final String? profileImage;
  final String location;
  final bool isVerified;
  final int productCount;
  final double rating;
  final int followerCount;
  final int followingCount;
  final bool isFollowing;

  UserProfile({
    required this.id,
    required this.name,
    this.profileImage,
    required this.location,
    this.isVerified = false,
    this.productCount = 0,
    this.rating = 0.0,
    this.followerCount = 0,
    this.followingCount = 0,
    this.isFollowing = false,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      profileImage: json['profileImage'],
      location: json['location'],
      isVerified: json['isVerified'] ?? false,
      productCount: json['productCount'] ?? 0,
      rating: json['rating']?.toDouble() ?? 0.0,
      followerCount: json['followerCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      isFollowing: json['isFollowing'] ?? false,
    );
  }
}
```

## 🎨 UI Components Used

- `CustomAppBar` - AppBar แบบกำหนดเอง
- `CircularImage` - รูปภาพแบบวงกลม
- `SectionHeading` - หัวข้อแต่ละส่วน
- `UserReviewCard` - Card แสดงรีวิว
- `ProductCardVertical` - Card แสดงสินค้า
- `GridLayout` - Layout แบบ Grid

## 📱 Screenshots (Conceptual)

```
┌──────────────────────────────┐
│  ← Seller Profile            │
├──────────────────────────────┤
│  ┌────────────────────────┐  │
│  │  ┌─────┐               │  │
│  │  │ IMG │  Setsiri Aun  │  │
│  │  └─────┘  ✓ Verified   │  │
│  │           📍 Bangkok    │  │
│  │                         │  │
│  │  📦 24   ⭐ 4.5  👥 1.2K│  │
│  │                         │  │
│  │  [Message]  [Follow]    │  │
│  └────────────────────────┘  │
│                              │
│  Reviews              See All│
│  ┌────────────────────────┐  │
│  │ Review Card 1          │  │
│  └────────────────────────┘  │
│                              │
│  Products for Sale           │
│  ┌─────┐  ┌─────┐           │
│  │ IMG │  │ IMG │           │
│  └─────┘  └─────┘           │
│  ┌─────┐  ┌─────┐           │
│  │ IMG │  │ IMG │           │
│  └─────┘  └─────┘           │
└──────────────────────────────┘
```

## 🔗 Related Files

- `lib/features/shop/screens/product_reviews/product_reviews.dart` - ใช้เป็นแนวทางในการแสดง Reviews
- `lib/features/shop/screens/product_reviews/widgets/user_review_card.dart` - Widget แสดงรีวิว
- `lib/common/widgets/products/product_cards/product_card_vertical.dart` - Widget แสดงสินค้า
- `lib/common/widgets/layouts/grid_layout.dart` - Layout แบบ Grid

## 📝 Notes

- ตอนนี้ยังใช้ข้อมูล **Mock Data** (ข้อมูลทดสอบ)
- ควรแก้ไขให้ใช้ข้อมูลจริงจาก Backend ในอนาคต
- ปุ่ม Message และ Follow ยังไม่ได้เชื่อมต่อกับ Backend
- Reviews แสดงเพียง 1 รายการเท่านั้น ส่วนที่เหลือต้องกด "See All"
