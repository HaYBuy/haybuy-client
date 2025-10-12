import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/repositories/vendor/vendor_repository.dart';
import '../models/vendor_model.dart';
import '../models/product_model.dart';

class ProductMapController extends GetxController {
  final VendorRepository _vendorRepository = VendorRepository();

  // Observable variables
  final RxList<VendorModel> vendors = <VendorModel>[].obs;
  final RxList<Marker> _markersList = <Marker>[].obs;
  Set<Marker> get markers => _markersList.toSet();
  final Rx<VendorModel?> selectedVendor = Rx<VendorModel?>(null);
  final RxList<ProductModel> vendorProducts = <ProductModel>[].obs;
  final RxBool isLoadingVendors = false.obs;
  final RxBool isLoadingProducts = false.obs;

  /// Load nearby vendors based on current location
  Future<void> loadNearbyVendors(double latitude, double longitude) async {
    try {
      isLoadingVendors.value = true;
      vendors.value = await _vendorRepository
          .getNearbyVendors(
            latitude: latitude,
            longitude: longitude,
            radiusKm: 10.0, // 10 km radius
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw Exception('การโหลดข้อมูลใช้เวลานานเกินไป');
            },
          );
      _createMarkers();
    } catch (e) {
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถโหลดข้อมูลพ่อค้าได้: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      // ตั้งค่าเป็น list ว่างแทนที่จะค้าง
      vendors.value = [];
    } finally {
      isLoadingVendors.value = false;
    }
  }

  /// Create markers for all vendors
  void _createMarkers() {
    _markersList.clear();

    for (var vendor in vendors) {
      if (vendor.hasLocation && vendor.profile != null) {
        final marker = Marker(
          markerId: MarkerId('vendor_${vendor.id}'),
          position: LatLng(
            vendor.profile!.latitude!,
            vendor.profile!.longitude!,
          ),
          infoWindow: InfoWindow(
            title: vendor.fullName,
            snippet: vendor.profile!.district ?? 'แตะเพื่อดูสินค้า',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
          onTap: () => onMarkerTapped(vendor),
        );
        _markersList.add(marker);
      }
    }
    // Notify GetBuilder to rebuild
    update();
  }

  /// Handle marker tap
  Future<void> onMarkerTapped(VendorModel vendor) async {
    selectedVendor.value = vendor;
    await loadVendorProducts(vendor.id);
  }

  /// Load products for selected vendor
  Future<void> loadVendorProducts(int vendorId) async {
    try {
      isLoadingProducts.value = true;
      vendorProducts.value = await _vendorRepository
          .getVendorProducts(vendorId)
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw Exception('การโหลดสินค้าใช้เวลานานเกินไป');
            },
          );
    } catch (e) {
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถโหลดสินค้าได้: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      vendorProducts.clear();
    } finally {
      isLoadingProducts.value = false;
    }
  }

  /// Clear selected vendor
  void clearSelection() {
    selectedVendor.value = null;
    vendorProducts.clear();
  }

  @override
  void onClose() {
    clearSelection();
    super.onClose();
  }
}
