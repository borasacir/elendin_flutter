class UserModel {
  String userId;
  String? email;
  String? displayName;
  bool emailVerified;
  UserModel({required this.userId, required this.displayName, required this.email, this.emailVerified = false});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      displayName: json['displayName'],
      email: json['email'],
      emailVerified: json['emailVerified']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'emailVerified': emailVerified
    };
  }
}
