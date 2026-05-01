import 'package:flutter/material.dart';

class DebtModel {
  final String id;
  final String title;
  final String creditor;
  final String subtitle;

  final double totalAmount;
  final double remainingAmount;
  final double paidAmount;
  final DateTime dueDate;
  final IconData icon;
  final bool isWarning;

  final double? monthlyInstallment;
  final List<InstallmentModel> installments;

  DebtModel({
    required this.id,
    required this.title,
    required this.creditor,
    required this.subtitle,
    required this.totalAmount,
    required this.remainingAmount,
    required this.paidAmount,
    required this.dueDate,
    this.icon = Icons.account_balance,
    this.isWarning = false,
    this.monthlyInstallment,
    this.installments = const [],
  });

  double get progress => totalAmount > 0 ? paidAmount / totalAmount : 0;
  bool get isCompleted => progress >= 1.0;
}

class InstallmentModel {
  final String id;
  final double amount;
  final DateTime date;
  final String? notes;

  InstallmentModel({
    required this.id,
    required this.amount,
    required this.date,
    this.notes,
  });
}
