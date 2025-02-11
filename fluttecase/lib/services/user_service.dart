import 'dart:convert';

import 'package:fluttecase/models/user.dart';

class UserService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  final String photoBaseUrl = 'https://picsum.photos/id';

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<UserModel> users =
            jsonData.map((json) => UserModel.fromJson(json)).toList();

        // Fetch photo URLs for each user
        for (var user in users) {
          user.photoUrl = await getUserPhotoUrl(user.id);
        }

        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> getUserPhotoUrl(int id) async {
    try {
      final response = await http.get(Uri.parse('$photoBaseUrl/$id/info'));

      if (response.statusCode == 200) {
        return '$photoBaseUrl/$id/200';
      } else {
        return '$photoBaseUrl/1/200'; // Fallback image
      }
    } catch (e) {
      return '$photoBaseUrl/1/200'; // Fallback image
    }
  }
}
