import 'dart:convert';

import 'package:shopping_for_friends/models/product.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'frutiland.herokuapp.com';

Future<bool> pingService() async {
  Uri uri = Uri.https(baseUrl, '');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return Future<bool>.error('Service Not Available');
  }
}

Future<List<Product>> fetchProducts({String query, String category}) async {
  var queryParameters = Map<String, String>();
  if (query != null) {
    queryParameters.putIfAbsent('q', () => query);
  }
  if (category != null) {
    queryParameters.putIfAbsent('category', () => category);
  }
  Uri uri = Uri.https(baseUrl, 'search', queryParameters);
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    List<Product> _products = [];
    var body = json.decode(response.body);
    body.forEach((productJson) {
      _products.add(Product.fromJson(productJson));
    });
    return _products;
  } else if (response.statusCode == 401) {
    return Future<List>.error('error');
  } else {
    throw Exception('Failed to login User');
  }
}
