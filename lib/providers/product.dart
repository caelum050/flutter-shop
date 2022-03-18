import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String description;
  final double price;
  final String imageUrl;

  Product(
      {@required this.id,
      @required this.name,
      @required this.brand,
      @required this.category,
      @required this.description,
      @required this.price,
      @required this.imageUrl});
}
