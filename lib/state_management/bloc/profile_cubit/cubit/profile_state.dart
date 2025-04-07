part of 'profile_cubit.dart';

class ProfileState {
  final String username;
  final int trophyCount;
  final int winStreak;
  final String email;

  ProfileState(
      {this.username = '',
      this.trophyCount = 0,
      this.winStreak = 0,
      this.email = ''});

  ProfileState copyWith(
      {String? username, int? trophyCount, int? winStreak, String? email}) {
    return ProfileState(
        username: username ?? this.username,
        trophyCount: trophyCount ?? this.trophyCount,
        winStreak: winStreak ?? this.winStreak,
        email: email ?? this.email);
  }
}
