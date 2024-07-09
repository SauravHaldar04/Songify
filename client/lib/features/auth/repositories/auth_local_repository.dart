import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  late SharedPreferences sharedPreferences;
  Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void setToken(String? token) async {
    if (token != null) {
      await sharedPreferences.setString('x-auth-token', token);
    }
  }

  String? getToken() {
    return sharedPreferences.getString('x-auth-token');
  }
}
