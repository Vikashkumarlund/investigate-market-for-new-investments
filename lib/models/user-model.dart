// ignore_for_file: file_names

class UserModel {
  final String uId;
  final String username;
  final String userpassword;
  final String email;
  final String phone;
  final String userAddress;
  final String isAdmin;
  final String status;

  UserModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.phone,
    required this.userAddress,
    required this.isAdmin,
    required this.userpassword,
    required this.status,
  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'phone': phone,
      'userAddress': userAddress,
      'isAdmin': isAdmin,
      'userpassword': userpassword,
      'status': status,
    };
  }

  // Create a UserModel instance from a JSON map
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      userAddress: json['userAddress'],
      isAdmin: json['isAdmin'],
      userpassword: json['userpassword'],
      status: json['status'],
    );
  }
}
