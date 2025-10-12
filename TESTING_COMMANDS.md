# คำสั่งทดสอบ API (Testing Commands)

## 🧪 ทดสอบ Backend API ด้วย curl

### 1. สร้างผู้ใช้ใหม่ (Register)

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

**Response (Success):**

```json
{
  "id": 1,
  "username": "testuser",
  "full_name": "Test User",
  "email": "test@example.com",
  "is_active": true,
  "created_at": "2025-10-12T10:30:00",
  "updated_at": "2025-10-12T10:30:00"
}
```

---

### 2. Login (JSON Format)

```bash
curl -X POST "http://localhost:8000/api/v1/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "testpass123"
  }'
```

**Response (Success):**

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

**Response (Error):**

```json
{
  "detail": "Invalid username or password"
}
```

---

### 3. Login (OAuth2 Token Format)

```bash
curl -X POST "http://localhost:8000/api/v1/auth/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=testuser&password=testpass123"
```

**Response (Success):**

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

---

### 4. ทดสอบ Protected Endpoint (ใช้ Token)

```bash
# ดึง User Profile (ตัวอย่าง)
curl -X GET "http://localhost:8000/api/v1/users/me" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN_HERE"
```

---

## 🧪 ทดสอบด้วย Postman

### 1. Register User

**Request:**

- Method: `POST`
- URL: `http://localhost:8000/api/v1/auth/register`
- Headers:
  ```
  Content-Type: application/json
  ```
- Body (JSON):
  ```json
  {
    "username": "postmanuser",
    "password": "postman123",
    "full_name": "Postman User",
    "email": "postman@example.com"
  }
  ```

---

### 2. Login

**Request:**

- Method: `POST`
- URL: `http://localhost:8000/api/v1/auth/login`
- Headers:
  ```
  Content-Type: application/json
  ```
- Body (JSON):
  ```json
  {
    "username": "postmanuser",
    "password": "postman123"
  }
  ```

**Save Token:**

- ใน Tests tab ของ Postman:
  ```javascript
  var jsonData = pm.response.json();
  pm.environment.set("access_token", jsonData.access_token);
  ```

---

### 3. ใช้ Token ใน Request ต่อไป

**Request:**

- Method: `GET`
- URL: `http://localhost:8000/api/v1/users/me`
- Headers:
  ```
  Authorization: Bearer {{access_token}}
  ```

---

## 🐍 ทดสอบด้วย Python

### Install requests library

```bash
pip install requests
```

### Test Script

```python
import requests
import json

# Base URL
BASE_URL = "http://localhost:8000/api/v1"

# 1. Register
def test_register():
    url = f"{BASE_URL}/auth/register"
    data = {
        "username": "pythonuser",
        "password": "python123",
        "full_name": "Python User",
        "email": "python@example.com"
    }

    response = requests.post(url, json=data)
    print("Register Response:")
    print(f"Status Code: {response.status_code}")
    print(json.dumps(response.json(), indent=2))
    return response.json()

# 2. Login
def test_login():
    url = f"{BASE_URL}/auth/login"
    data = {
        "username": "pythonuser",
        "password": "python123"
    }

    response = requests.post(url, json=data)
    print("\nLogin Response:")
    print(f"Status Code: {response.status_code}")
    print(json.dumps(response.json(), indent=2))
    return response.json()

# 3. Test Protected Endpoint
def test_protected_endpoint(token):
    url = f"{BASE_URL}/users/me"
    headers = {
        "Authorization": f"Bearer {token}"
    }

    response = requests.get(url, headers=headers)
    print("\nProtected Endpoint Response:")
    print(f"Status Code: {response.status_code}")
    print(json.dumps(response.json(), indent=2))
    return response.json()

# Run Tests
if __name__ == "__main__":
    try:
        # Test 1: Register
        register_response = test_register()

        # Test 2: Login
        login_response = test_login()
        token = login_response.get("access_token")

        # Test 3: Protected Endpoint
        if token:
            test_protected_endpoint(token)

    except Exception as e:
        print(f"Error: {e}")
```

---

## 🌐 ทดสอบด้วย JavaScript/Node.js

### Test Script

