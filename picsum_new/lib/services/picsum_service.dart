import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class PicsumService {
  Future<List<Photo>> fetchPhotos({int page = 1, int limit = 30}) async {
    final uri = Uri.parse("https://picsum.photos/v2/list?page=" + page.toString() + "&limit=" + limit.toString());
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception("Failed: " + response.statusCode.toString());
    }
  }
}