class LoginRequest {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}

class LoginResponse {
  final String accessToken;
  final String tokenType;

  LoginResponse({required this.accessToken, required this.tokenType});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? 'bearer',
    );
  }

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'token_type': tokenType,
  };
}

class RegisterRequest {
  final String username;
  final String password;
  final String fullName;
  final String email;

  RegisterRequest({
    required this.username,
    required this.password,
    required this.fullName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'full_name': fullName,
    'email': email,
  };
}

class UserResponse {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserResponse({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      isActive: json['is_active'] ?? false,
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'full_name': fullName,
    'email': email,
    'is_active': isActive,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
