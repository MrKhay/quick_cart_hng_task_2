// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable

/// Product details
class Product {
  /// unique id
  final String id;

  /// name of product
  final String name;

  /// category of product
  final String catergory;

  /// product image url
  final String imgUrl;

  /// price of product
  final double price;

  /// product description
  final String description;
  const Product({
    required this.id,
    required this.name,
    required this.catergory,
    required this.imgUrl,
    required this.price,
    required this.description,
  });

  Product copyWith({
    String? id,
    String? name,
    String? catergory,
    String? imgUrl,
    double? price,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      catergory: catergory ?? this.catergory,
      imgUrl: imgUrl ?? this.imgUrl,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'catergory': catergory,
      'imgUrl': imgUrl,
      'price': price,
      'description': description,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      catergory: map['catergory'] as String,
      imgUrl: map['imgUrl'] as String,
      price: map['price'] as double,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, catergory: $catergory, imgUrl: $imgUrl, price: $price, description: $description)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.catergory == catergory &&
        other.imgUrl == imgUrl &&
        other.price == price &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        catergory.hashCode ^
        imgUrl.hashCode ^
        price.hashCode ^
        description.hashCode;
  }
}
