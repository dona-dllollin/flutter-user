import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/food_model.dart';

class FoodService {
  final _baseUrl = 'http://192.168.7.201:3000';

  Future<List<FoodModel>> getFoods() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/makanan'));
    if (response.statusCode == 200) {
      // Iterable body = json.decode(response.body);
      // List<FoodModel> foods =
      //     body.map((item) => FoodModel.fromJson(item)).toList();
      // return foods;
      final List body = json.decode(response.body);
      return body.map((e) => FoodModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load makanan');
    }
  }

  Future<List<FoodModel>> getByCategory(String id) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/api/makanan/kategori/$id'));
    if (response.statusCode == 200) {
      // Iterable body = json.decode(response.body);
      // List<FoodModel> foods =
      //     body.map((item) => FoodModel.fromJson(item)).toList();
      // return foods;
      final List body = json.decode(response.body);
      return body.map((e) => FoodModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load makanan');
    }
  }

  Future<FoodModel> getById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/api/makanan/$id'));
    if (response.statusCode == 200) {
      // Iterable body = json.decode(response.body);
      // List<FoodModel> foods =
      //     body.map((item) => FoodModel.fromJson(item)).toList();
      // return foods;
      final Map<String, dynamic> body = json.decode(response.body);
      return FoodModel.fromJson(body); // Mengembalikan objek FoodModel tunggal
    } else {
      throw Exception('Failed to load makanan');
    }
  }
}
