import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

enum ItemStatus {
  available,
  outOfStock,
  discontinued,
}

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _searchTextController = TextEditingController();

  ItemStatus _selectedStatus = ItemStatus.available;
  bool _isLoading = false;
  
  final List<Map<String, dynamic>> _categories = [
    {'id': 1, 'name': 'อุปกรณ์อิเล็กทรอนิกส์'},
    {'id': 2, 'name': 'เสื้อผ้า'},
    {'id': 3, 'name': 'อาหาร'},
    {'id': 4, 'name': 'หนังสือ'},
    {'id': 5, 'name': 'เฟอร์นิเจอร์'},
  ];
  
  int? _selectedCategoryId;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _imageUrlController.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณาใส่ชื่อสินค้า';
    }
    if (value.length < 3) {
      return 'ชื่อสินค้าต้องยาวอย่างน้อย 3 ตัวอักษร';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณาใส่ราคา';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'กรุณาใส่ราคาที่ถูกต้อง';
    }
    if (price < 0) {
      return 'ราคาต้องมากกว่า 0';
    }
    if (value.split('.').length > 1 && value.split('.')[1].length > 2) {
      return 'ราคาต้องมีทศนิยมไม่เกิน 2 ตำแหน่ง';
    }
    return null;
  }

  String? _validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณาใส่จำนวน';
    }
    final quantity = int.tryParse(value);
    if (quantity == null) {
      return 'กรุณาใส่จำนวนที่ถูกต้อง';
    }
    if (quantity < 0) {
      return 'จำนวนต้องมากกว่าหรือเท่ากับ 0';
    }
    return null;
  }

  String? _validateCategoryId(int? value) {
    if (value == null) {
      return 'กรุณาเลือกหมวดหมู่';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final productData = {
        'name': _nameController.text,
        'description': _descriptionController.text.isEmpty ? null : _descriptionController.text,
        'price': double.parse(_priceController.text),
        'quantity': int.parse(_quantityController.text),
        'status': _selectedStatus.name,
        'image_url': _imageUrlController.text.isEmpty ? null : _imageUrlController.text,
        'search_text': _searchTextController.text.isEmpty ? null : _searchTextController.text,
        'category_id': _selectedCategoryId,
      };


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('สร้างสินค้าสำเร็จ')),
      );

      _formKey.currentState!.reset();
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _quantityController.clear();
      _imageUrlController.clear();
      _searchTextController.clear();
      _selectedCategoryId = null;

      setState(() => _isLoading = false);
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Container
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  // Appbar
                  CustomAppBar(
                    title: const Text('สร้างสินค้าใหม่'),
                    showBackArrow: true,
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),

            // Form Content
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // อัพโหลดรูปภาพ
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ฟังก์ชันอัพโหลดรูปภาพยังไม่เสร็จ')),
                        );
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(Sizes.md),
                          color: dark ? ConstColors.dark : Colors.grey[100],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.image,
                              size: 48,
                              color: dark ? Colors.grey[400] : Colors.grey,
                            ),
                            const SizedBox(height: Sizes.sm),
                            Text(
                              _imageUrlController.text.isEmpty
                                  ? 'กรุณาเลือกรูปภาพ'
                                  : 'เปลี่ยนรูปภาพ',
                              style: TextStyle(
                                color: dark ? Colors.grey[400] : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    // ชื่อสินค้า
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อสินค้า *',
                        hintText: 'กรุณาใส่ชื่อสินค้า',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
                        ),
                        prefixIcon: const Icon(Iconsax.tag),
                      ),
                      validator: _validateName,
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    // ราคา และ จำนวน
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _priceController,
                            decoration: InputDecoration(
                              labelText: 'ราคา *',
                              hintText: '99.99',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
                              ),
                              prefixIcon: const Icon(Iconsax.money),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: _validatePrice,
                          ),
                        ),
                        const SizedBox(width: Sizes.spaceBtwInputFields),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _quantityController,
                            decoration: InputDecoration(
                              labelText: 'จำนวน *',
                              hintText: '10',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
                              ),
                              prefixIcon: const Icon(Iconsax.box),
                            ),
                            keyboardType: TextInputType.number,
                            validator: _validateQuantity,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    // หมวดหมู่
                    DropdownButtonFormField<int>(
                      value: _selectedCategoryId,
                      decoration: InputDecoration(
                        labelText: 'หมวดหมู่ *',
                        hintText: 'กรุณาเลือกหมวดหมู่',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
                        ),
                        prefixIcon: const Icon(Iconsax.category),
                      ),
                      items: _categories.map((category) {
                        return DropdownMenuItem<int>(
                          value: category['id'],
                          child: Text(category['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedCategoryId = value);
                      },
                      validator: (value) => _validateCategoryId(value),
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    // สถานะ และ ข้อความค้นหา
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'สถานะสินค้า *',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: Sizes.sm),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
                                ),
                                child: DropdownButton<ItemStatus>(
                                  value: _selectedStatus,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
                                  items: ItemStatus.values.map((status) {
                                    return DropdownMenuItem(
                                      value: status,
                                      child: Text(
                                        status == ItemStatus.available
                                            ? 'พร้อมขาย'
                                            : status == ItemStatus.outOfStock
                                                ? 'สินค้าหมด'
                                                : 'ยกเลิกแล้ว',
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() => _selectedStatus = value);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: Sizes.spaceBtwInputFields),
                        Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Text(
                            ' ',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _searchTextController,
                            decoration: InputDecoration(
                              labelText: 'ข้อความค้นหา',
                              hintText: 'ข้อความค้นหา',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.search),
                            ),
                          ),

                        ]
                    ),
                    
                  ),
                      ],
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    // รายละเอียด
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'รายละเอียด',
                        hintText: 'กรุณาใส่รายละเอียดสินค้า',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
                        ),
                        prefixIcon: const Icon(Iconsax.note),
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: Sizes.spaceBtwSections),

                    // ปุ่มสร้างสินค้า
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: Sizes.lg),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text(
                                'สร้างสินค้า',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}