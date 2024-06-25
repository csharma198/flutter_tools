import 'package:flutter/material.dart';
import 'package:flutter_tool/PaymentsTools/widgets/ToAccountScreen.dart';

import 'widgets/BankBalanceScreen.dart';
import 'widgets/NotificationsScreen.dart';
import 'widgets/ToContactScreen.dart';

class BankingInterface extends StatelessWidget {
  const BankingInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banking App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  NotificationsScreen()),
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
                      const CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://placehold.co/50'),
                      ),
                      const Text('Username'),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Money Transfers',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTransferOption(context, Icons.person, 'To Contact',
                           ToContactScreen()),
                      _buildTransferOption(context, Icons.account_balance,
                          'To Account', const ToAccountScreen()),
                      _buildTransferOption(context, Icons.person_outline,
                          'To Self', const ToSelfScreen()),
                      _buildTransferOption(
                          context,
                          Icons.account_balance_wallet,
                          'Bank Balance',
                          const BankBalanceScreen()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildContactAvatar('Aishwarya'),
                      _buildContactAvatar('Abhishek'),
                      _buildContactAvatar('Rahul'),
                      _buildContactAvatar('Pradeep'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFeatureCard(context, Icons.local_offer,
                          'View All OFFERS', const OffersScreen()),
                      _buildFeatureCard(context, Icons.card_giftcard,
                          'View My REWARDS', const RewardsScreen()),
                      _buildFeatureCard(context, Icons.money,
                          'Refer & Earn Min. ₹100', const ReferEarnScreen()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Recharge & Pay Bills',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildServiceIcon(context, Icons.phone_android,
                          'Recharge', const RechargeScreen()),
                      _buildServiceIcon(context, Icons.tv, 'DTH', const DTHScreen()),
                      _buildServiceIcon(context, Icons.electrical_services,
                          'Electricity', const ElectricityScreen()),
                      _buildServiceIcon(context, Icons.credit_card,
                          'Credit Card', const CreditCardScreen()),
                      _buildServiceIcon(
                          context, Icons.phone, 'Postpaid', const PostpaidScreen()),
                      _buildServiceIcon(context, Icons.phone_in_talk,
                          'Landline', const LandlineScreen()),
                      _buildServiceIcon(
                          context, Icons.wifi, 'Broadband', const BroadbandScreen()),
                      _buildServiceIcon(
                          context, Icons.local_gas_station, 'Gas', const GasScreen()),
                      _buildServiceIcon(
                          context, Icons.water, 'Water', const WaterScreen()),
                      _buildServiceIcon(context, Icons.directions_car,
                          'Datacard', const DatacardScreen()),
                      _buildServiceIcon(
                          context, Icons.home, 'Insurance', const InsuranceScreen()),
                      _buildServiceIcon(context, Icons.account_balance,
                          'Municipal Tax', const MunicipalTaxScreen()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildContactAvatar(String name) {
    return Column(
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage('https://placehold.co/50'),
        ),
        const SizedBox(height: 5),
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
      child: SizedBox(
        width: 100,
        height: 100,
        child: Card(
          color: Colors.purple,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(height: 5),
                Text(label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white)),
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
          const SizedBox(height: 5),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// Placeholder Screens for Navigation

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen')),
    );
  }
}

class ToSelfScreen extends StatelessWidget {
  const ToSelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To Self')),
      body: const Center(child: Text('To Self Screen')),
    );
  }
}

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View All OFFERS')),
      body: const Center(child: Text('Offers Screen')),
    );
  }
}

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View My REWARDS')),
      body: const Center(child: Text('Rewards Screen')),
    );
  }
}

class ReferEarnScreen extends StatelessWidget {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Refer & Earn')),
      body: const Center(child: Text('Refer & Earn Screen')),
    );
  }
}

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recharge')),
      body: const Center(child: Text('Recharge Screen')),
    );
  }
}

class DTHScreen extends StatelessWidget {
  const DTHScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DTH')),
      body: const Center(child: Text('DTH Screen')),
    );
  }
}

class ElectricityScreen extends StatelessWidget {
  const ElectricityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Electricity')),
      body: const Center(child: Text('Electricity Screen')),
    );
  }
}

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credit Card')),
      body: const Center(child: Text('Credit Card Screen')),
    );
  }
}

class PostpaidScreen extends StatelessWidget {
  const PostpaidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Postpaid')),
      body: const Center(child: Text('Postpaid Screen')),
    );
  }
}

class LandlineScreen extends StatelessWidget {
  const LandlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Landline')),
      body: const Center(child: Text('Landline Screen')),
    );
  }
}

class BroadbandScreen extends StatelessWidget {
  const BroadbandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Broadband')),
      body: const Center(child: Text('Broadband Screen')),
    );
  }
}

class GasScreen extends StatelessWidget {
  const GasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gas')),
      body: const Center(child: Text('Gas Screen')),
    );
  }
}

class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water')),
      body: const Center(child: Text('Water Screen')),
    );
  }
}

class DatacardScreen extends StatelessWidget {
  const DatacardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datacard')),
      body: const Center(child: Text('Datacard Screen')),
    );
  }
}

class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insurance')),
      body: const Center(child: Text('Insurance Screen')),
    );
  }
}

class MunicipalTaxScreen extends StatelessWidget {
  const MunicipalTaxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Municipal Tax')),
      body: const Center(child: Text('Municipal Tax Screen')),
    );
  }
}
