import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/response_detail.dart';
import 'package:restaurant_app/data/model/response_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';

  Future<ResponseRestaurant> listRestaurant(http.Client client) async {
    final response = await client.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return ResponseRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Restaurant List');
    }
  }

  Future<ResponseRestaurant> searchrestaurant(String nama) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + nama));
    if (response.statusCode == 200) {
      return ResponseRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failde to Search Restaurant');
    }
  }

  Future<ResponseDetail> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return ResponseDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get Detail Restaurant');
    }
  }

  Future<bool> checkConnection() async {
    try {
      final connect =
          await InternetAddress.lookup('restaurant-api.dicoding.dev');
      if (connect.isNotEmpty && connect[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
