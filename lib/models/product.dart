import 'package:flutter/widgets.dart';

class Product {
  String name;
  int price;
  int quantity;

  Product({@required this.name, @required this.price, @required this.quantity});

  void addUnit() {
    quantity = quantity + 1;
  }

  void removeUnit() {
    if (quantity != 0) {
      quantity = quantity - 1;
    }
  }
}
