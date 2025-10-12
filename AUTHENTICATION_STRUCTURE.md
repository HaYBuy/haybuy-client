# โครงสร้างไฟล์ Authentication System

## 📁 โครงสร้างไฟล์ที่เพิ่มเข้ามา

```
haybuy-client/
└── lib/
    ├── common/
    │   └── widgets/
    │       └── loaders/
    │           └── animation_loader.dart          # Widget สำหรับแสดง loading animation
    │
    ├── data/
    │   ├── repositories/
    │   │   └── authentication_repository.dart     # จัดการ auth logic และ token storage
    │   │
    │   └── services/
    │       └── api/
    │           └── api_service.dart               # HTTP client สำหรับเรียก API
    │
    ├── features/
    │   └── authentication/
    │       ├── controllers/
    │       │   └── login_controller.dart          # Controller สำหรับ login logic
    │       │
    │       ├── models/
    │       │   └── auth_models.dart               # Models (Request/Response)
    │       │
    │       └── screens/
    │           └── login/
    │               └── widgets/
    │                   └── login_form.dart        # Login form (updated)
    │
    └── utils/
        ├── constants/
        │   └── api_constants.dart                 # API endpoints และ configurations
        │
        └── popups/
            ├── full_screen_loader.dart            # Full screen loading dialog
            └── loaders.dart                       # Snackbar notifications
```

---

## 🔗 ความสัมพันธ์ของไฟล์

```
┌─────────────────┐
│  login_form.dart│
└────────┬────────┘
         │ เรียกใช้
         ▼
┌─────────────────────┐
│ login_controller.dart│
└────────┬────────────┘
         │ ใช้
         ▼
┌──────────────────────────┐
│authentication_repository │
└────────┬─────────────────┘
         │ ใช้
         ▼
┌──────────────────┐
│  api_service.dart│
└────────┬─────────┘
         │ เรียก API
         ▼
┌──────────────────┐
│  Backend API     │
└──────────────────┘
```

---

## 📄 คำอธิบายแต่ละไฟล์

### 1. **api_constants.dart**

```dart
// กำหนด constants สำหรับ API
- baseUrl: URL ของ Backend
- endpoints: path ต่าง ๆ เช่น /auth/login, /auth/register
- headers: HTTP headers
- timeout: ระยะเวลา timeout
```

### 2. **auth_models.dart**

```dart
// Models สำหรับ authentication
- LoginRequest: ข้อมูลสำหรับ login
- LoginResponse: response จาก login API
- RegisterRequest: ข้อมูลสำหรับ register
- UserResponse: ข้อมูล user จาก API
```

### 3. **api_service.dart**

```dart
// HTTP client wrapper
- post(): ส่ง POST request
- get(): ส่ง GET request
- put(): ส่ง PUT request
- delete(): ส่ง DELETE request
- รองรับ error handling และ logging
```

### 4. **authentication_repository.dart**

```dart
// จัดการ authentication logic
- login(): เข้าสู่ระบบ
- register(): สมัครสมาชิก
- logout(): ออกจากระบบ
- saveToken(): บันทึก token
- getToken(): ดึง token
- isAuthenticated(): เช็คสถานะการ login
- getAuthHeader(): ดึง Authorization header
```

### 5. **login_controller.dart**

```dart
// Controller สำหรับ login screen
- emailAndPasswordSignIn(): ฟังก์ชัน login
- googleSignIn(): login ด้วย Google (ยังไม่ implement)
- จัดการ form validation
- จัดการ remember me
- แสดง loading และ error messages
```

### 6. **login_form.dart**

```dart
// UI สำหรับ login form
- TextFormField สำหรับ username และ password
- Checkbox สำหรับ Remember Me
- ปุ่ม Sign In และ Create Account
- เชื่อมต่อกับ LoginController
```

### 7. **loaders.dart**

```dart
// Utility สำหรับแสดง notifications
- successSnackBar(): แสดงข้อความสำเร็จ
- errorSnackBar(): แสดงข้อความ error
- warningSnackBar(): แสดงข้อความเตือน
- customToast(): แสดง toast message
```

### 8. **full_screen_loader.dart**

```dart
// Full screen loading dialog
- openLoadingDialog(): เปิด loading dialog
- stopLoading(): ปิด loading dialog
```

### 9. **animation_loader.dart**

```dart
// Widget สำหรับแสดง loading
- แสดง CircularProgressIndicator
- แสดงข้อความ loading
- รองรับ action button
```

---

## 🔄 Flow การทำงาน

### Login Flow

1. **User กรอกข้อมูล** ใน `login_form.dart`

   ```
   Username: testuser
   Password: testpass123
   ```

2. **กดปุ่ม Sign In** → เรียก `controller.emailAndPasswordSignIn()`

3. **LoginController** ทำการ:

   ```dart
   - แสดง Loading Dialog
   - Validate Form
   - บันทึก Remember Me (ถ้าเลือก)
   - เรียก authRepository.login()
   ```

