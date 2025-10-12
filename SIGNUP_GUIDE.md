# 📝 คู่มือ Signup (Register) - เชื่อมต่อกับ Backend

## ✅ สิ่งที่ทำเสร็จแล้ว

### 1. ไฟล์ที่สร้าง/แก้ไข

#### Controllers

- **`lib/features/authentication/controllers/signup_controller.dart`** ✅ สร้างใหม่
  - จัดการ signup logic
  - Form validation
  - Error handling
  - เชื่อมกับ AuthenticationRepository

#### UI Components (Updated)

- **`lib/features/authentication/screens/signup/widgets/signup_form.dart`** ✅ อัพเดท
  - เชื่อมกับ SignupController
  - เพิ่ม validation
  - Password visibility toggle
- **`lib/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart`** ✅ อัพเดท
  - เชื่อมกับ controller
  - จัดการ checkbox state

---

## 🎯 ฟีเจอร์ที่พร้อมใช้งาน

### Form Fields

✅ **First Name** - ชื่อ (required)  
✅ **Last Name** - นามสกุล (required)  
✅ **Username** - ชื่อผู้ใช้ (required, validation)  
✅ **Email** - อีเมล (required, email validation)  
✅ **Phone Number** - เบอร์โทรศัพท์ (optional - ไม่ได้ส่งไป Backend)  
✅ **Password** - รหัสผ่าน (required, password validation)

### Validations

✅ **Username**: 3-20 ตัวอักษร, a-z, A-Z, 0-9, \_, -  
✅ **Email**: รูปแบบอีเมลที่ถูกต้อง  
✅ **Password**:

- อย่างน้อย 6 ตัวอักษร
- มีตัวพิมพ์ใหญ่อย่างน้อย 1 ตัว
- มีตัวเลขอย่างน้อย 1 ตัว
- มี special character อย่างน้อย 1 ตัว

### Features

✅ Password visibility toggle (แสดง/ซ่อนรหัสผ่าน)  
✅ Terms & Conditions checkbox  
✅ Loading dialog  
✅ Success/Error messages (ภาษาไทย)  
✅ Error handling ครบถ้วน

---

## 🔄 Flow การทำงาน

```
1. User กรอกข้อมูล
   ↓
2. กด "สร้างบัญชี"
   ↓
3. Validate Form
   ↓
4. ตรวจสอบ Terms & Conditions
   ↓
5. แสดง Loading Dialog
   ↓
6. เรียก API POST /v1/auth/register
   ↓
7. Backend สร้าง User
   ↓
8. Return User Response
   ↓
9. แสดง Success Message
   ↓
10. ไปหน้า Verify Email
```

---

## 🧪 การทดสอบ

### 1. ข้อมูลทดสอบที่ถูกต้อง

```
First Name: สมชาย
Last Name: ใจดี
Username: somchai123
Email: somchai@example.com
Phone: 0812345678 (optional)
Password: Pass123!
☑️ ยอมรับข้อกำหนด
```

### 2. ทดสอบ Validation Errors

#### Username ไม่ถูกต้อง

```
Username: ab          ❌ (สั้นเกินไป)
Username: somchai@123 ❌ (มี @ ไม่ได้)
Username: _somchai    ❌ (ขึ้นต้นด้วย _ ไม่ได้)
Username: somchai123  ✅
```

#### Email ไม่ถูกต้อง

```
Email: somchai        ❌ (ไม่มี @)
Email: somchai@       ❌ (ไม่สมบูรณ์)
Email: somchai@test   ❌ (ไม่มี domain)
Email: somchai@test.com ✅
```

#### Password ไม่ถูกต้อง

```
Password: pass        ❌ (สั้นเกินไป, ไม่มีตัวพิมพ์ใหญ่, ไม่มีตัวเลข, ไม่มี special char)
Password: password    ❌ (ไม่มีตัวพิมพ์ใหญ่, ไม่มีตัวเลข, ไม่มี special char)
Password: Password    ❌ (ไม่มีตัวเลข, ไม่มี special char)
Password: Password1   ❌ (ไม่มี special char)
Password: Pass123!    ✅
```

### 3. ทดสอบ Terms & Conditions

```
☐ ไม่ tick checkbox → แสดงข้อความเตือน "กรุณายอมรับข้อกำหนดและเงื่อนไขการใช้งาน"
☑️ tick checkbox → ดำเนินการสมัครสมาชิก
```

---

## 📊 Success/Error Cases

### ✅ Success Case

**Input:**

```json
{
  "username": "newuser",
  "password": "Pass123!",
  "full_name": "New User",
  "email": "newuser@example.com"
}
```

**Response:**

```json
{
  "id": 2,
  "username": "newuser",
  "full_name": "New User",
  "email": "newuser@example.com",
  "is_active": true,
  "created_at": "2025-10-12T...",
  "updated_at": "2025-10-12T..."
}
```

**UI:**

- ✅ แสดง Success Snackbar "ยินดีด้วย! สร้างบัญชีสำเร็จแล้ว กรุณาเข้าสู่ระบบ"
- ✅ ไปหน้า Verify Email

### ❌ Error Cases

#### 1. Username ซ้ำ (400)

```
Error Message: "ชื่อผู้ใช้นี้ถูกใช้งานแล้ว กรุณาเลือกชื่อผู้ใช้อื่น"
```

#### 2. ข้อมูลไม่ครบ (422)

