import 'package:flutter/material.dart';

enum Importance { low, medium, high }

class GroceryItem {
  final String id;
  final String name;
  final Importance importance;
  final int quantity;
  final Color color;
  final DateTime date;
  final bool isComplete;

  GroceryItem({
    id,
    bool? isComplete,
    required this.name,
    required this.importance,
    required this.color,
    required this.quantity,
    required this.date,
  })  : id = id ?? '',
        isComplete = isComplete ?? false;

  GroceryItem copyWith({
    String? id,
    String? name,
    Importance? importance,
    Color? color,
    int? quantity,
    DateTime? date,
    bool? isComplete,
  }) {
    return GroceryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      importance: importance ?? this.importance,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
