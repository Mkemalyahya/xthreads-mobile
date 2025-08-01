import 'package:http/http.dart' as http;

class LikeService {
  final String baseUrl;
  final String token;

  LikeService({required this.baseUrl, required this.token});

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// Like a thread
  Future<http.Response> likeThread(int threadId) {
    return http.post(
      Uri.parse('$baseUrl/api/threads/$threadId/like'),
      headers: _headers,
    );
  }

  /// Unlike a thread
  Future<http.Response> unlikeThread(int threadId) {
    return http.delete(
      Uri.parse('$baseUrl/api/threads/$threadId/like'),
      headers: _headers,
    );
  }

  /// Toggle like/unlike
  Future<http.Response> toggleLike(int threadId) {
    return http.post(
      Uri.parse('$baseUrl/api/threads/$threadId/toggle-like'),
      headers: _headers,
    );
  }

  /// Get all users who liked the thread
  Future<http.Response> getLikes(int threadId) {
    return http.get(
      Uri.parse('$baseUrl/api/threads/$threadId/likes'),
      headers: _headers,
    );
  }
}
