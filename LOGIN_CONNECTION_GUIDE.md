# คู่มือเชื่อมต่อ Login ระหว่าง Flutter และ Backend

## 🎯 สิ่งที่ได้ทำเสร็จแล้ว

### 1. ไฟล์ที่สร้างขึ้นใหม่ (Flutter Client)

#### API & Configuration

- **`lib/utils/constants/api_constants.dart`** - การตั้งค่า API endpoints และ base URL
- **`lib/data/services/api/api_service.dart`** - Service สำหรับเรียก HTTP requests
- **`lib/data/repositories/authentication_repository.dart`** - Repository จัดการ authentication logic

#### Models

- **`lib/features/authentication/models/auth_models.dart`** - Models สำหรับ Login/Register (Request/Response)

#### Controllers

- **`lib/features/authentication/controllers/login_controller.dart`** - Controller จัดการ login logic

#### UI Utilities

- **`lib/utils/popups/loaders.dart`** - Snackbar และ toast notifications
- **`lib/utils/popups/full_screen_loader.dart`** - Full screen loading dialog
- **`lib/common/widgets/loaders/animation_loader.dart`** - Loading animation widget

#### Updated Files

- **`lib/features/authentication/screens/login/widgets/login_form.dart`** - เชื่อมต่อกับ LoginController

---

## 🚀 วิธีการใช้งาน

### 1. การตั้งค่า Backend URL

แก้ไขไฟล์ **`lib/utils/constants/api_constants.dart`**:

```dart
class ApiConstants {
  // เลือก URL ที่เหมาะสมกับการใช้งานของคุณ

  // สำหรับ Android Emulator
  static const String baseUrl = 'http://10.0.2.2:8000';

  // สำหรับ iOS Simulator
  // static const String baseUrl = 'http://localhost:8000';

  // สำหรับ Device จริง (เปลี่ยนเป็น IP ของคอมพิวเตอร์ที่รัน Backend)
  // static const String baseUrl = 'http://192.168.1.100:8000';

  // สำหรับ Production
  // static const String baseUrl = 'https://your-domain.com';
}
```

### 2. การรัน Backend

ในโฟลเดอร์ `haybuy-backend`:

```bash
# ติดตั้ง dependencies (ถ้ายังไม่ได้ติดตั้ง)
pip install -r requirements.txt

# รัน Backend
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

หรือใช้ Docker:

```bash
docker-compose up
```

### 3. การรัน Flutter App

ในโฟลเดอร์ `haybuy-client`:

```bash
# ติดตั้ง dependencies
flutter pub get

# รันแอพ
flutter run
```

---

## 🧪 การทดสอบ Login

### 1. สร้างผู้ใช้ทดสอบ

ใช้ Postman หรือ curl เพื่อสร้างผู้ใช้:

```bash
curl -X POST "http://localhost:8000/api/v1/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "testpass123",
    "full_name": "Test User",
    "email": "test@example.com"
  }'
```

### 2. ทดสอบ Login ใน Flutter

1. เปิดแอพ Flutter
2. ไปที่หน้า Login
3. กรอกข้อมูล:
   - **Username**: `testuser`
   - **Password**: `testpass123`
4. กดปุ่ม "เข้าสู่ระบบ"

### 3. ผลลัพธ์ที่คาดหวัง

✅ **เมื่อ Login สำเร็จ:**

- แสดง Loading Dialog
- แสดง Success Snackbar สีเขียว
- นำไปหน้า NavigationMenu (Home)
- Token ถูกบันทึกใน Local Storage

❌ **เมื่อ Login ไม่สำเร็จ:**

- แสดง Error Snackbar สีแดง พร้อมข้อความ:
  - "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง" (เมื่อข้อมูลไม่ถูกต้อง)
  - "กรุณากรอกข้อมูลให้ครบถ้วน" (เมื่อช่องว่าง)
  - "ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้" (เมื่อเซิร์ฟเวอร์ปิด)

---

## 📦 Backend API Endpoints ที่ใช้

### Login Endpoint

```
POST /api/v1/auth/login
Content-Type: application/json

Body:
{
  "username": "testuser",
  "password": "testpass123"
}

Response (Success):
{
  "access_token": "eyJhbGc...",
  "token_type": "bearer"
}

