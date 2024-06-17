import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tool/PaymentsTools/phonePay.dart';


class WebSocketChatScreen extends StatefulWidget {
  const WebSocketChatScreen({super.key});

  @override
  _WebSocketChatScreenState createState() => _WebSocketChatScreenState();
}

class _WebSocketChatScreenState extends State<WebSocketChatScreen> {
  final TextEditingController _controller = TextEditingController();
  IOWebSocketChannel? _channel;
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user', firstName: 'You');
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    setState(() {
      _isConnecting = true;
    });

    try {
      // _channel = IOWebSocketChannel.connect('wss://echo.websocket.events');
      _channel = IOWebSocketChannel.connect('wss://socket.zilaghaziabad.com:6001');

      _channel!.stream.listen(
            (message) {
          setState(() {
            final textMessage = types.TextMessage(
              author: _user,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              id: Uuid().v4(),
              text: message,
            );
            _messages.insert(0, textMessage);
          });
          print("WebSocket message received: $message");
        },
        onError: (error) {
          print("WebSocket Error: $error");
          _retryConnection();
        },
        onDone: () {
          print("WebSocket connection closed");
          _retryConnection();
        },
      );
      print("WebSocket connection established");
    } catch (e) {
      print("WebSocket connection failed: $e");
      _retryConnection();
    } finally {
      setState(() {
        _isConnecting = false;
      });
    }
  }

  void _retryConnection() {
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        _connectWebSocket();
      }
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty && _channel != null) {
      final textMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: Uuid().v4(),
        text: _controller.text,
      );

      setState(() {
        _messages.insert(0, textMessage);
      });

      _channel?.sink.add(_controller.text);
      print("Message sent: ${_controller.text}");
      _controller.clear();
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: Uuid().v4(),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: file.path,
      );

      setState(() {
        _messages.insert(0, message);
      });

      // Send file path or data through WebSocket
      _channel?.sink.add(file.path);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: Uuid().v4(),
        name: pickedFile.name,
        size: await file.length(),
        uri: file.path,
      );

      setState(() {
        _messages.insert(0, message);
      });

      // Send file path or data through WebSocket
      _channel?.sink.add(file.path);
    }
  }

  @override
  void dispose() {
    if (_channel != null) {
      _channel!.sink.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: chat_ui.Chat(
              messages: _messages,
              onSendPressed: (_) => _sendMessage(),
              user: _user,
              showUserAvatars: true,
              showUserNames: true,
              theme: chat_ui.DefaultChatTheme(
                inputBackgroundColor: Colors.blue.shade50,
                primaryColor: Colors.blue,
                userAvatarNameColors: [Colors.orange, Colors.green],
                //   userBubbleColor: Colors.blue.shade200,
                //   userTextColor: Colors.white,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          if (_isConnecting)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 10),
                  Text("Connecting..."),
                ],
              ),
            ),
          if (!_isConnecting)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.attach_file, color: Colors.blue),
                    onPressed: _pickFile,
                  ),
                  IconButton(
                    icon: Icon(Icons.photo, color: Colors.blue),
                    onPressed: _pickImage,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}