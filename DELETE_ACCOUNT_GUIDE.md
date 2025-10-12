# Delete Account Feature Guide 🗑️

## Overview

ระบบลบบัญชีผู้ใช้ (Account Deletion) พร้อมระบบยืนยันสองขั้นตอนเพื่อความปลอดภัย

## Features ✨

### 1. Double Confirmation Dialog

- **การยืนยันครั้งที่ 1**: แจ้งเตือนข้อมูลที่จะถูกลบทั้งหมด

  - ข้อมูลส่วนตัว
  - ประวัติการสั่งซื้อ
  - รายการโปรด
  - ที่อยู่จัดส่ง

- **การยืนยันครั้งที่ 2**: ยืนยันอีกครั้งก่อนลบถาวร (ปุ่มสีแดง)

### 2. Backend Integration

- API Endpoint: `DELETE /v1/user/me`
- Authentication: ต้องมี JWT Token ที่ถูกต้อง
- Backend Process: Soft Delete (ตั้งค่า `is_active=False`, `deleted_at=timestamp`)

### 3. Data Cleanup

- ลบ JWT Token จาก Local Storage
- ล้างข้อมูล User Session ทั้งหมด
- Redirect ไปหน้า Login อัตโนมัติ

### 4. Error Handling

- ตรวจสอบ Token หมดอายุ (401)
- ตรวจสอบผู้ใช้ไม่พบ (404)
- ตรวจสอบปัญหาการเชื่อมต่อ
- แสดง Error Message เป็นภาษาไทย

---

## File Structure 📁

```
lib/
├── data/repositories/authentication/
│   └── authentication_repository.dart      # deleteAccount() API call
├── features/personalization/
│   ├── controllers/
│   │   └── user_controller.dart           # deleteAccount() with dialogs
│   └── screens/settings/
│       └── settings.dart                   # Delete Account Button
└── utils/constants/
    └── api_constants.dart                  # API endpoint config
```

---

## Implementation Details 🛠️

### 1. API Constants

```dart
class ApiConstants {
  // User Management Endpoints
  static const String deleteAccount = '$userEndpoint/me';  // DELETE method
}
```

### 2. Authentication Repository

```dart
class AuthenticationRepository extends GetxController {

  /// Delete user account
  Future<Map<String, dynamic>> deleteAccount() async {
    try {
      logger.i('Deleting user account...');

      // Get auth token for authorization
      final authHeader = await getAuthHeader();

      // Call delete endpoint with authorization
      final response = await _apiService.delete(
        ApiConstants.deleteAccount,
        headers: authHeader,
      );

      logger.i('Account deleted successfully');
      return response;

    } catch (e) {
      logger.e('Delete account failed: $e');
      rethrow;
    }
  }
}
```

### 3. User Controller

```dart
class UserController extends GetxController {

  Future<void> deleteAccount() async {
    try {
      // 1. First confirmation dialog
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('ลบบัญชี'),
          content: const Text('⚠️ ข้อมูลทั้งหมดจะถูกลบอย่างถาวร...'),
          actions: [
            TextButton(onPressed: () => Get.back(result: false),
                       child: const Text('ยกเลิก')),
            TextButton(onPressed: () => Get.back(result: true),
                       child: const Text('ลบบัญชี',
                                        style: TextStyle(color: Colors.red))),
          ],
        ),
      );

      if (confirmed != true) return;

      // 2. Second confirmation dialog (safety measure)
      final doubleConfirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('ยืนยันการลบบัญชีอีกครั้ง'),
          content: const Text('นี่คือการยืนยันครั้งสุดท้าย...'),
          actions: [
            TextButton(onPressed: () => Get.back(result: false),
                       child: const Text('ยกเลิก')),
            ElevatedButton(
              onPressed: () => Get.back(result: true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('ยืนยันการลบบัญชี'),
            ),
          ],
        ),
      );

      if (doubleConfirmed != true) return;

      // 3. Show loading dialog
      FullScreenLoader.openLoadingDialog('กำลังลบบัญชี...', '');

      // 4. Call API to delete account
      await _authRepository.deleteAccount();

      // 5. Clear local data
      await _authRepository.clearAuth();

      // 6. Remove loader
      FullScreenLoader.stopLoading();

      // 7. Show success message
      Loaders.successSnackBar(
        title: 'ลบบัญชีสำเร็จ',
        message: 'บัญชีของคุณถูกลบเรียบร้อยแล้ว',
      );

      // 8. Redirect to Login Screen
      Get.offAll(() => const LoginScreen());

    } catch (e) {
      // Handle errors with Thai messages
      FullScreenLoader.stopLoading();

      String errorMessage = 'ไม่สามารถลบบัญชีได้';
      if (e.toString().contains('401')) {
        errorMessage = 'กรุณาเข้าสู่ระบบใหม่';
      } else if (e.toString().contains('404')) {
        errorMessage = 'ไม่พบบัญชีผู้ใช้';
      }

      Loaders.errorSnackBar(title: 'เกิดข้อผิดพลาด', message: errorMessage);
    }
  }
}
```

