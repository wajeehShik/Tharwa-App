import 'package:flutter/material.dart';

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category; // e.g., 'طعام', 'مواصلات'
  final String classification; // 'أساسي', 'كمالي'
  final IconData icon;
  final Color color;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.classification,
    required this.icon,
    this.color = Colors.blue,
  });

  ExpenseModel copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    String? category,
    String? classification,
    IconData? icon,
    Color? color,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      classification: classification ?? this.classification,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}