4. **AuthenticationRepository** ทำการ:

   ```dart
   - สร้าง LoginRequest object
   - เรียก apiService.post('/auth/login')
   - บันทึก token ที่ได้รับ
   - return LoginResponse
   ```

5. **ApiService** ทำการ:

   ```dart
   - สร้าง HTTP POST request
   - ส่งไปที่ Backend
   - รับ response
   - แปลง JSON เป็น Map
   - จัดการ errors
   ```

6. **Backend API** ทำการ:

   ```python
   - ตรวจสอบ username และ password
   - สร้าง JWT token
   - ส่ง response กลับมา
   ```

7. **LoginController รับ response**:

   ```dart
   Success:
   - ปิด Loading Dialog
   - แสดง Success Snackbar
   - นำไปหน้า Home

   Error:
   - ปิด Loading Dialog
   - แสดง Error Snackbar
   - แสดงข้อความ error
   ```

---

## 🔐 Token Management

### การบันทึก Token

```dart
// บันทึก token อัตโนมัติหลัง login สำเร็จ
await authRepository.saveToken(token);

// Token ถูกเก็บใน GetStorage
// Key: 'auth_token'
```

### การใช้งาน Token

```dart
// ดึง token
String? token = authRepository.getToken();

// เช็คว่า login แล้วหรือยัง
bool isLoggedIn = authRepository.isAuthenticated();

// ใช้ใน API call
final headers = authRepository.getAuthHeader();
// Result: {'Authorization': 'Bearer eyJhbGc...'}

await apiService.get(
  '/api/v1/protected-endpoint',
  headers: headers,
);
```

### การลบ Token

```dart
// Logout
await authRepository.logout();

// Clear all auth data
await authRepository.clearAuth();
```

---

## 🎨 UI Components

### Loading States

#### Full Screen Loading

```dart
FullScreenLoader.openLoadingDialog(
  'กำลังเข้าสู่ระบบ...',
  '', // animation path (optional)
);

// ปิด loading
FullScreenLoader.stopLoading();
```

#### Success Message

```dart
Loaders.successSnackBar(
  title: 'สำเร็จ',
  message: 'เข้าสู่ระบบสำเร็จ',
  duration: 3, // seconds
);
```

#### Error Message

```dart
Loaders.errorSnackBar(
  title: 'เกิดข้อผิดพลาด',
  message: 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง',
);
```

#### Warning Message

```dart
Loaders.warningSnackBar(
  title: 'คำเตือน',
  message: 'ฟีเจอร์นี้กำลังพัฒนา',
);
```

---

## 🛠️ การปรับแต่ง

### เปลี่ยน Backend URL

```dart
// ไฟล์: lib/utils/constants/api_constants.dart
static const String baseUrl = 'http://your-backend-url:8000';
```

### เปลี่ยน Timeout Duration

```dart
// ไฟล์: lib/utils/constants/api_constants.dart
static const Duration timeout = Duration(seconds: 60);
```

### เพิ่ม Endpoint ใหม่

```dart
// ไฟล์: lib/utils/constants/api_constants.dart
static const String forgotPassword = '$apiVersion/auth/forgot-password';
static const String resetPassword = '$apiVersion/auth/reset-password';
```

### เพิ่ม API Call ใหม่

```dart
// ไฟล์: lib/data/repositories/authentication_repository.dart
Future<void> forgotPassword(String email) async {
  try {
    await _apiService.post(
      ApiConstants.forgotPassword,
      body: {'email': email},
    );
  } catch (e) {
    rethrow;
  }
}
```

---

## 📚 Dependencies ที่ใช้

```yaml
dependencies:
  http: ^1.1.0 # HTTP client
  get: ^4.6.5 # State management & navigation
  get_storage: ^2.1.1 # Local storage
  logger: ^2.6.2 # Logging
```

---

## ✅ Checklist สำหรับการใช้งาน

- [ ] อัพเดท baseUrl ใน `api_constants.dart`
- [ ] รัน Backend (`uvicorn app.main:app --reload`)
- [ ] สร้างผู้ใช้ทดสอบ (via Postman หรือ Backend)
- [ ] รัน Flutter App (`flutter pub get` && `flutter run`)
- [ ] ทดสอบ Login
- [ ] ตรวจสอบ Logs
- [ ] ทดสอบ Error Cases

---

## 🚀 Next Features

- [ ] Auto Login (เช็ค token เมื่อเปิดแอพ)
- [ ] Token Refresh
- [ ] Logout Button
- [ ] Register Screen Connection
- [ ] Forgot Password
- [ ] Profile Management
- [ ] Social Login (Google, Facebook)

---

มีคำถามหรือต้องการความช่วยเหลือเพิ่มเติม สามารถถามได้เลยครับ! 😊