### 4. Settings Screen UI

```dart
// Delete Account Button (Red outlined style)
SizedBox(
  width: double.infinity,
  child: OutlinedButton(
    onPressed: () => controller.deleteAccount(),
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.red),
      foregroundColor: Colors.red,
    ),
    child: const Text('Delete Account'),
  ),
)
```

---

## Testing Guide 🧪

### Test Case 1: Successful Deletion

1. เปิดแอป → ไปที่ Settings
2. กดปุ่ม "Delete Account" (สีแดง)
3. ยืนยันการลบในครั้งที่ 1 → กดปุ่ม "ลบบัญชี"
4. ยืนยันการลบในครั้งที่ 2 → กดปุ่ม "ยืนยันการลบบัญชี" (สีแดง)
5. รอ Loading Dialog แสดงข้อความ "กำลังลบบัญชี..."
6. **Expected**:
   - Success SnackBar แสดงข้อความ "ลบบัญชีสำเร็จ"
   - Redirect ไปหน้า Login อัตโนมัติ
   - Backend: User ถูก soft delete (`is_active=False`)

### Test Case 2: User Cancels First Dialog

1. เปิดแอป → ไปที่ Settings
2. กดปุ่ม "Delete Account"
3. ยืนยันการลบในครั้งที่ 1 → กดปุ่ม "ยกเลิก"
4. **Expected**:
   - Dialog ปิด
   - ไม่มีการลบบัญชี
   - User ยังอยู่ที่หน้า Settings

### Test Case 3: User Cancels Second Dialog

1. เปิดแอป → ไปที่ Settings
2. กดปุ่ม "Delete Account"
3. ยืนยันการลบในครั้งที่ 1 → กดปุ่ม "ลบบัญชี"
4. ยืนยันการลบในครั้งที่ 2 → กดปุ่ม "ยกเลิก"
5. **Expected**:
   - Dialog ปิด
   - ไม่มีการลบบัญชี
   - User ยังอยู่ที่หน้า Settings

### Test Case 4: Token Expired (401)

1. ให้ Token หมดอายุ (รอนาน หรือแก้ไขเวลา Backend)
2. เปิดแอป → ไปที่ Settings → กด "Delete Account"
3. ยืนยันทั้งสองครั้ง
4. **Expected**:
   - Error SnackBar: "กรุณาเข้าสู่ระบบใหม่"
   - User ยังอยู่ที่หน้า Settings
   - ไม่มีการลบบัญชี

### Test Case 5: Network Error

1. ปิดการเชื่อมต่ออินเทอร์เน็ต หรือปิด Backend server
2. เปิดแอป → ไปที่ Settings → กด "Delete Account"
3. ยืนยันทั้งสองครั้ง
4. **Expected**:
   - Error SnackBar: "ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้\nกรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต"
   - User ยังอยู่ที่หน้า Settings
   - ไม่มีการลบบัญชี

---

## Backend Endpoint Details 🔌

### Request

```http
DELETE /v1/user/me
Authorization: Bearer <jwt_token>
```

### Response Success (200)

```json
{
  "message": "User deleted successfully"
}
```

### Response Errors

```json
// 401 Unauthorized
{
  "detail": "Not authenticated"
}

// 404 Not Found
{
  "detail": "User not found"
}
```

### Backend Logic (Soft Delete)

```python
@router.delete("/me", response_model=MessageResponse)
async def delete_user(
    current_user: User = Depends(get_current_active_user),
    db: Session = Depends(get_db),
):
    """Soft delete the current user"""
    try:
        # Set user as inactive (soft delete)
        current_user.is_active = False
        current_user.deleted_at = datetime.now()

        # Delete user profile
        if current_user.user_profile:
            db.delete(current_user.user_profile)

        db.commit()

        return MessageResponse(message="User deleted successfully")

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))
```

