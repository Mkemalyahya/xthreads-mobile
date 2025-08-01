import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl;
  final String token;

  UserService({required this.baseUrl, required this.token});

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<http.Response> search(String query) {
    return http.get(
      Uri.parse('$baseUrl/api/users/search?q=$query'),
      headers: _headers,
    );
  }

  Future<http.Response> getUser(int userId) {
    return http.get(
      Uri.parse('$baseUrl/api/users/$userId'),
      headers: _headers,
    );
  }

  Future<http.Response> getFollowers(int userId) {
    return http.get(
      Uri.parse('$baseUrl/api/users/$userId/followers'),
      headers: _headers,
    );
  }

  Future<http.Response> getFollowing(int userId) {
    return http.get(
      Uri.parse('$baseUrl/api/users/$userId/following'),
      headers: _headers,
    );
  }

  Future<http.Response> followUser(int userId) {
    return http.post(
      Uri.parse('$baseUrl/api/users/$userId/follow'),
      headers: _headers,
    );
  }

  Future<http.Response> unfollowUser(int userId) {
    return http.delete(
      Uri.parse('$baseUrl/api/users/$userId/follow'),
      headers: _headers,
    );
  }

  Future<http.Response> toggleFollowUser(int userId) {
    return http.post(
      Uri.parse('$baseUrl/api/users/$userId/toggle-follow'),
      headers: _headers,
    );
  }
}
