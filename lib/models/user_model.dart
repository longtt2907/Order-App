class User {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final bool isAdmin;

  User(
      {required this.email,
      required this.id,
      required this.fullName,
      required this.phoneNumber,
      required this.isAdmin});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      isAdmin: json['isAdmin'] as bool,
    );
  }
}
