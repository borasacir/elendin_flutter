class UserProfileModel {
  String username;
  int tropyCount;
  int winStreak;
  UserProfileModel(
      {required this.username, this.tropyCount = 0, this.winStreak = 0});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
        username: json['username'],
        tropyCount: json['tropyCount'] ?? 0,
        winStreak: json['winStreak'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'tropyCount': tropyCount,
      'winStreak': winStreak
    };
  }
}
