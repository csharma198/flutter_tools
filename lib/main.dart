import 'package:flutter/material.dart';
import 'package:flutter_tool/Background/Background_main.dart';
import 'AR_VR/ArSecreen2.dart';
import 'AppSettings/App_Setting.dart';
import 'Chart_Analytics/Chart_Analytics.dart';
import 'ListView/ListView.dart';
import 'PaymentsTools/phonePay.dart';
import 'WebSocket/web_main.dart';
import 'facial_recognition/facial_recognition.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  MyHomePage({super.key});

  final List<Map<String, dynamic>> data = [
    {
      "id": 1,
      "icon": Icons.computer,
      "title": "AR VR",
    },
    {
      "id": 2,
      "icon": Icons.web,
      "title": "Websocket Chat",
    },
    {
      "id": 3,
      "icon": Icons.payment,
      "title": "UPI",
    },
    {
      "id": 4,
      "icon": Icons.settings,
      "title": "App Settings",
    },
    {
      "id": 5,
      "icon": Icons.color_lens_outlined,
      "title": "Background",
    },
    {
      "id": 6,
      "icon": Icons.add_chart,
      "title": "Chart Analytics",
    },
    {
      "id": 7,
      "icon": Icons.format_list_bulleted,
      "title": "Lazy Load ListView",
    },
    {
      "id": 8,
      "icon": Icons.format_list_bulleted,
      "title": "facial recognition",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tools'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (data[index]['id'] == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ARScreen2()),
                );
              } else if (data[index]['id'] == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WebChatMain()),
                );
              } else if (data[index]['id'] == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BankingInterface()),
                );
              } else if (data[index]['id'] == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const App_Setting()),
                );
              }else if (data[index]['id'] == 5) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Background_main()),
                );
              }else if (data[index]['id'] == 6) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChartsPage()),
                );
              }else if (data[index]['id'] == 7) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LazyLoadListView()),
                );
              }else if (data[index]['id'] == 8) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const facial_recognition()),
                );
              }

              print('${data[index]['title']} card tapped');
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 1,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      data[index]['icon'],
                      size: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      data[index]['title'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