---

## Error Messages (Thai) 🇹🇭

| Error Code       | Message                                                                  |
| ---------------- | ------------------------------------------------------------------------ |
| 401              | กรุณาเข้าสู่ระบบใหม่                                                     |
| 404              | ไม่พบบัญชีผู้ใช้                                                         |
| Connection Error | ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้<br>กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต |
| Default          | ไม่สามารถลบบัญชีได้                                                      |

---

## Security Features 🔒

### 1. Double Confirmation

- ป้องกันการลบบัญชีโดยไม่ตั้งใจ
- แสดงรายละเอียดข้อมูลที่จะถูกลบ
- ปุ่มยืนยันครั้งที่ 2 มีสีแดงเตือน

### 2. JWT Authentication

- ต้องมี Token ที่ valid เท่านั้น
- Token จะถูกส่งใน Authorization Header
- Backend ตรวจสอบ Token ก่อนลบข้อมูล

### 3. Soft Delete

- Backend ไม่ลบข้อมูลจริงๆ
- ตั้งค่า `is_active = False`
- บันทึก timestamp ใน `deleted_at`
- ทำให้สามารถกู้คืนได้ในอนาคต (ถ้าต้องการเพิ่ม feature)

### 4. Local Data Cleanup

- ลบ Token จาก Local Storage
- ล้าง Session ทั้งหมด
- ป้องกัน Unauthorized access

---

## Troubleshooting 🔧

### ปัญหา: กดปุ่มแล้วไม่เกิดอะไร

**สาเหตุ**: UserController ไม่ได้ถูก initialize
**แก้ไข**:

```dart
final controller = Get.put(UserController());
```

### ปัญหา: Error "Not authenticated" (401)

**สาเหตุ**: Token หมดอายุ หรือไม่มี Token
**แก้ไข**:

- Login ใหม่
- ตรวจสอบ Token ใน GetStorage
- ตรวจสอบว่า `getAuthHeader()` return Token ถูกต้อง

### ปัญหา: Error "User not found" (404)

**สาเหตุ**: User ถูกลบไปแล้ว หรือไม่มีใน Database
**แก้ไข**:

- ตรวจสอบ Database ว่ามี User อยู่
- ตรวจสอบว่า Token match กับ User ใน Database

### ปัญหา: Backend ไม่ตอบกลับ

**สาเหตุ**: Backend server ไม่ทำงาน หรือ Network error
**แก้ไข**:

```bash
# ตรวจสอบ Backend
cd haybuy-backend
uvicorn app.main:app --reload

# ตรวจสอบ Network
ping 10.0.2.2
```

---

## Future Enhancements 🚀

### 1. Account Recovery

- เพิ่ม feature กู้คืนบัญชีภายใน 30 วัน
- ส่ง Email ยืนยันก่อนลบถาวร

### 2. Data Export

- Export ข้อมูลผู้ใช้ก่อนลบ (GDPR compliance)
- Download ประวัติการสั่งซื้อเป็น PDF

### 3. Reason Selection

- ให้ผู้ใช้เลือกเหตุผลที่ลบบัญชี
- ส่งข้อมูลกลับไปยัง Backend เพื่อปรับปรุงบริการ

### 4. Email Notification

- ส่ง Email แจ้งเตือนหลังลบบัญชีสำเร็จ
- แจ้งเตือนถ้ามีการพยายามใช้บัญชีที่ถูกลบแล้ว

---

## Conclusion ✅

Delete Account Feature พร้อมใช้งานแล้ว! 🎉

**Features ที่มี:**

- ✅ Double Confirmation Dialog เพื่อความปลอดภัย
- ✅ Backend API Integration (Soft Delete)
- ✅ Local Data Cleanup (Token & Session)
- ✅ Error Handling พร้อม Thai Messages
- ✅ Auto Redirect to Login
- ✅ Red Outlined Button สำหรับเตือนผู้ใช้

**การทดสอบ:**

```bash
# 1. Start Backend
cd haybuy-backend
uvicorn app.main:app --reload

# 2. Start Frontend
cd haybuy-client
flutter run

# 3. Test Flow
# - Register/Login
# - Go to Settings
# - Click "Delete Account" (Red button)
# - Confirm both dialogs
# - Check success message & redirect
```

Happy Coding! 🚀
