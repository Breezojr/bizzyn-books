import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final Dio _dio = Dio();

  Future<http.Response> reg(Map<String, dynamic>? data) {
    return http.post(Uri.parse('http://10.0.2.2:3000/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
  }

  Future<http.Response> log(String email, String password) async {
    return http.post(Uri.parse('http://10.0.2.2:3000/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }));
  }

  Future<dynamic> registerUser(Map<String, dynamic>? data) async {
    try {
      Response response = await _dio.post(
          'https://api.loginradius.com/identity/v2/auth/register',
          data: data,
          queryParameters: {'apikey': "ApiSecret.apiKey"},
          options: Options(headers: {'X-LoginRadius-Sott': "ApiSecret.sott"}));
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'https://api.loginradius.com/identity/v2/auth/login',
        data: {
          'email': email,
          'password': password,
        },
        queryParameters: {'apikey': "ApiSecret.apiKey"},
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<http.Response> getUserProfileData(String accessToken) async {
    return http.post(Uri.parse('http://10.0.2.2:3000/auth/user-profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        });
  }

  Future<dynamic> updateUserProfile({
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await _dio.put(
        'https://api.loginradius.com/identity/v2/auth/account',
        data: data,
        queryParameters: {'apikey': "ApiSecret.apiKey"},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> logout(String accessToken) async {
    try {
      Response response = await _dio.get(
        'https://api.loginradius.com/identity/v2/auth/access_token/InValidate',
        queryParameters: {'apikey': "ApiSecret.apiKey"},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
