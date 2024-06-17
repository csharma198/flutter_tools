import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToContactScreen extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {'name': 'Aishwarya', 'image': 'https://placehold.co/50'},
    {'name': 'Abhishek', 'image': 'https://placehold.co/50'},
    {'name': 'Rahul', 'image': 'https://placehold.co/50'},
    {'name': 'Pradeep', 'image': 'https://placehold.co/50'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To Contact')),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contact['image']!),
            ),
            title: Text(contact['name']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailScreen(contact: contact),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactDetailScreen extends StatefulWidget {
  final Map<String, String> contact;

  ContactDetailScreen({required this.contact});

  @override
  _ContactDetailScreenState createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  TextEditingController _amountController = TextEditingController();
  List<String> _transactions = [];
  final ValueNotifier<bool> _isAmountEntered = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _loadTransactions();
    _amountController.addListener(() {
      _isAmountEntered.value = _amountController.text.isNotEmpty;
    });
  }

  Future<void> _loadTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _transactions = prefs.getStringList('transactions_${widget.contact['name']}') ?? _generateDummyTransactions();
    });
  }

  List<String> _generateDummyTransactions() {
    return [
      'Sent ₹100 to ${widget.contact['name']}',
      'Received ₹150 from ${widget.contact['name']}',
      'Sent ₹200 to ${widget.contact['name']}',
      'Received ₹250 from ${widget.contact['name']}',
      'Sent ₹300 to ${widget.contact['name']}',
    ];
  }

  Future<void> _storeTransaction(String transaction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _transactions.add(transaction);
    await prefs.setStringList('transactions_${widget.contact['name']}', _transactions);
  }

  void _sendMoney() {
    if (_amountController.text.isNotEmpty) {
      String transaction = 'Sent ₹${_amountController.text} to ${widget.contact['name']}';
      _storeTransaction(transaction);
      _amountController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Money transferred successfully'),
      ));
      setState(() {});
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _isAmountEntered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with ${widget.contact['name']}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.grey[300] : Colors.purple[100],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(_transactions[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8.0),
                ValueListenableBuilder<bool>(
                  valueListenable: _isAmountEntered,
                  builder: (context, isAmountEntered, child) {
                    return AnimatedOpacity(
                      opacity: isAmountEntered ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 300),
                      child: ElevatedButton(
                        onPressed: _sendMoney,
                        child: Icon(Icons.send, color: Colors.white,),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), backgroundColor: Colors.purple,
                          padding: EdgeInsets.all(14), // Background color
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
