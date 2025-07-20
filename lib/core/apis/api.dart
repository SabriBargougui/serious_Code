import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://backendseriousgame.onrender.com/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Future<Response> signup(Map<String, dynamic> data) async {
    try {
      return await _dio.post('/signup', data: data);
    } on DioException catch (e) {
      throw e;
    }
  }

  static Future<Response> login(Map<String, dynamic> data) async {
    return await _dio.post('/login', data: data);
  }

  static Future<Response> updateScore(String userId, int score) async {
    return await _dio.put('/score/$userId', data: {'score': score});
  }

  static Future<Response> getProfile(String token) async {
    return await _dio.get(
      '/profile',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}