```javascript
const axios = require("axios");

const BASE_URL = "http://localhost:8000/api/v1";

// 1. Register
async function testRegister() {
  try {
    const response = await axios.post(`${BASE_URL}/auth/register`, {
      username: "jsuser",
      password: "js123",
      full_name: "JavaScript User",
      email: "js@example.com",
    });

    console.log("Register Response:");
    console.log("Status:", response.status);
    console.log(JSON.stringify(response.data, null, 2));
    return response.data;
  } catch (error) {
    console.error("Register Error:", error.response?.data || error.message);
  }
}

// 2. Login
async function testLogin() {
  try {
    const response = await axios.post(`${BASE_URL}/auth/login`, {
      username: "jsuser",
      password: "js123",
    });

    console.log("\nLogin Response:");
    console.log("Status:", response.status);
    console.log(JSON.stringify(response.data, null, 2));
    return response.data;
  } catch (error) {
    console.error("Login Error:", error.response?.data || error.message);
  }
}

// 3. Test Protected Endpoint
async function testProtectedEndpoint(token) {
  try {
    const response = await axios.get(`${BASE_URL}/users/me`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });

    console.log("\nProtected Endpoint Response:");
    console.log("Status:", response.status);
    console.log(JSON.stringify(response.data, null, 2));
    return response.data;
  } catch (error) {
    console.error(
      "Protected Endpoint Error:",
      error.response?.data || error.message
    );
  }
}

// Run Tests
(async () => {
  try {
    // Test 1: Register
    await testRegister();

    // Test 2: Login
    const loginData = await testLogin();
    const token = loginData?.access_token;

    // Test 3: Protected Endpoint
    if (token) {
      await testProtectedEndpoint(token);
    }
  } catch (error) {
    console.error("Test Error:", error);
  }
})();
```

---

## 🔍 ตรวจสอบ Backend Logs

### รัน Backend พร้อม Logs

```bash
cd haybuy-backend
uvicorn app.main:app --reload --log-level debug
```

### ดู Logs สำหรับ Request/Response

```
INFO:     127.0.0.1:52345 - "POST /api/v1/auth/login HTTP/1.1" 200 OK
INFO:     Request: POST /api/v1/auth/login
DEBUG:    Body: {"username": "testuser", "password": "testpass123"}
DEBUG:    Response: {"access_token": "...", "token_type": "bearer"}
```

---

## 🐛 การ Debug

### 1. เช็ค Backend ว่ารันอยู่หรือไม่

```bash
curl http://localhost:8000/api/v1/health
```

หรือ

```bash
curl http://localhost:8000/docs
```

---

### 2. ทดสอบ Database Connection

```bash
# เข้าไปใน Backend container (ถ้าใช้ Docker)
docker exec -it <container_name> bash

# หรือรัน Python script
cd haybuy-backend
python -c "from app.db.database import engine; print(engine)"
```

---

### 3. ดู Database Records

```python
# ใน Python shell
from app.db.database import SessionLocal
from app.db.models.Users.User import User

db = SessionLocal()
users = db.query(User).all()

for user in users:
    print(f"ID: {user.id}, Username: {user.username}")
```

---

## 📊 Test Cases ที่ต้องทดสอบ

### ✅ Register Success Cases

- [ ] สร้าง user ใหม่สำเร็จ
- [ ] ได้รับ user object กลับมา
- [ ] Password ถูก hash ก่อนเก็บ

### ❌ Register Error Cases

- [ ] Username ซ้ำ → Error 400 "User already exists"
- [ ] ข้อมูลไม่ครบ → Error 422 Validation Error
- [ ] Email ไม่ valid → Error 422 Validation Error

### ✅ Login Success Cases

- [ ] Login สำเร็จ
- [ ] ได้รับ access_token
- [ ] Token type เป็น "bearer"

### ❌ Login Error Cases

- [ ] Username ผิด → Error 400 "Invalid username or password"
- [ ] Password ผิด → Error 400 "Invalid username or password"
- [ ] ข้อมูลว่าง → Error 422 Validation Error

### ✅ Token Validation Cases

- [ ] ใช้ token เรียก protected endpoint สำเร็จ
- [ ] ได้รับข้อมูล user
- [ ] Token มี expiration time

### ❌ Token Error Cases

- [ ] ไม่มี token → Error 401 Unauthorized
- [ ] Token หมดอายุ → Error 401 Unauthorized
- [ ] Token ไม่ valid → Error 401 Unauthorized

---

## 📝 Quick Test Checklist

```bash
# 1. เช็ค Backend
curl http://localhost:8000/api/v1/health

# 2. Register
curl -X POST "http://localhost:8000/api/v1/auth/register" \
  -H "Content-Type: application/json" \
  -d '{"username":"test1","password":"pass123","full_name":"Test","email":"test@test.com"}'

# 3. Login
curl -X POST "http://localhost:8000/api/v1/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"username":"test1","password":"pass123"}'

# 4. ทดสอบใน Flutter App
# - เปิดแอพ
# - ไปหน้า Login
# - กรอก: username="test1", password="pass123"
# - กด Sign In
# - ตรวจสอบว่า Login สำเร็จ
```

---

## 🎯 Expected Results

### Success Flow

```
1. User กรอกข้อมูล
2. แสดง Loading Dialog
3. เรียก API
4. ได้รับ Token
5. บันทึก Token
6. ปิด Loading Dialog
7. แสดง Success Message
8. ไปหน้า Home
```

### Error Flow

```
1. User กรอกข้อมูลผิด
2. แสดง Loading Dialog
3. เรียก API
4. ได้รับ Error
5. ปิด Loading Dialog
6. แสดง Error Message
7. อยู่หน้า Login
```

---

มีคำถามหรือพบปัญหาในการทดสอบ สามารถถามได้เลยครับ! 😊
