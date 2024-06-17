import 'package:flutter/material.dart';
import 'package:flutter_tool/PaymentsTools/widgets/ToAccountScreen.dart';

import 'widgets/BankBalanceScreen.dart';
import 'widgets/NotificationsScreen.dart';
import 'widgets/ToContactScreen.dart';

class BankingInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banking App'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://placehold.co/50'),
                      ),
                      Text('Username'),
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Money Transfers',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTransferOption(context, Icons.person, 'To Contact',
                          ToContactScreen()),
                      _buildTransferOption(context, Icons.account_balance,
                          'To Account', ToAccountScreen()),
                      _buildTransferOption(context, Icons.person_outline,
                          'To Self', ToSelfScreen()),
                      _buildTransferOption(
                          context,
                          Icons.account_balance_wallet,
                          'Bank Balance',
                          BankBalanceScreen()),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildContactAvatar('Aishwarya'),
                      _buildContactAvatar('Abhishek'),
                      _buildContactAvatar('Rahul'),
                      _buildContactAvatar('Pradeep'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFeatureCard(context, Icons.local_offer,
                          'View All OFFERS', OffersScreen()),
                      _buildFeatureCard(context, Icons.card_giftcard,
                          'View My REWARDS', RewardsScreen()),
                      _buildFeatureCard(context, Icons.money,
                          'Refer & Earn Min. ₹100', ReferEarnScreen()),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Recharge & Pay Bills',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildServiceIcon(context, Icons.phone_android,
                          'Recharge', RechargeScreen()),
                      _buildServiceIcon(context, Icons.tv, 'DTH', DTHScreen()),
                      _buildServiceIcon(context, Icons.electrical_services,
                          'Electricity', ElectricityScreen()),
                      _buildServiceIcon(context, Icons.credit_card,
                          'Credit Card', CreditCardScreen()),
                      _buildServiceIcon(
                          context, Icons.phone, 'Postpaid', PostpaidScreen()),
                      _buildServiceIcon(context, Icons.phone_in_talk,
                          'Landline', LandlineScreen()),
                      _buildServiceIcon(
                          context, Icons.wifi, 'Broadband', BroadbandScreen()),
                      _buildServiceIcon(
                          context, Icons.local_gas_station, 'Gas', GasScreen()),
                      _buildServiceIcon(
                          context, Icons.water, 'Water', WaterScreen()),
                      _buildServiceIcon(context, Icons.directions_car,
                          'Datacard', DatacardScreen()),
                      _buildServiceIcon(
                          context, Icons.home, 'Insurance', InsuranceScreen()),
                      _buildServiceIcon(context, Icons.account_balance,
                          'Municipal Tax', MunicipalTaxScreen()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history, color: Colors.black), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet, color: Colors.black),
              label: 'Wallet'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildTransferOption(
      BuildContext context, IconData icon, String label, Widget screen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple,
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildContactAvatar(String name) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('https://placehold.co/50'),
        ),
        SizedBox(height: 5),
        Text(name),
      ],
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, IconData icon, String label, Widget screen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        child: Card(
          color: Colors.purple,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(height: 5),
                Text(label,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceIcon(
      BuildContext context, IconData icon, String label, Widget screen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.purple),
          SizedBox(height: 5),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// Placeholder Screens for Navigation

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings Screen')),
    );
  }
}

class ToSelfScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To Self')),
      body: Center(child: Text('To Self Screen')),
    );
  }
}

class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View All OFFERS')),
      body: Center(child: Text('Offers Screen')),
    );
  }
}

class RewardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View My REWARDS')),
      body: Center(child: Text('Rewards Screen')),
    );
  }
}

class ReferEarnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Refer & Earn')),
      body: Center(child: Text('Refer & Earn Screen')),
    );
  }
}

class RechargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recharge')),
      body: Center(child: Text('Recharge Screen')),
    );
  }
}

class DTHScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DTH')),
      body: Center(child: Text('DTH Screen')),
    );
  }
}

class ElectricityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Electricity')),
      body: Center(child: Text('Electricity Screen')),
    );
  }
}

class CreditCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Credit Card')),
      body: Center(child: Text('Credit Card Screen')),
    );
  }
}

class PostpaidScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Postpaid')),
      body: Center(child: Text('Postpaid Screen')),
    );
  }
}

class LandlineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Landline')),
      body: Center(child: Text('Landline Screen')),
    );
  }
}

class BroadbandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Broadband')),
      body: Center(child: Text('Broadband Screen')),
    );
  }
}

class GasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gas')),
      body: Center(child: Text('Gas Screen')),
    );
  }
}

class WaterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Water')),
      body: Center(child: Text('Water Screen')),
    );
  }
}

class DatacardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Datacard')),
      body: Center(child: Text('Datacard Screen')),
    );
  }
}

class InsuranceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insurance')),
      body: Center(child: Text('Insurance Screen')),
    );
  }
}

class MunicipalTaxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Municipal Tax')),
      body: Center(child: Text('Municipal Tax Screen')),
    );
  }
}
