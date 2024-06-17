import 'package:flutter/material.dart';


class BankBalanceScreen extends StatefulWidget {
  @override
  _BankBalanceScreenState createState() => _BankBalanceScreenState();
}

class _BankBalanceScreenState extends State<BankBalanceScreen> {
  List<Map<String, dynamic>> _bankAccounts = [
    {
      'bankName': 'XYZ Bank',
      'accountNumber': 'XXXX-XXXX-1234',
      'balance': 50000.0,
      'image':
          'https://example.com/xyz_bank_logo.png',
    },
    {
      'bankName': 'ABC Bank',
      'accountNumber': 'XXXX-XXXX-5678',
      'balance': 75000.0,
      'image':
          'https://example.com/abc_bank_logo.png',
    },
  ];

  String _pin = '';
  bool _showBalance = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bank Balance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Linked Bank Accounts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (!_showBalance)
              Expanded(
                // Ensure ListView is expanded to avoid overflow
                child: ListView.builder(
                  itemCount: _bankAccounts.length,
                  itemBuilder: (context, index) {
                    final account = _bankAccounts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(account['image'] ?? ''),
                      ),
                      title: Text('${account['bankName']}'),
                      subtitle: Text('Account: ${account['accountNumber']}'),
                      onTap: () {
                        _showPinDialog(context);
                      },
                    );
                  },
                ),
              ),
            if (_showBalance) ...[
              SizedBox(height: 20),
              Text(
                'Account Balance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 1, // Only show balance for one account
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final account = _bankAccounts[index];
                  return Card(
                    child: ListTile(
                      title: Text('Balance: \$ ${account['balance']}'),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Transaction History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10, // Dummy transaction data

                  itemBuilder: (context, index) {
                    final transaction = index % 2 == 0 ? 'Received' : 'Sent';
                    final color = index % 2 == 0 ? Colors.green : Colors.red;
                    return Card(
                      color: color,
                      child: ListTile(
                        title: Text('Transaction $index: $transaction'),
                        subtitle: Text('Date: ${DateTime.now().toString()}'),
                      ),
                    );
                  },
                ),
              )
            ],
          ],
        ),
      ),
    );
  }

  void _showPinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            // This allows updating the state within the dialog
            builder: (context, setState) {
          return AlertDialog(
            title: Text('Enter PIN'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  _pin = value;
                });
              },
              keyboardType: TextInputType.number,
              maxLength: 6,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your 6-digit PIN',
                counterText: '',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed:
                    _pin.length == 6 ? () => _checkBalance(context) : null,
                child: Text('Confirm'),
              ),
            ],
          );
        });
      },
    );
  }

  void _checkBalance(BuildContext context) {
    if (_pin == '123456') {
      setState(() {
        _showBalance = true;
      });
      Navigator.of(context).pop(); // Close PIN dialog
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid PIN. Please try again.'),
        backgroundColor: Colors.red,
      ));
    }
  }
}

class AccountBalanceDashboard extends StatelessWidget {
  final List<Map<String, dynamic>> accounts;

  AccountBalanceDashboard({required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Balance Dashboard')),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          final account = accounts[index];
          return Card(
            child: ListTile(
              title: Text('${account['bankName']}'),
              subtitle: Text('Account: ${account['accountNumber']}'),
              trailing: Text('\$ ${account['balance']}'),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), label: 'Balance'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Transaction History'),
        ],
      ),
    );
  }
}
