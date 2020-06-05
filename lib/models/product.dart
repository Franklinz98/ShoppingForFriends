import 'package:flutter/widgets.dart';

class Product {
  String name;
  int price;
  int quantity;
  bool purchased = false;

  Product({@required this.name, @required this.price, @required this.quantity});

  void addUnit() {
    quantity = quantity + 1;
  }

  void removeUnit() {
    if (quantity != 0) {
      quantity = quantity - 1;
    }
  }

  void changePurchasedState() {
    purchased = !purchased;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'], quantity: 1, price: json['price'].round());
  }
}
