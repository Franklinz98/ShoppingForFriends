import 'package:flutter/widgets.dart';

class Product {
  String name;
  int price;
  int quantity;
  bool purchased;

  Product(
      {@required this.name,
      @required this.price,
      @required this.quantity,
      this.purchased = false});

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

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'],
        quantity: map['quantity'],
        price: map['price'],
        purchased: map['purchased']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'purchased': purchased,
    };
  }
}
