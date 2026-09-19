import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final int cardCount;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.cardCount,
  });
}
