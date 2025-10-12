import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/features/shop/screens/user_profile/user_profile_screen.dart';

/// ตัวอย่างการใช้งาน UserProfileScreen
/// 
/// วิธีเรียกใช้จากหน้าอื่น:
/// 
/// 1. ใช้ Get.to() (GetX Navigation):
///    Get.to(() => const UserProfileScreen());
/// 
/// 2. ใช้ Navigator (Standard Flutter):
///    Navigator.push(
///      context,
///      MaterialPageRoute(builder: (context) => const UserProfileScreen()),
///    );
/// 
/// 3. ในอนาคต สามารถส่ง userId เพื่อดึงข้อมูล User นั้นๆ:
///    Get.to(() => UserProfileScreen(userId: 'user123'));

class UserProfileExample extends StatelessWidget {
  const UserProfileExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to User Profile Screen
            Get.to(() => const UserProfileScreen());
          },
          child: const Text('View User Profile'),
        ),
      ),
    );
  }
}

/// หมายเหตุ: Features ที่จะพัฒนาในอนาคต
/// 
/// 1. รับ userId เป็น parameter เพื่อดึงข้อมูลจาก Backend
/// 2. เชื่อมต่อกับ API เพื่อดึงข้อมูล:
///    - ข้อมูล User (ชื่อ, รูปภาพ, location, stats)
///    - Reviews ทั้งหมดของ User
///    - สินค้าทั้งหมดที่ User เปิดขาย
/// 3. เพิ่มฟีเจอร์ Follow/Unfollow
/// 4. เพิ่มฟีเจอร์ส่งข้อความ (Chat)
/// 5. เพิ่มฟีเจอร์ Filter/Sort สินค้า
/// 6. เพิ่ม Pagination สำหรับสินค้าและ Reviews
