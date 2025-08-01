import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xthreads_mobile/services/api_services.dart';
import 'package:xthreads_mobile/services/auth_service.dart';
import 'package:xthreads_mobile/models/api_response.dart';

class RepostService {
  Future<ApiResponse> createRepost(int threadId) async {
    try {
      final token = await AuthService.getToken();
      final response = await http.post(
        Uri.parse('${Api.baseUrl}/threads/$threadId/repost'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return ApiResponse.fromHttpResponse(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> deleteRepost(int threadId) async {
    try {
      final token = await AuthService.getToken();
      final response = await http.delete(
        Uri.parse('${Api.baseUrl}/threads/$threadId/repost'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return ApiResponse.fromHttpResponse(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> toggleRepost(int threadId) async {
    try {
      final token = await AuthService.getToken();
      final response = await http.post(
        Uri.parse('${Api.baseUrl}/threads/$threadId/toggle-repost'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return ApiResponse.fromHttpResponse(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> getRepostUsers(int threadId) async {
    try {
      final token = await AuthService.getToken();
      final response = await http.get(
        Uri.parse('${Api.baseUrl}/threads/$threadId/reposts'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return ApiResponse.fromHttpResponse(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }
}
