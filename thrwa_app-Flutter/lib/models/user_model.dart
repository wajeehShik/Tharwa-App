// ignore_for_file: public_member_api_docs

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'token': token,
  };

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      token: token ?? this.token,
    );
  }

  @override
  String toString() => 'UserModel(id: $id, name: $name, email: $email)';
}
