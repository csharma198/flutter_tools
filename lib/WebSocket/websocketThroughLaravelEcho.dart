import 'package:flutter/material.dart';
import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;



class websocketThroughLaravelEcho extends StatefulWidget {
  const websocketThroughLaravelEcho({super.key});

  @override
  _websocketThroughLaravelEchoState createState() => _websocketThroughLaravelEchoState();
}

class _websocketThroughLaravelEchoState extends State<websocketThroughLaravelEcho> {
  late Echo echo;
  List<String> messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize Laravel Echo
    echo = Echo({
      'broadcaster': 'pusher',
      'key': 'your-pusher-app-key',
      'cluster': 'your-pusher-app-cluster',
      'forceTLS': true,
      'client': IO.io,
    } as Connector);

    // Subscribe to the chat channel and listen for messages
    echo.channel('chat').listen('message.sent', (data) {
      setState(() {
        messages.add(data['message']);
      });
    });
  }

  void sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/send-message'),
      body: {'message': message},
    );

    if (response.statusCode == 200) {
      setState(() {
        messages.add(message);
      });
      _controller.clear();
    } else {
      print('Failed to send message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Application'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
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
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    echo.disconnect();
    super.dispose();
  }
}
