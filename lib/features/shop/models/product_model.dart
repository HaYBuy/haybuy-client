class ProductModel {
  final int id;
  final String name;
  final String? description;
  final double price;
  final String? unit;
  final int? stock;
  final String? imageUrl;
  final int vendorId;
  final bool isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.unit,
    this.stock,
    this.imageUrl,
    required this.vendorId,
    this.isAvailable = true,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      unit: json['unit'] as String?,
      stock: json['stock'] as int?,
      imageUrl: json['image_url'] as String?,
      vendorId: json['vendor_id'] as int,
      isAvailable: json['is_available'] as bool? ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'unit': unit,
      'stock': stock,
      'image_url': imageUrl,
      'vendor_id': vendorId,
      'is_available': isAvailable,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  String get priceText {
    if (unit != null) {
      return '฿${price.toStringAsFixed(2)}/$unit';
    }
    return '฿${price.toStringAsFixed(2)}';
  }
}
