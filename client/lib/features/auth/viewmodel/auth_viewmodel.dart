import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    return null;
  }

  Future<void> initSharedPref() async {
    await _authLocalRepository.init();
  }

  Future<void> signup(
      {required String name,
      required String email,
      required String password}) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.signup(
        name: name, email: email, password: password);
    final val = switch (res) {
      Right(value: final r) => state = AsyncValue.data(r),
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
    };
    print(val);
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    final res =
        await _authRemoteRepository.login(email: email, password: password);
    final val = switch (res) {
      Right(value: final r) => _loginSuccess(r),
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
    };
    print(val);
  }

  AsyncValue<UserModel> _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    return state = AsyncValue.data(user);
  }

  Future<UserModel?> getData() async {
    final token = _authLocalRepository.getToken();
    state = const AsyncValue.loading();
    if (token != null) {
      final res = await _authRemoteRepository.getCurrentUserData(token);
      final val = switch (res) {
        Right(value: final r) => state = AsyncValue.data(r),
        Left(value: final l) => state =
            AsyncValue.error(l.message, StackTrace.current),
      };
      return val.value;
    }
    return null;
  }
}
