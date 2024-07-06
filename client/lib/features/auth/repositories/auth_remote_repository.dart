import 'dart:convert';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstants.serverUrl}/auth/signup'),
        headers: {"Content-type": 'application/json'},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );
      if (response.statusCode != 201) {
        return Left(AppFailure(response.body));
      }
      final user = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(UserModel.fromMap(user));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> login(
      {required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstants.serverUrl}/auth/login'),
        headers: {"Content-type": 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      if (response.statusCode != 200) {
        return Left(AppFailure(response.body));
      }
      final user = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(UserModel.fromMap(user));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}