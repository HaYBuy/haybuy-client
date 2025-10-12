class UserProfileModel {
  final int id;
  final int userId;
  final String? phone;
  final String? addressLine1;
  final String? addressLine2;
  final String? district;
  final String? province;
  final String? postalCode;
  final double? latitude;
  final double? longitude;
  final bool locationVerified;
  final bool idVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserProfileModel({
    required this.id,
    required this.userId,
    this.phone,
    this.addressLine1,
    this.addressLine2,
    this.district,
    this.province,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.locationVerified = false,
    this.idVerified = false,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      phone: json['phone'] as String?,
      addressLine1: json['address_line1'] as String?,
      addressLine2: json['address_line2'] as String?,
      district: json['district'] as String?,
      province: json['province'] as String?,
      postalCode: json['postal_code'] as String?,
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      locationVerified: json['location_verified'] as bool? ?? false,
      idVerified: json['id_verified'] as bool? ?? false,
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
      'user_id': userId,
      'phone': phone,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'district': district,
      'province': province,
      'postal_code': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'location_verified': locationVerified,
      'id_verified': idVerified,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool get hasLocation => latitude != null && longitude != null;
}
