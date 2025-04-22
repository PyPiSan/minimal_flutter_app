import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/authentication/models/otp_response.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/authentication/models/verify_otp_response.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/models/chat_response_model.dart';

class ApiService {
  late final Dio _dio;
  final Logger _logger = Logger();

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl:
                dotenv.env['BACKEND_URL'] ?? "", // Replace with API's base URL
            connectTimeout: const Duration(seconds: 120),
            receiveTimeout: const Duration(seconds: 120),
            sendTimeout: const Duration(seconds: 120),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        ) {
    // Add a logging interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.i('Request: ${options.method} ${options.uri}');
          _logger.i('Headers: ${options.headers}');
          _logger.i('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i('Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _logger.e('Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<OtpResponse?> sendOtp(String email) async {
    try {
      final response = await _dio.post(
        '/api/v1/auth/getOTP', // Replace with API endpoint
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        return OtpResponse.fromJson(response.data);
      } else {
        _logger.w('Failed to send OTP: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      _logger.e('DioException: ${e.message}');
      return null;
    } catch (e) {
      _logger.e('Unexpected error: $e');
      return null;
    }
  }

  Future<VerifyOtpResponse?> validateOtp(
      String email, String otp, String name) async {
    try {
      final response = await _dio.post(
        '/api/v1/auth/verifyOTP', // Replace with API endpoint
        data: {'email': email, 'otp': otp, 'name': name},
      );

      if (response.statusCode == 200) {
        return VerifyOtpResponse.fromJson(response.data);
      } else {
        _logger.w('Failed to verify OTP: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      _logger.e('DioException: ${e.message}');
      return null;
    } catch (e) {
      _logger.e('Unexpected error: $e');
      return null;
    }
  }

  Future<ChatResponseModel?> askQuestion(String query, String sessionId,
      String conversationId, bool isNewConversation) async {
    try {
      final response = await _dio.post(
        '/api/v1/response', // Replace with API endpoint
        data: {
          'query': query,
          'session_id': sessionId,
          'conversation_id': conversationId,
          "is_new_conversation": isNewConversation,
          "chat_history": []
        },
      );

      if (response.statusCode == 200) {
        return ChatResponseModel.fromJson(response.data);
      } else {
        _logger.w('Error in getting answer: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      _logger.e('DioException: ${e.message}');
      return null;
    } catch (e) {
      _logger.e('Unexpected error: $e');
      return null;
    }
  }
}
