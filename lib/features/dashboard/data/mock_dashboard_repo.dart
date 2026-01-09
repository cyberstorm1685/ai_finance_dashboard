import 'package:flutter/material.dart';

class MockDashboardRepo {
  Future<Map<String, dynamic>> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'balance': 12500.0,
      'income': 8000.0,
      'expenses': 4500.0,
      'chartData': [3200.0, 4100.0, 3800.0, 5200.0, 4800.0, 5900.0],
      'categories': ['Food', 'Transport', 'Shopping', 'Entertainment', 'Bills', 'Health'],
      'transactions': List.generate(10, (index) => {
        'id': index.toString(),
        'icon': Icons.shopping_cart,
        'title': 'Trans. ${index + 1}',
        'amount': (index % 2 == 0 ? -150.0 : 200.0) + index * 10,
        'date': 'Jan ${index + 1}',
        'status': index % 3 == 0 ? 'Pending' : 'Completed',
      }),
    };
  }
}