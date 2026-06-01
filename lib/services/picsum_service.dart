import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class PicsumService {
  static const String _baseUrl = 'https://picsum.photos/v2/list';

  Future<List<Photo>> fetchPhotos({int page = 1, int limit = 30}) async {
    final uri = Uri.parse('\$_baseUrl?page=\$page&limit=\$limit');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos: \${response.statusCode}');
    }
  }
}
