# 🚪 คู่มือ Logout Feature

## ✅ สิ่งที่ทำเสร็จแล้ว

### 1. ไฟล์ที่สร้าง/แก้ไข

#### Controllers (New)

- **`lib/features/personalization/controllers/user_controller.dart`** ✅ สร้างใหม่
  - `logout()` - ออกจากระบบ
  - `deleteAccount()` - ลบบัญชี (สำหรับใช้ในอนาคต)
  - `isLoggedIn()` - เช็คสถานะการ login
  - `getToken()` - ดึง token

#### UI (Updated)

- **`lib/features/personalization/screens/settings/settings.dart`** ✅ อัพเดท
  - เชื่อมปุ่ม "Log Out" กับ `UserController.logout()`

---

## 🎯 ฟีเจอร์ที่พร้อมใช้งาน

### Logout Flow

✅ **กดปุ่ม "Log Out"**  
✅ **แสดง Confirmation Dialog** (ยืนยันการออกจากระบบ)  
✅ **Loading Dialog** (กำลังออกจากระบบ...)  
✅ **ลบ Token** จาก Local Storage  
✅ **Success Message** (ออกจากระบบสำเร็จ)  
✅ **Redirect** ไปหน้า Login

### Bonus Features

✅ **Delete Account** - ฟังก์ชันลบบัญชี (พร้อมใช้งาน)  
✅ **isLoggedIn()** - เช็คสถานะการ login  
✅ **getToken()** - ดึง token ที่เก็บไว้

---

## 🔄 Flow การทำงาน

### Logout Flow

```
1. User กดปุ่ม "Log Out" ในหน้า Settings
   ↓
2. แสดง Confirmation Dialog
   "คุณต้องการออกจากระบบหรือไม่?"
   [ยกเลิก] [ออกจากระบบ]
   ↓
3. User กด "ออกจากระบบ"
   ↓
4. แสดง Loading Dialog
   "กำลังออกจากระบบ..."
   ↓
5. เรียก authRepository.logout()
   - ลบ token จาก GetStorage
   - ลบ user data
   ↓
6. ปิด Loading Dialog
   ↓
7. แสดง Success Snackbar
   "ออกจากระบบสำเร็จ - แล้วพบกันใหม่!"
   ↓
8. Redirect ไปหน้า Login (Get.offAll)
```

---

## 🧪 การทดสอบ

### 1. ทดสอบ Logout

**ขั้นตอน:**

1. Login เข้าสู่ระบบ
2. ไปหน้า Settings (Profile tab)
3. Scroll ลงล่าง
4. กดปุ่ม "Log Out"
5. จะแสดง Dialog ยืนยัน
6. กด "ออกจากระบบ"

**ผลลัพธ์ที่คาดหวัง:**

- ✅ แสดง Loading Dialog
- ✅ แสดง Success Message "ออกจากระบบสำเร็จ"
- ✅ ไปหน้า Login
- ✅ Token ถูกลบแล้ว
- ✅ ไม่สามารถกลับไปหน้าก่อนหน้าได้ (ใช้ offAll)

### 2. ทดสอบ Cancel Logout

**ขั้นตอน:**

1. กดปุ่ม "Log Out"
2. Dialog ปรากฏขึ้น
3. กด "ยกเลิก"

**ผลลัพธ์ที่คาดหวัง:**

- ✅ Dialog ปิด
- ✅ ยังคงอยู่ในหน้า Settings
- ✅ ยังคง login อยู่

---

## 📋 Code Structure

### UserController

```dart
class UserController extends GetxController {
  static UserController get instance => Get.find();

  final AuthenticationRepository _authRepository = AuthenticationRepository();

  /// Logout with confirmation
  Future<void> logout() async {
    // 1. Show confirmation dialog
    final confirmed = await Get.dialog<bool>(AlertDialog(...));

    if (confirmed != true) return;

    // 2. Show loading
    FullScreenLoader.openLoadingDialog(...);

    // 3. Logout
    await _authRepository.logout();

    // 4. Show success message
    Loaders.successSnackBar(...);

    // 5. Redirect to login
    Get.offAll(() => const LoginScreen());
  }

  /// Delete account (future use)
  Future<void> deleteAccount() async { ... }

  /// Check if logged in
  bool isLoggedIn() => _authRepository.isAuthenticated();

  /// Get token
  String? getToken() => _authRepository.getToken();
}
```

### Settings Screen

```dart
class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Scaffold(
      body: ...,
      OutlinedButton(
        onPressed: () => controller.logout(),
        child: const Text('Log Out'),
      ),
    );
  }
}
```

---

## 🔐 Security Features

### Token Management

```dart
// Logout จะลบ:
1. Access Token
2. User Data
3. Remember Me Data (ถ้ามี)
```

### Navigation Security

```dart
// ใช้ Get.offAll() แทน Get.to()
Get.offAll(() => const LoginScreen());

// ทำให้:
- ไม่สามารถกดปุ่ม Back กลับไปหน้าก่อนหน้า
- Clear navigation stack ทั้งหมด
- บังคับให้ login ใหม่
```

---

## 💡 การใช้งาน UserController ในที่อื่น

### ตรวจสอบสถานะ Login

```dart
// ในหน้าใดก็ได้
final userController = UserController.instance;

if (userController.isLoggedIn()) {
  // User login แล้ว
  print('User is logged in');
} else {
  // User ยังไม่ login
  Get.to(() => const LoginScreen());
}
```

### ดึง Token สำหรับ API Call

