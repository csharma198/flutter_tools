import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, String>> transactions = [
    {
      'id': 'TXN12345',
      'amount': '₹2000',
      'date': '2024-06-10',
      'status': 'Completed',
    },
    {
      'id': 'TXN12346',
      'amount': '₹1500',
      'date': '2024-06-11',
      'status': 'Pending',
    },
    {
      'id': 'TXN12347',
      'amount': '₹500',
      'date': '2024-06-12',
      'status': 'Failed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                transaction['status'] == 'Completed'
                    ? Icons.check_circle
                    : transaction['status'] == 'Pending'
                    ? Icons.hourglass_empty
                    : Icons.cancel,
                color: transaction['status'] == 'Completed'
                    ? Colors.green
                    : transaction['status'] == 'Pending'
                    ? Colors.orange
                    : Colors.red,
              ),
              title: Text('Transaction ID: ${transaction['id']}'),
              subtitle: Text('Amount: ${transaction['amount']}\nDate: ${transaction['date']}'),
              trailing: Text(transaction['status']!),
            ),
          );
        },
      ),
    );
  }
}