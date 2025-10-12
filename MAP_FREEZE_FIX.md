# แก้ไขปัญหาหน้า Map ค้าง / Loading นานเกินไป

## ปัญหาที่พบ

- หน้าแผนที่แสดง loading indicator (หมุน) แล้วค้างไม่หาย
- ไม่สามารถใช้งานแผนที่ได้

## สาเหตุของปัญหา

### 1. ไม่มี Timeout

- การรอ `_controller.future` อาจค้างถ้า GoogleMap ไม่ได้ถูกสร้าง
- การเรียก API หรือ Mock data อาจค้างไม่มีการจำกัดเวลา
- การรอ `await` หลายอย่างต่อเนื่องทำให้ค้างได้ง่าย

### 2. Error Handling ไม่เพียงพอ

- ถ้า `loadNearbyVendors()` มี error จะไม่ทำให้ loading หาย
- ไม่มีการ catch error จาก async operations

### 3. การเรียก API แบบ Blocking

- ใช้ `await` ทุกอย่างทำให้ต้องรอให้เสร็จก่อนถึงจะไปขั้นตอนต่อไป

## การแก้ไข

### 1. เพิ่ม Timeout ในทุก Async Operations

#### product_map.dart

```dart
// เพิ่ม timeout สำหรับ getCurrentPosition
final position = await Geolocator.getCurrentPosition(
  locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.high,
  ),
).timeout(
  const Duration(seconds: 10),
  onTimeout: () {
    throw Exception('Location request timeout');
  },
);

// เพิ่ม timeout สำหรับ _controller.future
final controller = await _controller.future.timeout(
  const Duration(seconds: 5),
);
```

#### vendor_repository.dart

```dart
// เพิ่ม timeout สำหรับ HTTP requests
final response = await THttpHelper.get(
  'vendors/nearby?lat=$latitude&lng=$longitude&radius=$radiusKm',
).timeout(
  const Duration(seconds: 10),
  onTimeout: () => throw Exception('Request timeout'),
);
```

#### product_map_controller.dart

```dart
// เพิ่ม timeout สำหรับ loadNearbyVendors
vendors.value = await _vendorRepository
    .getNearbyVendors(
      latitude: latitude,
      longitude: longitude,
      radiusKm: 10.0,
    )
    .timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw Exception('การโหลดข้อมูลใช้เวลานานเกินไป');
      },
    );
```

### 2. ปรับปรุง Error Handling

```dart
try {
  // ... code
} catch (e) {
  setState(() => _isLoading = false); // ⚠️ สำคัญ: ต้องปิด loading
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}
```

### 3. เปลี่ยนจาก Blocking เป็น Non-blocking

#### ก่อนแก้ไข (Blocking):

```dart
setState(() {
  _currentPosition = position;
  _isLoading = false;
});

// รอให้โหลดเสร็จก่อน -> ถ้าค้างจะไม่ไปต่อ
await _mapController.loadNearbyVendors(
  position.latitude,
  position.longitude,
);

// ต้องรอให้ขั้นตอนข้างบนเสร็จก่อน
final GoogleMapController controller = await _controller.future;
```

#### หลังแก้ไข (Non-blocking):

```dart
setState(() {
  _currentPosition = position;
  _isLoading = false; // ✅ ปิด loading ทันที
});

// ไม่ await -> ทำงานใน background
_mapController.loadNearbyVendors(
  position.latitude,
  position.longitude,
).catchError((error) {
  debugPrint('Error loading vendors: $error');
});

// ทำต่อได้เลย ไม่ต้องรอ
_moveToLocation(position.latitude, position.longitude);
```

### 4. เพิ่ม dispose() Method

```dart
@override
void dispose() {
  // ปิด controller เมื่อออกจากหน้า
  _controller.future.then((controller) => controller.dispose());
  super.dispose();
}
```

### 5. แยก Method สำหรับ Move Camera

```dart
Future<void> _moveToLocation(double latitude, double longitude) async {
  try {
    final controller = await _controller.future.timeout(
      const Duration(seconds: 5),
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15.0,
        ),
      ),
    );
  } catch (e) {
    debugPrint('Error moving camera: $e');
    // ไม่แสดง error ให้ user เพราะไม่สำคัญมาก
  }
}
```

### 6. เพิ่ม Fallback Values

```dart
try {
  vendors.value = await _vendorRepository.getNearbyVendors(...);
  _createMarkers();
} catch (e) {
  Get.snackbar('ข้อผิดพลาด', 'ไม่สามารถโหลดข้อมูลพ่อค้าได้: $e');
  vendors.value = []; // ✅ ตั้งค่าเป็น list ว่างแทนที่จะค้าง
} finally {
  isLoadingVendors.value = false; // ✅ ปิด loading เสมอ
}
```

## สรุปการเปลี่ยนแปลง

### ไฟล์ที่แก้ไข:

1. **product_map.dart**

   - เพิ่ม timeout ทุก async operation
   - แยก `_moveToLocation()` method
   - เปลี่ยนจาก `await loadNearbyVendors()` เป็น fire-and-forget
   - เพิ่ม `dispose()` method
   - แก้ไข class name จาก `MapSampleState` เป็น `_ProductMapScreenState`

2. **vendor_repository.dart**

   - เพิ่ม timeout 10 วินาทีสำหรับ API calls
   - เพิ่ม timeout handler

3. **product_map_controller.dart**
   - เพิ่ม timeout 15 วินาทีสำหรับ loadNearbyVendors()
   - เพิ่ม timeout 15 วินาทีสำหรับ loadVendorProducts()
   - เพิ่ม fallback value (empty list) เมื่อ error
   - เพิ่ม duration สำหรับ snackbar

## การทดสอบ

1. ✅ เปิดหน้าแผนที่ -> ควรเห็นแผนที่ภายใน 2-3 วินาที
2. ✅ ถ้า location timeout -> แสดง error และปิด loading
3. ✅ ถ้าโหลด vendors ล้มเหลว -> แสดงแผนที่ว่างๆ (ไม่มีหมุด)
4. ✅ กดหมุด -> แสดง bottom sheet ภายใน 1 วินาที
5. ✅ ถ้าโหลดสินค้าล้มเหลว -> แสดง "ยังไม่มีสินค้า"

## Best Practices ที่นำมาใช้

1. **Always use timeout for async operations**

   ```dart
   await someAsyncFunction().timeout(Duration(seconds: 10));
   ```

2. **Always handle errors gracefully**

   ```dart
   try {
     // code
   } catch (e) {
     // handle error
   } finally {
     // cleanup (e.g., stop loading)
   }
   ```

3. **Don't block UI with await**

   - ถ้าไม่จำเป็นต้องรอ ให้ใช้ fire-and-forget

   ```dart
   someAsyncFunction().catchError((e) => print(e));
   ```

4. **Always check mounted before setState**

   ```dart
   if (mounted) {
     setState(() { ... });
   }
   ```

5. **Provide fallback values**

   ```dart
   catch (e) {
     myList.value = []; // empty list instead of null
   }
   ```

6. **Clean up resources in dispose()**
   ```dart
   @override
   void dispose() {
     controller.dispose();
     super.dispose();
   }
   ```

## สิ่งที่ควรทำต่อ

- [ ] เพิ่ม retry mechanism สำหรับ failed requests
- [ ] เพิ่ม offline mode detection
- [ ] เพิ่ม skeleton loading แทน circular progress
- [ ] เพิ่ม cache สำหรับ vendors data
- [ ] เพิ่ม pull-to-refresh