Response (Error):
{
  "detail": "Invalid username or password"
}
```

### Register Endpoint

```
POST /api/v1/auth/register
Content-Type: application/json

Body:
{
  "username": "testuser",
  "password": "testpass123",
  "full_name": "Test User",
  "email": "test@example.com"
}

Response (Success):
{
  "id": 1,
  "username": "testuser",
  "full_name": "Test User",
  "email": "test@example.com",
  "is_active": true,
  "created_at": "2025-10-12T...",
  "updated_at": "2025-10-12T..."
}
```

---

## 🔐 การจัดการ Authentication Token

Token จะถูกบันทึกอotomatically โดย `AuthenticationRepository`:

```dart
// เช็คว่า user login แล้วหรือยัง
final authRepo = AuthenticationRepository();
bool isLoggedIn = authRepo.isAuthenticated();

// ดึง token
String? token = authRepo.getToken();

// เพิ่ม Authorization header สำหรับ API calls
Map<String, String> headers = authRepo.getAuthHeader();
// Result: {'Authorization': 'Bearer eyJhbGc...'}

// Logout
await authRepo.logout();
```

---

## 🔧 การใช้งานเพิ่มเติม

### เพิ่ม Authorization Header ใน API Calls อื่น ๆ

```dart
final authRepo = AuthenticationRepository();
final apiService = ApiService();

// เรียก API ที่ต้องการ Authentication
final response = await apiService.get(
  '/api/v1/users/profile',
  headers: authRepo.getAuthHeader(),
);
```

### Remember Me Feature

Login Controller มีฟีเจอร์ Remember Me ที่จะบันทึก username และ password:

```dart
// ใน login_form.dart มี checkbox สำหรับ Remember Me
Obx(() => Checkbox(
  value: controller.rememberMe.value,
  onChanged: (value) => controller.rememberMe.value = value ?? false,
))
```

---

## 🐛 การ Debug

### 1. ดู Logs

```dart
// Logger ถูกเปิดใช้งานอยู่แล้วใน:
// - ApiService
// - AuthenticationRepository
// - LoginController

// ดู logs ใน Console/Debug Console
```

### 2. ปัญหาที่พบบ่อย

#### ❌ "ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้"

- ตรวจสอบว่า Backend รันอยู่หรือไม่
- ตรวจสอบ `api_constants.dart` ว่า baseUrl ถูกต้อง
- ถ้าใช้ Android Emulator ต้องใช้ `http://10.0.2.2:8000`
- ถ้าใช้ Device จริง ต้องใช้ IP ของคอมพิวเตอร์

#### ❌ "Invalid username or password"

- ตรวจสอบว่าสร้าง user ใน database แล้ว
- ตรวจสอบว่า username และ password ถูกต้อง
- Username คือ field สำหรับ username ไม่ใช่ email

#### ❌ CORS Error

- ตรวจสอบการตั้งค่า CORS ใน Backend (`app/main.py`)
- ต้องอนุญาต origins ที่ใช้

---

## ✅ Next Steps

1. **เพิ่ม Register Screen Connection** - เชื่อมต่อหน้า Register เหมือน Login
2. **เพิ่ม Forgot Password** - ทำฟีเจอร์ reset password
3. **เพิ่ม Auto Login** - ตรวจสอบ token เมื่อเปิดแอพ
4. **เพิ่ม Logout** - ทำปุ่ม logout ในหน้า Profile
5. **เพิ่ม Token Refresh** - ต่ออายุ token อัตโนมัติ
6. **Error Handling** - จัดการ error cases เพิ่มเติม

---

## 📝 สรุป

ระบบ Login ได้เชื่อมต่อระหว่าง Flutter และ Backend เรียบร้อยแล้ว!

**ฟีเจอร์ที่พร้อมใช้งาน:**

- ✅ Login with username/password
- ✅ Form validation
- ✅ Loading indicators
- ✅ Success/Error messages
- ✅ Token management
- ✅ Remember Me feature
- ✅ Auto-save credentials

**ทดสอบได้เลยโดย:**

1. รัน Backend
2. สร้างผู้ใช้ทดสอบ
3. รัน Flutter App
4. Login!

มีคำถามเพิ่มเติมหรือต้องการความช่วยเหลือเรื่องอะไร บอกได้เลยครับ! 😊
