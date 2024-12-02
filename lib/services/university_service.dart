import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/university.dart';

class UniversityService {
  Future<List<University>> fetchUniversities(String country) async {
    final String apiUrl = 'http://universities.hipolabs.com/search?country=$country';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => University.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load universities');
    }
  }
}
