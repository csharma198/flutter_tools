import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  Map<String, dynamic>? _chartData;



  void _loadChartData() {
    const String data = '''
    {
      "lineChart": {
        "points": [
          {"x": 0, "y": 3},
          {"x": 1, "y": 2},
          {"x": 2, "y": 5},
          {"x": 3, "y": 1},
          {"x": 4, "y": 4}
        ]
      },
      "barChart": {
        "bars": [
          {"x": 0, "y": 3},
          {"x": 1, "y": 5},
          {"x": 2, "y": 2},
          {"x": 3, "y": 7},
          {"x": 4, "y": 6}
        ]
      },
      "pieChart": {
        "sections": [
          {"value": 40, "color": "#FF6384"},
          {"value": 30, "color": "#36A2EB"},
          {"value": 20, "color": "#FFCE56"},
          {"value": 10, "color": "#4BC0C0"}
        ]
      },
      "scatterChart": {
        "points": [
          {"x": 1, "y": 1},
          {"x": 2, "y": 4},
          {"x": 3, "y": 2},
          {"x": 4, "y": 5},
          {"x": 5, "y": 3}
        ]
      },
      "radarChart": {
        "dataSets": [
          {
            "color": "#FF6384",
            "entries": [3, 2, 5, 4, 1]
          },
          {
            "color": "#36A2EB",
            "entries": [2, 3, 4, 5, 1]
          }
        ],
        "titles": ["A", "B", "C", "D", "E"]
      },
      "tradingChart": {
        "candlesticks": [
          {"open": 10, "high": 15, "low": 5, "close": 12, "timestamp": 1624531200000},
          {"open": 12, "high": 17, "low": 8, "close": 14, "timestamp": 1624617600000},
          {"open": 14, "high": 20, "low": 10, "close": 16, "timestamp": 1624704000000},
          {"open": 16, "high": 18, "low": 12, "close": 15, "timestamp": 1624790400000},
          {"open": 15, "high": 22, "low": 13, "close": 20, "timestamp": 1624876800000}
        ]
      }
    }
    ''';
    setState(() {
      _chartData = json.decode(data);
    });
  }

  List<Candle> candles = [];
  bool themeIsDark = false;

  @override
  void initState() {
    fetchCandles().then((value) {
      setState(() {
        candles = value;
      });
    });
    _loadChartData();
    super.initState();
  }

  Future<List<Candle>> fetchCandles() async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1h");
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts Page'),
      ),
      body: _chartData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            _buildLineChart(),
            _buildBarChart(),
            _buildPieChart(),
            _buildScatterChart(),
            _buildRadarChart(),
            _buildTradingChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    List<FlSpot> spots = (_chartData!['lineChart']['points'] as List)
        .map((point) => FlSpot(point['x'].toDouble(), point['y'].toDouble()))
        .toList();

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              colors: [Colors.blue],
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    List<BarChartGroupData> barGroups = (_chartData!['barChart']['bars'] as List)
        .map((bar) => BarChartGroupData(
      x: bar['x'],
      barRods: [
        BarChartRodData(
          y: bar['y'].toDouble(),
          colors: [Colors.orange],
        )
      ],
    ))
        .toList();

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    List<PieChartSectionData> sections = (_chartData!['pieChart']['sections'] as List)
        .map((section) => PieChartSectionData(
      value: section['value'].toDouble(),
      color: Color(int.parse(section['color'].substring(1, 7), radix: 16) + 0xFF000000),
      title: '${section['value']}%',
    ))
        .toList();

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sections: sections,
        ),
      ),
    );
  }

  Widget _buildScatterChart() {
    List<ScatterSpot> spots = (_chartData!['scatterChart']['points'] as List)
        .map((point) => ScatterSpot(point['x'].toDouble(), point['y'].toDouble()))
        .toList();

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: ScatterChart(
        ScatterChartData(
          scatterSpots: spots,
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 6,
          borderData: FlBorderData(show: true),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: true),
        ),
      ),
    );
  }

  Widget _buildRadarChart() {
    List<RadarDataSet> dataSets = (_chartData!['radarChart']['dataSets'] as List)
        .map((dataSet) => RadarDataSet(
      fillColor: Color(int.parse(dataSet['color'].substring(1, 7), radix: 16) + 0xFF000000).withOpacity(0.4),
      borderColor: Color(int.parse(dataSet['color'].substring(1, 7), radix: 16) + 0xFF000000),
      entryRadius: 3,
      dataEntries: (dataSet['entries'] as List)
          .map((entry) => RadarEntry(value: entry.toDouble()))
          .toList(),
    ))
        .toList();

    List<String> titles = List<String>.from(_chartData!['radarChart']['titles']);

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: RadarChart(
        RadarChartData(
          dataSets: dataSets,
          radarBorderData: const BorderSide(color: Colors.transparent),
          titlePositionPercentageOffset: 0.2,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
          getTitle: (index) => titles[index],
        ),
      ),
    );
  }

  Widget _buildTradingChart() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Candlesticks(
          candles: candles,
        ),
      ),

    );
  }


}

