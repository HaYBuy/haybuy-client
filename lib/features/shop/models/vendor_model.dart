class VendorModel {
  final int id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profileImage;
  final UserProfileModel? profile;

  VendorModel({
    required this.id,
    required this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.profileImage,
    this.profile,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'] as int,
      username: json['username'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      profileImage: json['profile_image'] as String?,
      profile: json['profile'] != null
          ? UserProfileModel.fromJson(json['profile'] as Map<String, dynamic>)
          : null,
    );
  }

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    }
    return username;
  }

  bool get hasLocation => profile?.hasLocation ?? false;
}

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

  bool get hasLocation => latitude != null && longitude != null;

  String get fullAddress {
    final parts = <String>[];
    if (addressLine1 != null) parts.add(addressLine1!);
    if (addressLine2 != null) parts.add(addressLine2!);
    if (district != null) parts.add(district!);
    if (province != null) parts.add(province!);
    if (postalCode != null) parts.add(postalCode!);
    return parts.join(', ');
  }
}