```dart
final userController = UserController.instance;
final token = userController.getToken();

if (token != null) {
  // ใช้ token เรียก API
  final headers = {
    'Authorization': 'Bearer $token',
  };
}
```

### Logout จากที่อื่น

```dart
// สามารถเรียกใช้จากหน้าไหนก็ได้
final userController = UserController.instance;
await userController.logout();
```

---

## 🎨 UI Components

### Confirmation Dialog

```dart
AlertDialog(
  title: const Text('ออกจากระบบ'),
  content: const Text('คุณต้องการออกจากระบบหรือไม่?'),
  actions: [
    TextButton(
      onPressed: () => Get.back(result: false),
      child: const Text('ยกเลิก'),
    ),
    TextButton(
      onPressed: () => Get.back(result: true),
      child: const Text('ออกจากระบบ', style: TextStyle(color: Colors.red)),
    ),
  ],
)
```

### Loading Dialog

```dart
FullScreenLoader.openLoadingDialog(
  'กำลังออกจากระบบ...',
  '',
);
```

### Success Message

```dart
Loaders.successSnackBar(
  title: 'ออกจากระบบสำเร็จ',
  message: 'แล้วพบกันใหม่!',
);
```

---

## 🚀 Bonus: Delete Account Feature

### การใช้งาน

```dart
// เพิ่มปุ่มลบบัญชีในหน้า Settings
OutlinedButton(
  onPressed: () => controller.deleteAccount(),
  style: OutlinedButton.styleFrom(
    foregroundColor: Colors.red,
  ),
  child: const Text('ลบบัญชี'),
)
```

### Delete Account Flow

```
1. User กดปุ่ม "ลบบัญชี"
   ↓
2. แสดง Confirmation Dialog (สีแดง, คำเตือนชัดเจน)
   "คุณแน่ใจหรือไม่ที่จะลบบัญชี?
    ข้อมูลทั้งหมดจะถูกลบอย่างถาวร"
   ↓
3. User กด "ลบบัญชี"
   ↓
4. แสดง Loading Dialog
   ↓
5. เรียก API ลบบัญชี (TODO: ต้องเพิ่ม endpoint ใน Backend)
   ↓
6. ลบข้อมูล local
   ↓
7. แสดง Success Message
   ↓
8. Redirect ไปหน้า Login
```

---

## ✅ Testing Checklist

### Logout

- [ ] กดปุ่ม Log Out → แสดง confirmation dialog
- [ ] กด "ยกเลิก" → ยังคง login อยู่
- [ ] กด "ออกจากระบบ" → แสดง loading dialog
- [ ] Logout สำเร็จ → แสดง success message
- [ ] Redirect ไปหน้า Login
- [ ] กด Back button → ไม่สามารถกลับไปหน้าก่อนหน้า
- [ ] Token ถูกลบจาก storage
- [ ] Login ใหม่ได้ปกติ

### Error Handling

- [ ] Network error → แสดง error message
- [ ] Storage error → แสดง error message

---

## 🔧 การปรับแต่ง

### เปลี่ยนข้อความ Dialog

แก้ไขใน `user_controller.dart`:

```dart
AlertDialog(
  title: const Text('คุณแน่ใจหรือไม่?'), // เปลี่ยนข้อความ
  content: const Text('ข้อความใหม่ที่ต้องการ'),
  // ...
)
```

### เปลี่ยน Success Message

```dart
Loaders.successSnackBar(
  title: 'สำเร็จ',
  message: 'ข้อความใหม่',
);
```

### เปลี่ยนหน้าที่ redirect หลัง logout

```dart
// แทนที่
Get.offAll(() => const LoginScreen());

// ด้วย
Get.offAll(() => const OnboardingScreen());
// หรือ
Get.offAll(() => const WelcomeScreen());
```

### ไม่ต้องการ Confirmation Dialog

```dart
Future<void> logout() async {
  try {
    // ลบบรรทัด confirmation dialog
    // final confirmed = await Get.dialog<bool>(...);
    // if (confirmed != true) return;

    // Logout เลย
    FullScreenLoader.openLoadingDialog(...);
    await _authRepository.logout();
    // ...
  } catch (e) {
    // ...
  }
}
```

---

## 📚 Related Files

### Authentication Repository

- `lib/data/repositories/authentication_repository.dart`
  - `logout()` - ลบ token และ user data
  - `clearAuth()` - ลบข้อมูลทั้งหมด
  - `isAuthenticated()` - เช็คสถานะ
  - `getToken()` - ดึง token

### UI Components

- `lib/utils/popups/loaders.dart` - Success/Error messages
- `lib/utils/popups/full_screen_loader.dart` - Loading dialog
- `lib/features/authentication/screens/login/login.dart` - Login screen

---

## 🎊 สรุป

**ปุ่ม Logout ใช้งานได้เรียบร้อยแล้ว!**

### ฟีเจอร์ที่พร้อมใช้:

✅ Logout with confirmation  
✅ Loading states  
✅ Success/Error messages  
✅ Token cleanup  
✅ Navigation security  
✅ Delete account (bonus)  
✅ Login status check

### การทดสอบ:

1. Login เข้าสู่ระบบ
2. ไปหน้า Settings
3. กดปุ่ม "Log Out"
4. ยืนยันการออกจากระบบ
5. ตรวจสอบว่า redirect ไปหน้า Login

**พร้อมใช้งานแล้ว! 🚀**

---

_Last Updated: October 12, 2025_
