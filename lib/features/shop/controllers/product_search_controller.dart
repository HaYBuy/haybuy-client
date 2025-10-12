import 'package:get/get.dart';

class ProductSearchController extends GetxController {
  var searchText = ''.obs;

  void updateSearchText(String text) {
    searchText.value = text;
  }

  void performSearch() {
    final query = searchText.value.trim();
    if (query.isEmpty) return;
    // ใส่โลจิกการค้นหา / นำทางไปยังผลลัพธ์การค้นหา
  }

  /// Clear selected vendor
  void clearSearch() {
    searchText.value = '';
  }

  @override
  void onClose() {
    clearSearch();
    super.onClose();
  }
}
