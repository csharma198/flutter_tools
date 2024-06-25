import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chatting extends StatefulWidget {
  const Chatting({super.key});

  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  final TextEditingController _controller = TextEditingController();
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '1', firstName: 'You');
  final _otherUser = const types.User(id: '2', firstName: 'Other');

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _startPollingMessages();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String? messagesJson = prefs.getString('messages');

    if (messagesJson != null) {
      final List<dynamic> messageData = json.decode(messagesJson);

      setState(() {
        _messages.clear();
        for (var data in messageData) {
          final message = _parseMessage(data);
          _messages.add(message);
        }
      });
    }
  }

  void _startPollingMessages() {
    const pollInterval = Duration(seconds: 5); // Adjust as needed

    Timer.periodic(pollInterval, (timer) async {
      await _fetchMessages();
    });
  }

  Future<void> _fetchMessages() async {
    final response = await http
        .get(Uri.parse('https://socket.zilaghaziabad.com/api/messages'));

    if (response.statusCode == 200) {
      final List<dynamic> messageData = json.decode(response.body);

      setState(() {
        _messages.clear();
        for (var data in messageData) {
          final message = _parseMessage(data);
          _messages.add(message);
        }
      });

      _saveMessagesLocally();
    } else {
      print("Failed to fetch messages");
    }
  }

  void _saveMessagesLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final String messagesJson =
        json.encode(_messages.map((e) => _messageToJson(e)).toList());
    prefs.setString('messages', messagesJson);
  }

  Future<void> _sendMessage(String type, String content) async {
    final response = await http.post(
      Uri.parse('https://socket.zilaghaziabad.com/api/messages'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': '1',
        'type': type,
        'content': content,
      }),
    );

    if (response.statusCode == 201) {
      final message = json.decode(response.body);
      final newMessage = _parseMessage(message);

      setState(() {
        _messages.insert(0, newMessage);
      });

      _saveMessagesLocally();
      _controller.clear();
    } else {
      print("Failed to send message");
    }
  }

  types.Message _parseMessage(dynamic data) {
    final String type = data['type'];
    final String content = data['content'];
    final int createdAt =
        DateTime.parse(data['created_at']).millisecondsSinceEpoch;
    final String id = data['id'].toString();
    final author = data['user_id'] == '1' ? _user : _otherUser;

    switch (type) {
      case 'text':
        return types.TextMessage(
          author: author,
          createdAt: createdAt,
          id: id,
          text: content,
        );
      case 'image':
        return types.ImageMessage(
          author: author,
          createdAt: createdAt,
          id: id,
          name: content,
          uri: content,
          size: 14,
        );
      default:
        return types.TextMessage(
          author: author,
          createdAt: createdAt,
          id: id,
          text: content,
        );
    }
  }

  String _messageToJson(types.Message message) {
    switch (message.type) {
      case types.MessageType.text:
        final textMessage = message as types.TextMessage;
        return jsonEncode({
          'type': 'text',
          'content': textMessage.text,
          'created_at':
              DateTime.fromMillisecondsSinceEpoch(textMessage.createdAt ?? 0)
                  .toIso8601String(),
          'id': textMessage.id,
          'user_id': textMessage.author.id,
        });
      case types.MessageType.image:
        final imageMessage = message as types.ImageMessage;
        return jsonEncode({
          'type': 'image',
          'content': imageMessage.uri,
          'created_at':
              DateTime.fromMillisecondsSinceEpoch(imageMessage.createdAt ?? 0)
                  .toIso8601String(),
          'id': imageMessage.id,
          'user_id': imageMessage.author.id,
        });
      default:
        return jsonEncode({
          'type': 'text',
          'content': 'Unsupported message type',
          'created_at': DateTime.now().toIso8601String(),
          'id': message.id,
          'user_id': message.author.id,
        });
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      await _sendMessage('document', file.path);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      await _sendMessage('image', file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatttt'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: chat_ui.Chat(
              messages: _messages,
              onSendPressed: (_) => _sendMessage('text', _controller.text),
              user: _user,
              showUserAvatars: true,
              showUserNames: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: _pickFile,
                ),
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () => _sendMessage('text', _controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
