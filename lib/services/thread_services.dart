import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ThreadService {
  final String baseUrl = 'http://127.0.0.1:8000/api'; // ganti ke IP backend
  final String token; // dari auth

  ThreadService(this.token);

  Map<String, String> get headers => {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<List<dynamic>> fetchTimeline() async {
    final res = await http.get(Uri.parse('$baseUrl/threads'), headers: headers);
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['data']['timeline'];
    } else {
      throw Exception('Failed to load timeline');
    }
  }

  Future<Map<String, dynamic>> fetchThreadDetail(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/threads/$id'), headers: headers);
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['data'];
    } else {
      throw Exception('Failed to load thread detail');
    }
  }

  Future<void> deleteThread(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/threads/$id'), headers: headers);
    if (res.statusCode != 200) {
      throw Exception('Failed to delete thread');
    }
  }

  Future<void> createThread({
    required String content,
    File? image,
    int? parentId,
  }) async {
    var uri = Uri.parse('$baseUrl/threads');
    var req = http.MultipartRequest('POST', uri);
    req.headers['Authorization'] = 'Bearer $token';
    req.fields['content'] = content;
    if (parentId != null) req.fields['parent_thread_id'] = parentId.toString();

    if (image != null) {
      final mimeType = lookupMimeType(image.path)!.split('/');
      req.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      ));
    }

    final res = await req.send();
    if (res.statusCode != 201) {
      final body = await res.stream.bytesToString();
      throw Exception('Failed to create thread: $body');
    }
  }
}
