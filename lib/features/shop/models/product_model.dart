import 'dart:convert';

class ProductModel {
  final int id;
  final String name;
  final String? description;
  final double price;
  final int? quantity;
  final String? status; 
  final String? imageUrl;
  final String? searchText;
  final int categoryId;
  final int ownerId;
  final int? groupId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  // final String unit;


  ProductModel({
    required this.id, 
    required this.name,
    this.description,
    required this.price,
    this.quantity,
    this.status,
    this.imageUrl,
    this.searchText,
    required this.categoryId,
    required this.ownerId,
    this.groupId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    // this.unit = "ชิ้น"
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      quantity: json['quantity'] as int,
      status: json['status'] is String ? json['status'] : json['status']['value'], 
      imageUrl: json['image_url'] as String?,
      searchText: json['search_text'] as String?,
      categoryId: json['category_id'] as int,
      ownerId: json['owner_id'] as int,
      groupId: json['group_id'] == null? null: (json['group_id'] is int? json['group_id'] as int: int.tryParse(json['group_id'].toString())),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'status': status,
      'image_url': imageUrl,
      'search_text': searchText,
      'category_id': categoryId,
      'owner_id': ownerId,
      'group_id': groupId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

   static List<ProductModel> fromJsonList(String str) {
    final jsonData = json.decode(str) as List;
    return jsonData.map((e) => ProductModel.fromJson(e)).toList();
  }
}
