
import 'package:flutter/material.dart';

import 'Screens/Background1.dart';

class Background_main extends StatelessWidget {
  Background_main({super.key});

  final List<Map<String, dynamic>> data = [
    {
      "id": 1,
      "icon": Icons.computer,
      "title": "Background 1",
    },
    {
      "id": 2,
      "icon": Icons.web,
      "title": "Background 2",
    },
    {
      "id": 3,
      "icon": Icons.payment,
      "title": "Background 3",
    },
    {
      "id": 4,
      "icon": Icons.settings,
      "title": "Background 4",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background'),
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
                  MaterialPageRoute(builder: (context) => const Background1()),
                );
              } else if (data[index]['id'] == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Background1()),
                );
              } else if (data[index]['id'] == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Background1()),
                );
              } else if (data[index]['id'] == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Background1()),
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