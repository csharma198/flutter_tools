import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widget/BackColors.dart';


class Background1 extends StatefulWidget {
  const Background1({super.key});

  @override
  State<Background1> createState() => _Background1State();
}

class _Background1State extends State<Background1> {


  int totalWorkers = 25;
  int totalOpenTickets = 10;
  int totalFreelancers = 15;
  int totalBranches = 5;

  Future<void> _refreshData() async {
    setState(() {
      totalWorkers += 5;
      totalOpenTickets += 2;
      totalFreelancers += 3;
      totalBranches += 1;
    });
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackColors(),
        SafeArea(
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountCard(String title, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black), // Added black border
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center alignment
        crossAxisAlignment: CrossAxisAlignment.center, // Center alignment
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBranchListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalBranches,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Site ${index + 1}"),
          subtitle: const Text("Location: Dummy Location"),
          leading: const Icon(Icons.business, color: Colors.blueAccent),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
       /*     Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BranchDashboard(branch_name: '${index + 1}'),
              ),
            );*/
          },
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Employee Distribution",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Colors.blue,
                    value: totalWorkers.toDouble(),
                    title: 'Workers',
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.red,
                    value: totalOpenTickets.toDouble(),
                    title: 'Tickets',
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.green,
                    value: totalFreelancers.toDouble(),
                    title: 'Freelancers',
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.orange,
                    value: totalBranches.toDouble(),
                    title: 'Branches',
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Performance Overview",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BarChart(
              BarChartData(
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        y: totalWorkers.toDouble(),
                        colors: [Colors.blue],
                        width: 15,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        y: totalOpenTickets.toDouble(),
                        colors: [Colors.red],
                        width: 15,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        y: totalFreelancers.toDouble(),
                        colors: [Colors.green],
                        width: 15,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        y: totalBranches.toDouble(),
                        colors: [Colors.orange],
                        width: 15,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                      ),
                    ],
                  ),
                ],
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) =>
                    const TextStyle(color: Colors.black, fontSize: 12),
                    margin: 10,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Workers';
                        case 1:
                          return 'Tickets';
                        case 2:
                          return 'Freelancers';
                        case 3:
                          return 'Branches';
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(showTitles: false),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
