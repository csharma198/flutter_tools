import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToAccountScreen extends StatefulWidget {
  const ToAccountScreen({super.key});

  @override
  _ToAccountScreenState createState() => _ToAccountScreenState();
}

class _ToAccountScreenState extends State<ToAccountScreen> {
  List<Map<String, String>> _accounts = [];

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountList = prefs.getStringList('accounts');
    if (accountList != null) {
      setState(() {
        _accounts = accountList
            .map((accountString) => _decodeAccount(accountString))
            .toList();
      });
    }
  }

  Map<String, String> _decodeAccount(String accountString) {
    List<String> accountData = accountString.split(';');
    return {
      'name': accountData[0].split(':')[1],
      'bank': accountData[1].split(':')[1],
      'account': accountData[2].split(':')[1],
      'mobile': accountData[3].split(':')[1],
    };
  }

  Future<void> _addAccount(Map<String, String> account) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accounts.add(account);
    List<String> accountList =
        _accounts.map((acc) => _encodeAccount(acc)).toList();
    prefs.setStringList('accounts', accountList);
    setState(() {}); // Update UI with new account
  }

  String _encodeAccount(Map<String, String> account) {
    return 'name:${account['name']};bank:${account['bank']};account:${account['account']};mobile:${account['mobile']}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To Account')),
      body: ListView.builder(
          itemCount: _accounts.length,
          itemBuilder: (context, index) {
            final account = _accounts[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ContactDetailScreenToBank(contact: account),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage('https://placehold.co/50'),
                      radius: 24,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${account['name']} (${account['bank']})',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Account: ${account['account']}'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAccountScreen(),
            ),
          );
          _loadAccounts(); // Reload accounts after adding
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddAccountScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _confirmAccountController =
      TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _holderNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  AddAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _bankController,
              decoration: const InputDecoration(labelText: 'Bank Name'),
            ),
            TextFormField(
              controller: _accountController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            TextFormField(
              controller: _confirmAccountController,
              decoration: const InputDecoration(labelText: 'Confirm Account Number'),
            ),
            TextFormField(
              controller: _ifscController,
              decoration: const InputDecoration(labelText: 'IFSC Code'),
            ),
            TextFormField(
              controller: _holderNameController,
              decoration: const InputDecoration(labelText: 'Account Holder Name'),
            ),
            TextFormField(
              controller: _mobileController,
              decoration: const InputDecoration(labelText: 'Mobile Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate and add account
                if (_accountController.text == _confirmAccountController.text) {
                  Map<String, String> newAccount = {
                    'name': _nameController.text,
                    'bank': _bankController.text,
                    'account': _accountController.text,
                    'ifsc': _ifscController.text,
                    'holderName': _holderNameController.text,
                    'mobile': _mobileController.text,
                  };
                  _saveAccount(newAccount);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Account numbers do not match'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: const Text('Add Account'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveAccount(Map<String, String> account) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountList = prefs.getStringList('accounts') ?? [];
    accountList.add(_encodeAccount(account));
    prefs.setStringList('accounts', accountList);
  }

  String _encodeAccount(Map<String, String> account) {
    return 'name:${account['name']};bank:${account['bank']};account:${account['account']};mobile:${account['mobile']}';
  }

  void dispose() {
    _nameController.dispose();
    _bankController.dispose();
    _accountController.dispose();
    _confirmAccountController.dispose();
    _ifscController.dispose();
    _holderNameController.dispose();
    _mobileController.dispose();
    //super.dispose();
  }
}

class ContactDetailScreenToBank extends StatefulWidget {
  final Map<String, String> contact;

  const ContactDetailScreenToBank({super.key, required this.contact});

  @override
  _ContactDetailScreenToBankState createState() =>
      _ContactDetailScreenToBankState();
}

class _ContactDetailScreenToBankState extends State<ContactDetailScreenToBank> {
  final TextEditingController _amountController = TextEditingController();
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
      _transactions =
          prefs.getStringList('transactions_${widget.contact['name']}') ??
              _generateDummyTransactions();
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
    await prefs.setStringList(
        'transactions_${widget.contact['name']}', _transactions);
  }

  void _sendMoney() {
    if (_amountController.text.isNotEmpty) {
      String transaction =
          'Sent ₹${_amountController.text} to ${widget.contact['name']}';
      _storeTransaction(transaction);
      _amountController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
              padding: const EdgeInsets.all(16.0),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color:
                        index % 2 == 0 ? Colors.grey[300] : Colors.purple[100],
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
                    decoration: const InputDecoration(
                      hintText: 'Enter amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8.0),
                ValueListenableBuilder<bool>(
                  valueListenable: _isAmountEntered,
                  builder: (context, isAmountEntered, child) {
                    return AnimatedOpacity(
                      opacity: isAmountEntered ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: ElevatedButton(
                        onPressed: _sendMoney,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(), backgroundColor: Colors.purple,
                          padding: const EdgeInsets.all(14), // Background color
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
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