```
Error Message: "กรุณากรอกข้อมูลให้ถูกต้องและครบถ้วน"
```

#### 3. ไม่สามารถเชื่อมต่อ (null)

```
Error Message: "ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้
กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต"
```

---

## 🔍 Backend API

### Endpoint

```
POST /v1/auth/register
Content-Type: application/json
```

### Request Body

```json
{
  "username": "string",
  "password": "string",
  "full_name": "string",
  "email": "string"
}
```

### Response (Success - 200)

```json
{
  "id": 1,
  "username": "string",
  "full_name": "string",
  "email": "string",
  "is_active": true,
  "created_at": "2025-10-12T10:30:00",
  "updated_at": "2025-10-12T10:30:00"
}
```

### Response (Error - 400)

```json
{
  "detail": "User already exists"
}
```

---

## 🧪 ทดสอบด้วย curl

```bash
curl -X POST "http://localhost:8000/v1/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser2",
    "password": "Test123!",
    "full_name": "Test User 2",
    "email": "test2@example.com"
  }'
```

---

## 💡 Tips & Notes

### 1. Phone Number ไม่ได้ส่งไป Backend

- ช่อง Phone Number เป็น optional
- Backend ยังไม่รองรับการเก็บเบอร์โทร
- ถ้าต้องการใช้ ต้องเพิ่ม field ใน Backend ก่อน

### 2. Password Requirements

- Password validation ค่อนข้างเข้มงวด
- สามารถปรับเปลี่ยนได้ใน `validation.dart`
- ถ้าต้องการผ่อนปรนให้ comment บางเงื่อนไข

### 3. Full Name

- Backend ใช้ `full_name` field เดียว
- Flutter รวม `firstName + lastName` ก่อนส่ง
- Format: `"ชื่อ นามสกุล"`

### 4. Verify Email Screen

- หลังสมัครสำเร็จจะไปหน้า Verify Email
- ถ้าต้องการไปหน้า Login แทน แก้ใน `signup_controller.dart`

```dart
// แทนที่
Get.to(() => const VerifyEmailScreen());

// ด้วย
Get.offAll(() => const LoginScreen());
```

---

## 🎨 การปรับแต่ง

### เปลี่ยนข้อความ Error

แก้ไขในไฟล์ `signup_controller.dart`:

```dart
if (e.message.toLowerCase().contains('already exists')) {
  errorMessage = 'ข้อความใหม่ที่ต้องการ';
}
```

### เปลี่ยน Validation Rules

แก้ไขในไฟล์ `validation.dart`:

```dart
// ลด password requirement
static String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required.';
  }

  if (value.length < 6) {
    return 'Password must be at least 6 characters long.';
  }

  // ลบเงื่อนไขอื่น ๆ ถ้าต้องการ

  return null;
}
```

### เพิ่ม Phone Number ส่งไป Backend

1. แก้ไข `RegisterRequest` ใน `auth_models.dart`:

```dart
class RegisterRequest {
  final String username;
  final String password;
  final String fullName;
  final String email;
  final String? phoneNumber; // เพิ่ม field

  RegisterRequest({
    required this.username,
    required this.password,
    required this.fullName,
    required this.email,
    this.phoneNumber, // เพิ่ม
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'full_name': fullName,
        'email': email,
        if (phoneNumber != null) 'phone_number': phoneNumber, // เพิ่ม
      };
}
```

2. แก้ไข `signup_controller.dart`:

```dart
final userResponse = await _authRepository.register(
  username: username.text.trim(),
  password: password.text.trim(),
  fullName: fullName,
  email: email.text.trim(),
  phoneNumber: phoneNumber.text.trim(), // เพิ่ม
);
```

3. อัพเดท Backend ให้รับ `phone_number` field

---

## ✅ Checklist การทดสอบ

- [ ] กรอกข้อมูลครบถ้วน → สมัครสำเร็จ
- [ ] กรอกข้อมูลไม่ครบ → แสดง error
- [ ] Username ซ้ำ → แสดง "ชื่อผู้ใช้นี้ถูกใช้งานแล้ว"
- [ ] Email ไม่ถูกต้อง → แสดง "Invalid email address"
- [ ] Password ไม่ตรงเงื่อนไข → แสดง error ที่เหมาะสม
- [ ] Username สั้นเกินไป → แสดง "Username is not valid"
- [ ] ไม่ tick checkbox → แสดง "กรุณายอมรับข้อกำหนด"
- [ ] Toggle password visibility → ใช้งานได้
- [ ] Backend ปิด → แสดง "ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์"
- [ ] สมัครสำเร็จ → ไปหน้า Verify Email

---

## 🎊 สรุป

**หน้า Signup เชื่อมต่อกับ Backend เรียบร้อยแล้ว!**

### ฟีเจอร์ที่พร้อมใช้:

✅ Form validation ครบถ้วน  
✅ Terms & Conditions checkbox  
✅ Password visibility toggle  
✅ Error handling (ภาษาไทย)  
✅ Loading states  
✅ Success/Error messages  
✅ เชื่อมต่อ Backend API

### การทดสอบ:

1. รัน Backend
2. รัน Flutter App
3. ไปหน้า Signup
4. กรอกข้อมูลและกด "สร้างบัญชี"
5. ตรวจสอบผลลัพธ์

**ขอให้สนุกกับการใช้งาน! 🚀**

---

_Last Updated: October 12, 2025_
