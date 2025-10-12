import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../controllers/product_map_controller.dart';
import 'widgets/vendor_products_bottom_sheet.dart';

class ProductMapScreen extends StatefulWidget {
  const ProductMapScreen({super.key});

  @override
  State<ProductMapScreen> createState() => _ProductMapScreenState();
}

class _ProductMapScreenState extends State<ProductMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late final ProductMapController _mapController;

  Position? _currentPosition;

  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(13.7563, 100.5018), // Bangkok as default
    zoom: 14.0,
  );

  // Dark mode map style
  static const String _darkMapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [{"color": "#212121"}]
    },
    {
      "elementType": "labels.icon",
      "stylers": [{"visibility": "off"}]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [{"color": "#212121"}]
    },
    {
      "featureType": "administrative",
      "elementType": "geometry",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [{"color": "#181818"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#616161"}]
    },
    {
      "featureType": "road",
      "elementType": "geometry.fill",
      "stylers": [{"color": "#2c2c2c"}]
    },
    {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#8a8a8a"}]
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry",
      "stylers": [{"color": "#373737"}]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [{"color": "#3c3c3c"}]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry",
      "stylers": [{"color": "#4e4e4e"}]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#616161"}]
    },
    {
      "featureType": "transit",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [{"color": "#000000"}]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#3d3d3d"}]
    }
  ]
  ''';

  @override
  void initState() {
    super.initState();
    // Initialize controller แบบ lazy - จะสร้างครั้งเดียวต่อ lifecycle
    _mapController = Get.put(ProductMapController(), permanent: false);

    // เริ่มโหลดตำแหน่งหลัง UI render เสร็จ - ป้องกัน ANR
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ทำใน background ไม่ block UI
      _getCurrentLocation().catchError((error) {
        debugPrint('Location error: $error');
      });
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      // เช็คspermission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        // ขอ permission (อาจใช้เวลา - ให้มี timeout)
        permission = await Geolocator.requestPermission().timeout(
          const Duration(seconds: 30),
        );
      }

      // ถ้าไม่อนุญาต
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('กรุณาอนุญาตสิทธิ์เข้าถึงตำแหน่ง'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        return;
      }

      // รับตำแหน่ง
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      ).timeout(const Duration(seconds: 15));

      if (!mounted) return;

      setState(() {
        _currentPosition = position;
      });

      // โหลดพ่อค้า
      _mapController
          .loadNearbyVendors(position.latitude, position.longitude)
          .catchError((e) => debugPrint('Load vendors error: $e'));
    } on TimeoutException {
      debugPrint('Location timeout');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ไม่สามารถรับตำแหน่งได้'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _moveToLocation(double latitude, double longitude) async {
    try {
      if (_controller.isCompleted) {
        final controller = await _controller.future;
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(latitude, longitude), zoom: 15.0),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error moving camera: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Stack(
        children: [
          // Google Map - ไม่เต็มหน้าจอ (มีพื้นที่ด้านล่างสำหรับ vendor list)
          GetBuilder<ProductMapController>(
            init: _mapController,
            builder: (controller) => GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kInitialPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false, // ปิดปุ่ม default ของ Google
              markers: controller.markers,
              // Dark mode for map
              mapToolbarEnabled: false,
              style: isDark ? _darkMapStyle : null,
              padding: const EdgeInsets.only(
                top: 80.0, // เว้นที่สำหรับปุ่มบน
                bottom: 250.0, // เว้นที่สำหรับ vendor list ด้านล่าง
                left: 16.0,
                right: 16.0,
              ),
              onMapCreated: (GoogleMapController mapController) {
                if (!_controller.isCompleted) {
                  _controller.complete(mapController);
                  // ย้ายกล้องหลังจาก map พร้อมแล้ว
                  if (_currentPosition != null) {
                    _moveToLocation(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    );
                  }
                }
              },
            ),
          ),

          // ปุ่ม My Location - ซ้ายล่าง (เหนือ vendor list)
          Positioned(
            bottom: 270, // ให้สูงกว่า vendor list
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.5 : 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: _goToMyLocation,
                  child: Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Vendor List Bottom Sheet - แสดงตลอดเวลา
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 250, // ความสูงของ bottom sheet
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'พ่อค้า/แม่ค้าใกล้เคียง',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Vendor List
                  Expanded(
                    child: Obx(() {
                      if (_mapController.isLoadingVendors.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (_mapController.vendors.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.store_outlined,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'ไม่พบพ่อค้า/แม่ค้าใกล้เคียง',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _mapController.vendors.length,
                        itemBuilder: (context, index) {
                          final vendor = _mapController.vendors[index];
                          return InkWell(
                            onTap: () {
                              // เลือก vendor และแสดง products
                              _mapController.onMarkerTapped(vendor);
                              // ย้ายกล้องไปที่ vendor
                              if (vendor.hasLocation &&
                                  vendor.profile != null) {
                                _moveToLocation(
                                  vendor.profile!.latitude!,
                                  vendor.profile!.longitude!,
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.grey[850]
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.store,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vendor.fullName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        if (vendor.profile?.district != null)
                                          Text(
                                            vendor.profile!.district!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Product Bottom Sheet - แสดงเมื่อเลือก vendor
          Obx(() {
            if (_mapController.selectedVendor.value != null) {
              return VendorProductsBottomSheet(
                vendor: _mapController.selectedVendor.value!,
                products: _mapController.vendorProducts,
                isLoading: _mapController.isLoadingProducts.value,
                onClose: () => _mapController.clearSelection(),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Future<void> _goToMyLocation() async {
    if (_currentPosition == null) {
      // แสดง loading indicator
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('กำลังค้นหาตำแหน่ง...')));
      }
      await _getCurrentLocation();
      return;
    }

    await _moveToLocation(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
  }

  @override
  void dispose() {
    // ลบ controller ออกจาก GetX memory
    Get.delete<ProductMapController>();
    // ปิด map controller เมื่อออกจากหน้า
    _controller.future.then((controller) => controller.dispose());
    super.dispose();
  }
}
